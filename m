From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 19/27] microblaze: make syscall_table implementation generic
Date: Wed, 1 Apr 2009 14:35:15 +0200
Message-ID: <11ab265138d74f0cbf08cc7bfc8db5ff2a5ae518.1241105648.git.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:61138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932399AbZD3PmG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 11:42:06 -0400
In-Reply-To: <cover.1241105648.git.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/Kconfig                            |    3 +++
 arch/microblaze/kernel/Makefile                    |    2 +-
 kernel/Makefile                                    |    1 +
 {arch/microblaze/kernel => kernel}/syscall_table.c |    2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)
 rename {arch/microblaze/kernel => kernel}/syscall_table.c (82%)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 8cc312b..47c161a 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -49,6 +49,9 @@ config GENERIC_CLOCKEVENTS
 config GENERIC_HARDIRQS_NO__DO_IRQ
 	def_bool y
 
+config GENERIC_SYSCALL_TABLE
+	def_bool y
+
 config PCI
 	depends on !MMU
 	def_bool n
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 8dd4728..da94bec 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := head.o vmlinux.lds
 obj-y += exceptions.o \
 	hw_exception_handler.o init_task.o intc.o irq.o of_device.o \
 	of_platform.o process.o prom.o prom_parse.o ptrace.o \
-	setup.o signal.o sys_microblaze.o timer.o traps.o syscall_table.o
+	setup.o signal.o sys_microblaze.o timer.o traps.o
 
 obj-y += cpu/
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 4242366..647d8d9 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_FUNCTION_TRACER) += trace/
 obj-$(CONFIG_TRACING) += trace/
 obj-$(CONFIG_SMP) += sched_cpupri.o
 obj-$(CONFIG_SLOW_WORK) += slow-work.o
+obj-$(CONFIG_GENERIC_SYSCALL_TABLE) += syscall_table.o
 
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/arch/microblaze/kernel/syscall_table.c b/kernel/syscall_table.c
similarity index 82%
rename from arch/microblaze/kernel/syscall_table.c
rename to kernel/syscall_table.c
index cfc35fa..a2da111 100644
--- a/arch/microblaze/kernel/syscall_table.c
+++ b/kernel/syscall_table.c
@@ -7,6 +7,6 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] (call),
 
-void *sys_call_table[__NR_syscalls] = {
+void *sys_call_table[] = {
 #include <asm/unistd.h>
 };
-- 
1.5.6.3
