package cert

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"os"
	"strings"

	"github.com/gwaylib/conf"
	"github.com/gwaylib/errors"
	"github.com/gwaylib/log"
)

var (
	tlsConfig = &tls.Config{}
)

func init() {
	if err := loadServerCert(); err != nil {
		log.Warn(errors.As(err))
	}
}

func GetTLSConfig() *tls.Config {
	return tlsConfig
}

// 按域名加载证书
func addServerCert(cert tls.Certificate) error {
	if tlsConfig.Certificates == nil {
		tlsConfig.Certificates = make([]tls.Certificate, 0)
	}
	tlsConfig.Certificates = append(tlsConfig.Certificates, cert)

	// build name
	if tlsConfig.NameToCertificate == nil {
		tlsConfig.NameToCertificate = make(map[string]*tls.Certificate)
	}
	x509Cert, err := x509.ParseCertificate(cert.Certificate[0])
	if err != nil {
		return errors.As(err)
	}
	if len(x509Cert.Subject.CommonName) > 0 {
		tlsConfig.NameToCertificate[x509Cert.Subject.CommonName] = &cert
	}
	for _, san := range x509Cert.DNSNames {
		tlsConfig.NameToCertificate[san] = &cert
	}
	return nil
}

// 加载所有证书
func loadServerCert() error {
	// 找出所有证书文件名称
	path := conf.RootDir() + "/etc/cert/"
	f, err := os.Open(path)
	if err != nil {
		return errors.As(err)
	}
	filesNames, err := f.Readdirnames(-1)
	if err != nil {
		return errors.As(err)
	}
	defer f.Close()
	for _, name := range filesNames {
		host := strings.Split(name, ".crt")
		if len(host) > 1 {
			certFile := path + host[0] + ".crt"
			keyFile := path + host[0] + ".key"
			cert, err := tls.LoadX509KeyPair(certFile, keyFile)
			if err != nil {
				return errors.As(err, name)
			}
			if err := addServerCert(cert); err != nil {
				return errors.As(err, name)
			}
			fmt.Printf("Loaded tls crt: %s\n", host)
			continue
		}
	}
	// 加载完成
	return nil
}
