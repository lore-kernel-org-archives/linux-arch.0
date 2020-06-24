Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406446AbgFXUdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B293C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u48so2419022qth.17
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:07 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:31:43 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-ID: <20200624203200.78870-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
Subject: [PATCH 05/22] kbuild: lto: postpone objtool
From: Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Message-ID: <20200624203143.0vQLXsaKxCLodQFrZhfLlLhbafRwGWpVzCjEEYRk2Yk@z>

With LTO, LLVM bitcode won't be compiled into native code until
modpost_link, or modfinal for modules. This change postpones calls
to objtool until after these steps.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/compiler.h  |  2 +-
 lib/Kconfig.debug         |  2 +-
 scripts/Makefile.build    |  2 ++
 scripts/Makefile.modfinal | 15 +++++++++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 30827f82ad62..12b115152532 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
-#ifdef CONFIG_DEBUG_ENTRY
+#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
 /* Begin/end of an instrumentation safe region */
 #define instrumentation_begin() ({					\
 	asm volatile("%c0:\n\t"						\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..9fdba71c135a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -399,7 +399,7 @@ config STACK_VALIDATION
 
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	depends on STACK_VALIDATION && (DEBUG_ENTRY || LTO_CLANG) && !PARAVIRT
 	default y
 
 config DEBUG_FORCE_WEAK_PER_CPU
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 64e99f4baa5b..82977350f5a6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -226,6 +226,7 @@ endif # CC_USING_PATCHABLE_FUNCTION_ENTRY
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
+ifndef CONFIG_LTO_CLANG
 ifneq ($(SKIP_STACK_VALIDATION),1)
 
 __objtool_obj := $(objtree)/tools/objtool/objtool
@@ -258,6 +259,7 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(__objtool_obj))
 
 endif # SKIP_STACK_VALIDATION
+endif # CONFIG_LTO_CLANG
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index d168f0cfe67c..9f1df2f1fab5 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -48,6 +48,21 @@ endif # CC_USING_PATCHABLE_FUNCTION_ENTRY
 endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
+ifdef CONFIG_STACK_VALIDATION
+ifneq ($(SKIP_STACK_VALIDATION),1)
+cmd_ld_ko_o +=								\
+	$(objtree)/tools/objtool/objtool				\
+		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
+		--module						\
+		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
+		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
+		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
+		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
+		$(@:.ko=$(prelink-ext).o);
+
+endif # SKIP_STACK_VALIDATION
+endif # CONFIG_STACK_VALIDATION
+
 endif # CONFIG_LTO_CLANG
 
 quiet_cmd_ld_ko_o = LD [M]  $@
-- 
2.27.0.212.ge8ba1cc988-goog
