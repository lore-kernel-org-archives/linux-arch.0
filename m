From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
Date: Thu,  2 Jul 2020 23:06:59 +0900
Message-ID: <92ac407875bfb718371ef95c40610ec1ed50ff32.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgGBOI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13462C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so12589221pjc.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:29 -0700 (PDT)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

Similar to arch/um/os-Linux code, arch/x86 also contains OS dependent
part as well.  This patch moves underlying OS dependent part to tools/um
directory so that arch/x86 code does not need to build host build
facilities (e.g., libc).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/Makefile                                |  2 +-
 arch/x86/um/os-Linux/Makefile                       | 13 -------------
 tools/um/Makefile                                   |  2 +-
 tools/um/uml/Build                                  |  2 ++
 tools/um/uml/x86/Build                              | 11 +++++++++++
 .../x86/um/os-Linux => tools/um/uml/x86}/mcontext.c |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c  |  0
 .../um/os-Linux => tools/um/uml/x86}/registers.c    |  0
 .../um/os-Linux => tools/um/uml/x86}/task_size.c    |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c    |  0
 10 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/Makefile
 create mode 100644 tools/um/uml/x86/Build
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/mcontext.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/registers.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/task_size.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c (100%)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 77f70b969d14..25e9846b36a2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-$(OS)/
+	mem_$(BITS).o subarch.o
 
 ifeq ($(CONFIG_X86_32),y)
 
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
deleted file mode 100644
index 253bfb8cb702..000000000000
--- a/arch/x86/um/os-Linux/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-# Licensed under the GPL
-#
-
-obj-y = registers.o task_size.o mcontext.o
-
-obj-$(CONFIG_X86_32) += tls.o
-obj-$(CONFIG_64BIT) += prctl.o
-
-USER_OBJS := $(obj-y)
-
-include arch/um/scripts/Makefile.rules
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 07b9b93ed817..552ed5f1edae 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -61,7 +61,7 @@ $(OUTPUT)%-in.o: FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 # rule to build objects
-$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o
+$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 clean:
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index 8e0607ee8b0a..435a9670d3ff 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -12,6 +12,8 @@ liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
 
+liblinux-y += x86/
+
 liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 export O = $(srctree)
diff --git a/tools/um/uml/x86/Build b/tools/um/uml/x86/Build
new file mode 100644
index 000000000000..16bbc7eb19d1
--- /dev/null
+++ b/tools/um/uml/x86/Build
@@ -0,0 +1,11 @@
+#
+# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+# Licensed under the GPL
+#
+
+include $(objtree)/include/config/auto.conf
+
+liblinux-y = registers.o task_size.o mcontext.o
+
+liblinux-$(CONFIG_X86_32) += tls.o
+liblinux-$(CONFIG_64BIT) += prctl.o
diff --git a/arch/x86/um/os-Linux/mcontext.c b/tools/um/uml/x86/mcontext.c
similarity index 100%
rename from arch/x86/um/os-Linux/mcontext.c
rename to tools/um/uml/x86/mcontext.c
diff --git a/arch/x86/um/os-Linux/prctl.c b/tools/um/uml/x86/prctl.c
similarity index 100%
rename from arch/x86/um/os-Linux/prctl.c
rename to tools/um/uml/x86/prctl.c
diff --git a/arch/x86/um/os-Linux/registers.c b/tools/um/uml/x86/registers.c
similarity index 100%
rename from arch/x86/um/os-Linux/registers.c
rename to tools/um/uml/x86/registers.c
diff --git a/arch/x86/um/os-Linux/task_size.c b/tools/um/uml/x86/task_size.c
similarity index 100%
rename from arch/x86/um/os-Linux/task_size.c
rename to tools/um/uml/x86/task_size.c
diff --git a/arch/x86/um/os-Linux/tls.c b/tools/um/uml/x86/tls.c
similarity index 100%
rename from arch/x86/um/os-Linux/tls.c
rename to tools/um/uml/x86/tls.c
-- 
2.21.0 (Apple Git-122.2)
