From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/2] Introduce HAVE_AOUT symbol to remove hard-coded arch
	list for BINFMT_AOUT
Date: Fri, 05 Sep 2008 17:27:06 +0100
Message-ID: <1220632026.2985.361.camel@pmac.infradead.org>
References: <1213696004.26255.960.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35061 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYIEQ1J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2008 12:27:09 -0400
In-Reply-To: <1213696004.26255.960.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

HAVE_AOUT doesn't quite do the same thing as the recently removed
ARCH_SUPPORTS_AOUT config option. That was set even on platforms where
binfmt_aout isn't supported, although it's not entirely clear why.

So it's best just to introduce a new symbol, handled consistently with
other similar HAVE_xxx symbols; with a simple 'select' in the arch Kconfig.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/alpha/Kconfig   |    1 +
 arch/arm/Kconfig     |    1 +
 arch/m68k/Kconfig    |    1 +
 arch/um/Kconfig.i386 |    5 +++--
 arch/x86/Kconfig     |    1 +
 fs/Kconfig.binfmt    |    5 ++++-
 6 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 46f0ddf..ee35226 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -5,6 +5,7 @@
 config ALPHA
 	bool
 	default y
+	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8803c39..2f7ef54 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -8,6 +8,7 @@ mainmenu "Linux Kernel Configuration"
 config ARM
 	bool
 	default y
+	select HAVE_AOUT
 	select HAVE_IDE
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d42b996..41e5bf0 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -5,6 +5,7 @@
 config M68K
 	bool
 	default y
+	select HAVE_AOUT
 	select HAVE_IDE
 
 config MMU
diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index 2a44e5c..1f57c11 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -9,8 +9,9 @@ config UML_X86
 	default y
 
 config X86_32
-       bool
-       default y
+	bool
+	default y
+  	select HAVE_AOUT
 
 config RWSEM_XCHGADD_ALGORITHM
 	def_bool y
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e8fa40..59b1d65 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -18,6 +18,7 @@ config X86_64
 ### Arch settings
 config X86
 	def_bool y
+	select HAVE_AOUT if X86_32
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index e4df913..17c9c5e 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -59,9 +59,12 @@ config BINFMT_SHARED_FLAT
 	help
 	  Support FLAT shared libraries
 
+config HAVE_AOUT
+       def_bool n
+
 config BINFMT_AOUT
 	tristate "Kernel support for a.out and ECOFF binaries"
-	depends on (X86_32 || ALPHA || ARM || M68K)
+	depends on HAVE_AOUT
 	---help---
 	  A.out (Assembler.OUTput) is a set of formats for libraries and
 	  executables used in the earliest versions of UNIX.  Linux used
-- 
1.5.5.1
-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
