From: David Howells <dhowells@redhat.com>
Subject: [PATCH] KEYS: CONFIG_KEYS_DEBUG_PROC_KEYS is no longer an option
Date: Wed, 03 Feb 2016 15:17:00 +0000
Message-ID: <20160203151700.21401.96985.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbcBCPRD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Feb 2016 10:17:03 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, Dmitry Kasatkin <dmitry.kasatkin@huawei.com>, Andreas Ziegler <andreas.ziegler@fau.de>

CONFIG_KEYS_DEBUG_PROC_KEYS is no longer an option as /proc/keys is now
mandatory if the keyrings facility is enabled (it's used by libkeyutils in
userspace).

The defconfig references were removed with:

	perl -p -i -e 's/CONFIG_KEYS_DEBUG_PROC_KEYS=y\n//' \
	    `git grep -l CONFIG_KEYS_DEBUG_PROC_KEYS=y`

and the integrity Kconfig fixed by hand.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andreas Ziegler <andreas.ziegler@fau.de>
cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
---

 arch/arm/configs/colibri_pxa270_defconfig   |    1 -
 arch/arm/configs/iop13xx_defconfig          |    1 -
 arch/arm/configs/iop32x_defconfig           |    1 -
 arch/arm/configs/trizeps4_defconfig         |    1 -
 arch/microblaze/configs/mmu_defconfig       |    1 -
 arch/microblaze/configs/nommu_defconfig     |    1 -
 arch/mips/configs/bigsur_defconfig          |    1 -
 arch/mips/configs/ip22_defconfig            |    1 -
 arch/mips/configs/ip27_defconfig            |    1 -
 arch/mips/configs/ip32_defconfig            |    1 -
 arch/mips/configs/jazz_defconfig            |    1 -
 arch/mips/configs/lemote2f_defconfig        |    1 -
 arch/mips/configs/rm200_defconfig           |    1 -
 arch/mips/configs/sb1250_swarm_defconfig    |    1 -
 arch/parisc/configs/712_defconfig           |    1 -
 arch/parisc/configs/a500_defconfig          |    1 -
 arch/parisc/configs/default_defconfig       |    1 -
 arch/parisc/configs/generic-32bit_defconfig |    1 -
 arch/powerpc/configs/c2k_defconfig          |    1 -
 arch/powerpc/configs/ppc6xx_defconfig       |    1 -
 arch/score/configs/spct6600_defconfig       |    1 -
 arch/tile/configs/tilegx_defconfig          |    1 -
 arch/tile/configs/tilepro_defconfig         |    1 -
 arch/x86/configs/i386_defconfig             |    1 -
 arch/x86/configs/x86_64_defconfig           |    1 -
 security/integrity/Kconfig                  |    1 -
 26 files changed, 26 deletions(-)

diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 18c311ae1113..0b9211b2b73b 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -166,7 +166,6 @@ CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA1=m
diff --git a/arch/arm/configs/iop13xx_defconfig b/arch/arm/configs/iop13xx_defconfig
index 4fa94a1f115b..652b7bd9e544 100644
--- a/arch/arm/configs/iop13xx_defconfig
+++ b/arch/arm/configs/iop13xx_defconfig
@@ -95,7 +95,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS=y
 CONFIG_DEBUG_USER=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index c3058da631da..aa3af0a6b8f7 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -108,7 +108,6 @@ CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_LRW=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 4bc870028035..0ada29d568ec 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -214,7 +214,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_USER=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=m
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index e2f6543b91e7..dc5dd5b69fde 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -87,5 +87,4 @@ CONFIG_KGDB_KDB=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_KEYS=y
 CONFIG_ENCRYPTED_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/microblaze/configs/nommu_defconfig b/arch/microblaze/configs/nommu_defconfig
index a29ebd4a9fcb..4cdaf565e638 100644
--- a/arch/microblaze/configs/nommu_defconfig
+++ b/arch/microblaze/configs/nommu_defconfig
@@ -92,7 +92,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_KEYS=y
 CONFIG_ENCRYPTED_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_MD5=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index b3e7a1b61220..e070dac071c8 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -247,7 +247,6 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_LIST=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 57ed466e00db..6ba9ce9fcdd5 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -358,7 +358,6 @@ CONFIG_DLM=m
 CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 48e16d98b2cc..77e9f505f5e4 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -346,7 +346,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_DLM=m
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_NULL=m
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index fe48220157a9..f9af98f63cff 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -181,7 +181,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=y
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 4f37a5985459..a5e85e1ee5de 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -362,7 +362,6 @@ CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_DLM=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 004cf52d1b7d..d1f198b072a0 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -412,7 +412,6 @@ CONFIG_DEBUG_FS=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_FIPS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index db029f4ff759..82db4e3e4cf1 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -453,7 +453,6 @@ CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
 CONFIG_DLM=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_LRW=m
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 51bab13ef6f8..7fca09fedb59 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -87,7 +87,6 @@ CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_DLM=m
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_AUTHENC=m
diff --git a/arch/parisc/configs/712_defconfig b/arch/parisc/configs/712_defconfig
index 9387cc2693f6..db8f56bf3883 100644
--- a/arch/parisc/configs/712_defconfig
+++ b/arch/parisc/configs/712_defconfig
@@ -183,7 +183,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_DEBUG_RODATA=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/parisc/configs/a500_defconfig b/arch/parisc/configs/a500_defconfig
index 0490199d7b15..1a4f776b49b8 100644
--- a/arch/parisc/configs/a500_defconfig
+++ b/arch/parisc/configs/a500_defconfig
@@ -193,7 +193,6 @@ CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/parisc/configs/default_defconfig b/arch/parisc/configs/default_defconfig
index 4d8127e8428a..310b6657e4ac 100644
--- a/arch/parisc/configs/default_defconfig
+++ b/arch/parisc/configs/default_defconfig
@@ -211,7 +211,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_MD4=m
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 0ffb08ff5125..5b04d703a924 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -301,7 +301,6 @@ CONFIG_RCU_CPU_STALL_INFO=y
 CONFIG_LATENCYTOP=y
 CONFIG_LKDTM=m
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 91862292cd55..340685caa7b8 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -387,7 +387,6 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index e5d2c3dc07f1..99ccbebabfd3 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1175,7 +1175,6 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
diff --git a/arch/score/configs/spct6600_defconfig b/arch/score/configs/spct6600_defconfig
index df1edbf507a2..b2d8802f43b4 100644
--- a/arch/score/configs/spct6600_defconfig
+++ b/arch/score/configs/spct6600_defconfig
@@ -70,7 +70,6 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_CRYPTO_NULL=y
diff --git a/arch/tile/configs/tilegx_defconfig b/arch/tile/configs/tilegx_defconfig
index 37dc9364c4a1..c1387b7f447d 100644
--- a/arch/tile/configs/tilegx_defconfig
+++ b/arch/tile/configs/tilegx_defconfig
@@ -374,7 +374,6 @@ CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_KGDB=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
diff --git a/arch/tile/configs/tilepro_defconfig b/arch/tile/configs/tilepro_defconfig
index 76a2781dec2c..6d9ce8af1107 100644
--- a/arch/tile/configs/tilepro_defconfig
+++ b/arch/tile/configs/tilepro_defconfig
@@ -486,7 +486,6 @@ CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 CONFIG_ASYNC_RAID6_TEST=m
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 028be48c8839..a212b68a4909 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -303,7 +303,6 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_OPTIMIZE_INLINING=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index cb5b3ab5beec..4f404a64681b 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -300,7 +300,6 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_RODATA_TEST is not set
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_OPTIMIZE_INLINING=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 21d756832b75..7543398b79e3 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -45,7 +45,6 @@ config INTEGRITY_TRUSTED_KEYRING
 	bool "Require all keys on the integrity keyrings be signed"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
-	select KEYS_DEBUG_PROC_KEYS
 	default y
 	help
 	   This option requires that all keys added to the .ima and
