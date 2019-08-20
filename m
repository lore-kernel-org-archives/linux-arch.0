Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfHTMev (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 08:34:51 -0400
From: guoren@kernel.org
Subject: [PATCH 3/3] csky: Support kernel non-aligned access
Date: Tue, 20 Aug 2019 20:34:29 +0800
Message-ID: <1566304469-5601-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1566304469-5601-1-git-send-email-guoren@kernel.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190820123429.SD975ta5-kxuzSkOZI8LnLmFXs6tdzK-rAgMeABbqcs@z>

From: Guo Ren <ren_guo@c-sky.com>

We prohibit non-aligned access in kernel mode, but some special NIC
driver needs to support kernel-state unaligned access. For example,
when the bus does not support unaligned access, IP header parsing
will cause non-aligned access and driver does not recopy the skb
buffer to dma for performance reasons.

Added kernel_enable & user_enable to control unaligned access and
added kernel_count  & user_count for statistical unaligned access.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/alignment.c | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 27ef5b2..cb2a0d9 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -5,8 +5,10 @@
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
 
-static int align_enable = 1;
-static int align_count;
+static int align_kern_enable = 1;
+static int align_usr_enable = 1;
+static int align_kern_count = 0;
+static int align_usr_count = 0;
 
 static inline uint32_t get_ptreg(struct pt_regs *regs, uint32_t rx)
 {
@@ -32,9 +34,6 @@ static int ldb_asm(uint32_t addr, uint32_t *valp)
 	uint32_t val;
 	int err;
 
-	if (!access_ok((void *)addr, 1))
-		return 1;
-
 	asm volatile (
 		"movi	%0, 0\n"
 		"1:\n"
@@ -67,9 +66,6 @@ static int stb_asm(uint32_t addr, uint32_t val)
 {
 	int err;
 
-	if (!access_ok((void *)addr, 1))
-		return 1;
-
 	asm volatile (
 		"movi	%0, 0\n"
 		"1:\n"
@@ -203,8 +199,6 @@ static int stw_c(struct pt_regs *regs, uint32_t rz, uint32_t addr)
 	if (stb_asm(addr, byte3))
 		return 1;
 
-	align_count++;
-
 	return 0;
 }
 
@@ -226,7 +220,14 @@ void csky_alignment(struct pt_regs *regs)
 	uint32_t addr   = 0;
 
 	if (!user_mode(regs))
+		goto kernel_area;
+
+	if (!align_usr_enable) {
+		pr_err("%s user disabled.\n", __func__);
 		goto bad_area;
+	}
+
+	align_usr_count++;
 
 	ret = get_user(tmp, (uint16_t *)instruction_pointer(regs));
 	if (ret) {
@@ -234,6 +235,19 @@ void csky_alignment(struct pt_regs *regs)
 		goto bad_area;
 	}
 
+	goto good_area;
+
+kernel_area:
+	if (!align_kern_enable) {
+		pr_err("%s kernel disabled.\n", __func__);
+		goto bad_area;
+	}
+
+	align_kern_count++;
+
+	tmp = *(uint16_t *)instruction_pointer(regs);
+
+good_area:
 	opcode = (uint32_t)tmp;
 
 	rx  = opcode & 0xf;
@@ -286,18 +300,32 @@ void csky_alignment(struct pt_regs *regs)
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
 }
 
-static struct ctl_table alignment_tbl[4] = {
+static struct ctl_table alignment_tbl[5] = {
+	{
+		.procname = "kernel_enable",
+		.data = &align_kern_enable,
+		.maxlen = sizeof(align_kern_enable),
+		.mode = 0666,
+		.proc_handler = &proc_dointvec
+	},
+	{
+		.procname = "user_enable",
+		.data = &align_usr_enable,
+		.maxlen = sizeof(align_usr_enable),
+		.mode = 0666,
+		.proc_handler = &proc_dointvec
+	},
 	{
-		.procname = "enable",
-		.data = &align_enable,
-		.maxlen = sizeof(align_enable),
+		.procname = "kernel_count",
+		.data = &align_kern_count,
+		.maxlen = sizeof(align_kern_count),
 		.mode = 0666,
 		.proc_handler = &proc_dointvec
 	},
 	{
-		.procname = "count",
-		.data = &align_count,
-		.maxlen = sizeof(align_count),
+		.procname = "user_count",
+		.data = &align_usr_count,
+		.maxlen = sizeof(align_usr_count),
 		.mode = 0666,
 		.proc_handler = &proc_dointvec
 	},
-- 
2.7.4
