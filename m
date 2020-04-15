From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 01/12] compiler/gcc: Emit build-time warning for GCC prior to version 4.8
Date: Wed, 15 Apr 2020 17:52:07 +0100
Message-ID: <20200415165218.20251-2-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410484AbgDOQwv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:52:51 -0400
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
discarding the 'volatile' qualifier:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

We've been working around this using some nasty hacks which make
READ_ONCE() both horribly complicated and also prevent us from enforcing
that it is only used on scalar types. Since GCC 4.8 is pretty old for
kernel builds now, emit a warning if we detect it during the build.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 init/Kconfig            | 4 ++--
 scripts/Kconfig.include | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..816b8b4a5e9e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -9,11 +9,11 @@ config DEFCONFIG_LIST
 	default "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)"
 
 config CC_IS_GCC
-	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
+	def_bool $(cc-is-gcc)
 
 config GCC_VERSION
 	int
-	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
+	default $(gcc-version) if CC_IS_GCC
 	default 0
 
 config LD_VERSION
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index c264da2b9b30..5261e9d6b50b 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -54,3 +54,12 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
 cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
 m32-flag := $(cc-option-bit,-m32)
 m64-flag := $(cc-option-bit,-m64)
+
+# gcc version including patch level
+gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
+
+# Return y if the compiler is GCC, n otherwise
+cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
+
+# Warn if the compiler is GCC prior to 4.8
+$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")
-- 
2.26.0.110.g2183baf09c-goog
