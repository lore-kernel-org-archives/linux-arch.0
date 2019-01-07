Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44747 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfAGOxX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 09:53:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so228042pgr.11
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2019 06:53:22 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/3] c6x: add Makefile to invoke syscall table generation script
Date: Mon,  7 Jan 2019 20:22:44 +0530
Message-ID: <1546872766-3354-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
References: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-c6x-dev@linux-c6x.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190107145244.Q3pNyRDGSOCXDg2JmkmtRVD0vUsG5RewwtsHz3Ceq3Y@z>

Add Makefile to invoke the system call table generation script
which is placed in scripts directory as a common location acc-
essible for all the architectures.

scripts/syscallhdr.sh will generate uapi header and scripts-
/syscalltbl.sh will generate kapi header respectively. There
is another scripts scripts/syscallnr.sh can generate total
number of syscall which doesn't invoke from this Makefile.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/c6x/kernel/syscalls/Makefile | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/c6x/kernel/syscalls/Makefile

diff --git a/arch/c6x/kernel/syscalls/Makefile b/arch/c6x/kernel/syscalls/Makefile
new file mode 100644
index 0000000..1865a80
--- /dev/null
+++ b/arch/c6x/kernel/syscalls/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+kapi := arch/$(SRCARCH)/include/generated/asm
+uapi := arch/$(SRCARCH)/include/generated/uapi/asm
+
+_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
+	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+
+syscall := $(srctree)/scripts/syscalls/syscall.tbl
+syshdr := $(srctree)/scripts/syscallhdr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
+
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
+		   '$(syshdr_abis_$(basetarget))'		\
+		   '$(syshdr_pfx_$(basetarget))'		\
+		   '$(syshdr_offset_$(basetarget))'
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
+		   '$(systbl_abis_$(basetarget))'		\
+		   '$(systbl_abi_$(basetarget))'		\
+		   '$(systbl_offset_$(basetarget))'
+
+syshdr_abis_unistd_32 := common,32,rename,stat64,archs0
+$(uapi)/unistd_32.h: $(syscall) $(syshdr)
+	$(call if_changed,syshdr)
+
+systbl_abis_syscall_table := common,32,rename,stat64,archs0
+systbl_abi_syscall_table := 32
+$(kapi)/syscall_table.h: $(syscall) $(systbl)
+	$(call if_changed,systbl)
+
+uapisyshdr-y		+= unistd_32.h
+kapisyshdr-y		+= syscall_table.h
+
+targets	+= $(uapisyshdr-y) $(kapisyshdr-y)
+
+PHONY += all
+all: $(addprefix $(uapi)/,$(uapisyshdr-y))
+all: $(addprefix $(kapi)/,$(kapisyshdr-y))
+	@:
-- 
1.9.1
