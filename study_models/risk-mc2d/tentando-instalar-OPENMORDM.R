# Teste para Instalar o OpenMORDM:
library(devtools)
install_github("OpenMORDM/OpenMORDM")

# Baixou v�rias coisas e instalou, mas deu ERRO NO rdyncall
#  package 'rdyncall' is not available (for R version 3.3.1

# As sugest�es do Github s�o pra insatalar do arquivo:


# Sugest�o econtrada aqui:
# https://stackoverflow.com/questions/24194409/how-do-i-install-a-package-that-has-been-archived-from-cran
# Download package tarball from CRAN archive

url <- "https://cran.r-project.org/src/contrib/Archive/rdyncall/rdyncall_0.7.5.tar.gz"
pkgFile <- "rdyncall_0.7.5.tar.gz"
download.file(url = url, destfile = pkgFile)

# Install dependencies

# N�o sei quais s�o as depend�ncias, vamos tentar sem
# install.packages(c("ada", "ipred", "evd"))

# Install package
install.packages(pkgs=pkgFile, type="source", repos=NULL)

# Delete package tarball
unlink(pkgFile)