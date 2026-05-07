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
		${PYTHON_PKGNAMEPREFIX}prometheus-client>0:net/py-prometheus-client@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests-unixsocket>0:www/py-requests-unixsocket@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}simplejson>0:devel/py-simplejson@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests>0:www/py-requests@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}requests-toolbelt>0:www/py-requests-toolbelt@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}yaml>0:devel/py-yaml@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}uptime>0:sysutils/py-uptime@${PY_FLAVOR} \
		${PYTHON_PKGNAMEPREFIX}typing-extensions>0:devel/py-typing-extensions@${PY_FLAVOR}

USES=		python:3.9+
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

OPTIONS_DEFINE=	APACHE BIND CONSUL COREDNS DIRECTORY DISK DNS HAPROXY MYSQL NETWORK NGINX PHP POSTFIX POSTGRES PROCESS REDIS SMART SNMP SSH SYS_CORE SYS_SWAP TCP TLS UNBOUND ZFS

OPTIONS_SUB=	yes

APACHE_DESC=	Apache check integration
BIND_DESC=	BIND check integration
CONSUL_DESC=	Consul check integration
COREDNS_DESC=	CoreDNS check integration
DIRECTORY_DESC=	Directory check integration
DISK_DESC=	Disk check integration
DNS_DESC=	DNS check integration
HAPROXY_DESC=	HAProxy check integration
MYSQL_DESC=	MySQL check integration
NETWORK_DESC=	Network check integration
NGINX_DESC=	Nginx check integration
PHP_DESC=	PHP-fpm check integration
POSTFIX_DESC=	Postfix check integration
POSTGRES_DESC=	PostgreSQL check integration
PROCESS_DESC=	Process check integration
REDIS_DESC=	Redis check integration
SMART_DESC=	SMART check integration
SNMP_DESC=	SNMP check integration
SSH_DESC=	SSH check integration
SYS_CORE_DESC=	System Core check integration
SYS_SWAP_DESC=	System Swap check integration
TCP_DESC=	TCP check integration
TLS_DESC=	TLS check integration
UNBOUND_DESC=	Unbound check integration
ZFS_DESC=	ZFS check integration

APACHE_VARS=	INTEGRATIONS+=apache CONFFILES+=apache
BIND_VARS=	INTEGRATIONS+=bind9 CONFFILES+=bind9
CONSUL_VARS=	INTEGRATIONS+=consul CONFFILES+=consul
COREDNS_VARS=	INTEGRATIONS+=coredns CONFFILES+=coredns
DIRECTORY_VARS=	INTEGRATIONS+=directory CONFFILES+=directory
DISK_VARS=	INTEGRATIONS+=disk CONFFILES+=disk
DNS_VARS=	INTEGRATIONS+=dns_check CONFFILES+=dns_check
HAPROXY_VARS=	INTEGRATIONS+=haproxy CONFFILES+=haproxy
MYSQL_VARS=	INTEGRATIONS+=mysql CONFFILES+=mysql
NETWORK_VARS=	INTEGRATIONS+=network CONFFILES+=network
NGINX_VARS=	INTEGRATIONS+=nginx CONFFILES+=nginx
PHP_VARS=	INTEGRATIONS+=php_fpm CONFFILES+=php_fpm
POSTFIX_VARS=	INTEGRATIONS+=postfix CONFFILES+=postfix
POSTGRES_VARS=	INTEGRATIONS+=postgres CONFFILES+=postgres
PROCESS_VARS=	INTEGRATIONS+=process CONFFILES+=process
REDIS_VARS=	INTEGRATIONS+=redisdb CONFFILES+=redisdb
SMART_VARS=	INTEGRATIONS+=smart CONFFILES+=smart
SNMP_VARS=	INTEGRATIONS+=snmp CONFFILES+=snmp
SSH_VARS=	INTEGRATIONS+=ssh_check CONFFILES+=ssh_check
SYS_CORE_VARS=	INTEGRATIONS+=system_core CONFFILES+=system_core
SYS_SWAP_VARS=	INTEGRATIONS+=system_swap CONFFILES+=system_swap
TCP_VARS=	INTEGRATIONS+=tcp_check CONFFILES+=tcp_check
TLS_VARS=	INTEGRATIONS+=tls CONFFILES+=tls
UNBOUND_VARS=	INTEGRATIONS+=unbound CONFFILES+=unbound
ZFS_VARS=	INTEGRATIONS+=zfs CONFFILES+=zfs

# find integrations-core -name setup.py | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
INTEGRATIONS=	datadog_checks_base

# find integrations-core -name conf.yaml.example | awk -F\/ '{print $2}' | sort | uniq | grep -v datadog_checks_dev | tr '\n' ' '
CONFFILES=

DIRECTORY_RUN_DEPENDS=
DISK_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
DNS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}dnspython>0:dns/py-dnspython@${PY_FLAVOR}
MYSQL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
			${PYTHON_PKGNAMEPREFIX}pymysql>0:databases/py-pymysql@${PY_FLAVOR}
NETWORK_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
PHP_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}flup6>0:www/py-flup6@${PY_FLAVOR}
PROCESS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
REDIS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}redis>0:databases/py-redis
SSH_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}paramiko>0:security/py-paramiko@${PY_FLAVOR}
SYS_CORE_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
SYS_SWAP_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psutil>0:sysutils/py-psutil@${PY_FLAVOR}
TLS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}cryptography>0:security/py-cryptography@${PY_FLAVOR} \
			${PYTHON_PKGNAMEPREFIX}service_identity>0:security/py-service_identity@${PY_FLAVOR}

POSTGRES_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}psycopg2>0:databases/py-psycopg2@${PY_FLAVOR}
SNMP_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pysnmp>0:net/py-pysnmp@${PY_FLAVOR}

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
