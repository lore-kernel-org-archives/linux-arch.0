Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37807 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeJATQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 15:16:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so9398088pgq.4
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 05:38:43 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 1/5] m68k: rename system call table file name
Date: Mon,  1 Oct 2018 18:07:53 +0530
Message-ID: <1538397477-4003-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181001123753.pEybewEOncwCquFEU0CQ2plJqZe6n9v2xVJ0VJF7TAw@z>

The system call table entries are present in syscalltable.S. One of
the patch in this patch series will auto-generate the system call
table entries using the system call table generation script and
which'll replace the existig table file.

In order to come up with a common naming convention across all
architecture, we need to change the file name to syscall_table.S.
This change will unify the implementation across all architecture.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/kernel/Makefile                            | 2 +-
 arch/m68k/kernel/{syscalltable.S => syscall_table.S} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/m68k/kernel/{syscalltable.S => syscall_table.S} (100%)

diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index dbac7f8..5f40ce6 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -15,7 +15,7 @@ extra-$(CONFIG_SUN3)	:= sun3-head.o
 extra-y			+= vmlinux.lds
 
 obj-y	:= entry.o irq.o module.o process.o ptrace.o
-obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
+obj-y	+= setup.o signal.o sys_m68k.o syscall_table.o time.o traps.o
 
 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
 obj-$(CONFIG_MMU_SUN3) += ints.o vectors.o
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscall_table.S
similarity index 100%
rename from arch/m68k/kernel/syscalltable.S
rename to arch/m68k/kernel/syscall_table.S
-- 
1.9.1
