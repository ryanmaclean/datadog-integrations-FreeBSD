# $FreeBSD: head/sysutils/datadog-integrations/Makefile 560794 2021-01-08 16:36:02Z mikael $

PORTNAME=	datadog-integrations
DISTVERSION=	7.24.0
CATEGORIES=	sysutils

MAINTAINER=	uros@gruber.si
COMMENT=	Datadog Agent Integrations

LICENSE=	BSD3CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}setuptools>0:devel/py-setuptools@${PY_FLAVOR}

RUN_DEPENDS=	datadog-agent>=7.24.1:sysutils/datadog-agent \
		${PYTHON_PKGNAMEPREFIX}botocore>0:devel/py-botocore@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pysocks>0:net/py-pysocks@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}dateutil>0:devel/py-dateutil@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}pytz>0:devel/py-pytz@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests-unixsocket>0:www/py-requests-unixsocket@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}simplejson>0:devel/py-simplejson@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests>0:www/py-requests@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests-toolbelt>0:www/py-requests-toolbelt@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}yaml>0:devel/py-yaml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}uptime>0:sysutils/py-uptime@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}typing-extensions>0:devel/py-typing-extensions@${PY_FLAVOR}

USES=		python:3.7+
USE_GITHUB=	yes
GH_ACCOUNT=	DataDog
GH_PROJECT=	integrations-core
GH_TAGNAME=	${DISTVERSION}

ETCDIR=		${PREFIX}/etc/datadog

NO_ARCH=	yes

USERS=		datadog
GROUPS=		${USERS}

PLIST_SUB+=	USER=${USERS} \
		GROUP=${GROUPS}

OPTIONS_DEFINE=	APACHE CONSUL COREDNS DIRECTORY DISK DNS MYSQL NETWORK NGINX PHP POSTFIX PROCESS REDIS SSH SYS_CORE SYS_SWAP TCP TLS

OPTIONS_SUB=	yes

APACHE_DESC=	Apache check integration
CONSUL_DESC=	Consul check integration
COREDNS_DESC=	CoreDNS check integration
DIRECTORY_DESC=	Directory check integration
DISK_DESC=	Disk check integration
DNS_DESC=	DNS check integration
MYSQL_DESC=	MySQL check integration
NETWORK_DESC=	Network check integration
NGINX_DESC=	Nginx check integration
PHP_DESC=	PHP-fpm check integration
POSTFIX_DESC=	Postfix check integration
PROCESS_DESC=	Process check integration
REDIS_DESC=	Redis check integration
SSH_DESC=	SSH check integration
SYS_CORE_DESC=	System Core check integration
SYS_SWAP_DESC=	System Swap check integration
TCP_DESC=	TCP check integration
TLS_DESC=	TLS check integration

APACHE_VARS=	INTEGRATIONS+=apache CONFFILES+=apache
CONSUL_VARS=	INTEGRATIONS+=consul CONFFILES+=consul
COREDNS_VARS=	INTEGRATIONS+=coredns CONFFILES+=coredns
DIRECTORY_VARS=	INTEGRATIONS+=directory CONFFILES+=directory
DISK_VARS=	INTEGRATIONS+=disk CONFFILES+=disk
DNS_VARS=	INTEGRATIONS+=dns_check CONFFILES+=dns_check
MYSQL_VARS=	INTEGRATIONS+=mysql CONFFILES+=mysql
NETWORK_VARS=	INTEGRATIONS+=network CONFFILES+=network
NGINX_VARS=	INTEGRATIONS+=nginx CONFFILES+=nginx
PHP_VARS=	INTEGRATIONS+=php_fpm CONFFILES+=php_fpm
POSTFIX_VARS=	INTEGRATIONS+=postfix CONFFILES+=postfix
PROCESS_VARS=	INTEGRATIONS+=process CONFFILES+=process
REDIS_VARS=	INTEGRATIONS+=redisdb CONFFILES+=redisdb
SSH_VARS=	INTEGRATIONS+=ssh_check CONFFILES+=ssh_check
SYS_CORE_VARS=	INTEGRATIONS+=system_core CONFFILES+=system_core
SYS_SWAP_VARS=	INTEGRATIONS+=system_swap CONFFILES+=system_swap
TCP_VARS=	INTEGRATIONS+=tcp_check CONFFILES+=tcp_check
TLS_VARS=	INTEGRATIONS+=tls CONFFILES+=tls

# find integrations-core -name setup.py | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
INTEGRATIONS=	datadog_checks_base

# find integrations-core -name conf.yaml.example | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
CONFFILES=

DIRECTORY_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}scandir>0:sysutils/py-scandir@${PY_FLAVOR}
DISK_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
DNS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}dnspython>0:dns/py-dnspython@${PY_FLAVOR}
MYSQL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
			${PYTHON_PKGNAMEPREFIX}pymysql>0:databases/py-pymysql@${PY_FLAVOR}
NETWORK_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
PHP_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}flup6>0:www/py-flup6@${PY_FLAVOR}
PROCESS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
REDIS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}redis>0:databases/py-redis@${PY_FLAVOR}
SSH_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}paramiko>0:security/py-paramiko@${PY_FLAVOR}
SYS_CORE_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
SYS_SWAP_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
TLS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
			${PYTHON_PKGNAMEPREFIX}service_identity>0:security/py-service_identity@${PY_FLAVOR}

.include <bsd.port.options.mk>

do-install:
	${MKDIR} ${STAGEDIR}${ETCDIR}
	${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d

# Install core-integrations
.for dir in ${INTEGRATIONS}
	(cd ${WRKSRC}/${dir}; \
	${PYTHON_CMD} setup.py bdist; \
	${TAR} -xzf dist/*.tar.gz -C ${STAGEDIR})
.endfor

post-install:
# Install core-integrations
.for dir in ${CONFFILES}
	(cd ${WRKSRC}/${dir}; \
	${MV} datadog_checks/${dir}/data ${STAGEDIR}${ETCDIR}/conf.d/${dir}.d)
.endfor

.include <bsd.port.mk>
