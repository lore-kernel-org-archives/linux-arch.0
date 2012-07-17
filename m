Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53014 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2GQRLe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2012 13:11:34 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] atomic64_test: Simplify the #ifdef for atomic64_dec_if_positive() test
Date: Tue, 17 Jul 2012 18:10:48 +0100
Message-ID: <1342545048-30958-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux390@de.ibm.com, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20120717171048.81iH6ABLrQ8SH6NtnwPRWSkIxyc3r6GYpM-E9oWwxvc@z>

This patch introduces CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE and uses
this instead of the multitude of #if defined() checks in atomic64_test.c

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux390@de.ibm.com
Cc: x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---

That's a trivial patch to sort out the #if statement for the
atomic64_dec_if_positive() test. I went for the Kconfig option, the
alternative being #define in the atomic.h header files of each
architecture affected.

Thanks.

 arch/arm/Kconfig     |    1 +
 arch/mips/Kconfig    |    1 +
 arch/powerpc/Kconfig |    1 +
 arch/s390/Kconfig    |    1 +
 arch/x86/Kconfig     |    1 +
 lib/Kconfig          |    3 +++
 lib/atomic64_test.c  |    5 ++---
 7 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..88df37f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 =09select RTC_LIB
 =09select SYS_SUPPORTS_APM_EMULATION
 =09select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
+=09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 =09select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 =09select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 =09select HAVE_ARCH_KGDB
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 09ab87e..c9e1812 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -20,6 +20,7 @@ config MIPS
 =09select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 =09select RTC_LIB if !MACH_LOONGSON
 =09select GENERIC_ATOMIC64 if !64BIT
+=09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 =09select HAVE_DMA_ATTRS
 =09select HAVE_DMA_API_DEBUG
 =09select HAVE_GENERIC_HARDIRQS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 050cb37..8b8bc3a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -115,6 +115,7 @@ config PPC
 =09select HAVE_OPROFILE
 =09select HAVE_SYSCALL_WRAPPERS if PPC64
 =09select GENERIC_ATOMIC64 if PPC32
+=09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 =09select HAVE_IRQ_WORK
 =09select HAVE_PERF_EVENTS
 =09select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a39b469..64cb682 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,7 @@ config S390
 =09select GENERIC_TIME_VSYSCALL
 =09select GENERIC_CLOCKEVENTS
 =09select KTIME_SCALAR if 32BIT
+=09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
=20
 config SCHED_OMIT_FRAME_POINTER
 =09def_bool y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c70684f..1d08863 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,6 +95,7 @@ config X86
 =09select KTIME_SCALAR if X86_32
 =09select GENERIC_STRNCPY_FROM_USER
 =09select GENERIC_STRNLEN_USER
+=09select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
=20
 config INSTRUCTION_DECODER
 =09def_bool (KPROBES || PERF_EVENTS || UPROBES)
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e1540..e0a7d57 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -340,6 +340,9 @@ config NLATTR
 config GENERIC_ATOMIC64
        bool
=20
+config ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+=09def_bool y if GENERIC_ATOMIC64
+
 config LRU_CACHE
 =09tristate
=20
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index cb99b91..00bca22 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -114,8 +114,7 @@ static __init int test_atomic64(void)
 =09r +=3D one;
 =09BUG_ON(v.counter !=3D r);
=20
-#if defined(CONFIG_X86) || defined(CONFIG_MIPS) || defined(CONFIG_PPC) || =
\
-    defined(CONFIG_S390) || defined(_ASM_GENERIC_ATOMIC64_H) || defined(CO=
NFIG_ARM)
+#ifdef CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 =09INIT(onestwos);
 =09BUG_ON(atomic64_dec_if_positive(&v) !=3D (onestwos - 1));
 =09r -=3D one;
@@ -129,7 +128,7 @@ static __init int test_atomic64(void)
 =09BUG_ON(atomic64_dec_if_positive(&v) !=3D (-one - one));
 =09BUG_ON(v.counter !=3D r);
 #else
-#warning Please implement atomic64_dec_if_positive for your architecture, =
and add it to the IF above
+#warning Please implement atomic64_dec_if_positive for your architecture a=
nd select the above Kconfig symbol
 #endif
=20
 =09INIT(onestwos);

