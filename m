From: guoren@kernel.org
Subject: [RFC PATCH V3 07/11] riscv: Reset vector register
Date: Sun,  8 Mar 2020 17:49:50 +0800
Message-ID: <20200308094954.13258-8-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgCHJxi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:38 -0400
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com, greentime.hu@sifive.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>

From: Guo Ren <guoren@linux.alibaba.com>

Reset vector registers at boot-time and disable vector instructions
execution for kernel mode.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/entry.S |  2 +-
 arch/riscv/kernel/head.S  | 49 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bad4d85b5e91..449e0a7ef115 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -76,7 +76,7 @@ _save_context:
 	 * Disable the FPU to detect illegal usage of floating point in kernel
 	 * space.
 	 */
-	li t0, SR_SUM | SR_FS
+	li t0, SR_SUM | SR_FS | SR_VS
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 271860fc2c3f..b40d8ec7ad5d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -72,10 +72,10 @@ _start_kernel:
 .option pop
 
 	/*
-	 * Disable FPU to detect illegal usage of
+	 * Disable FPU & VECTOR to detect illegal usage of
 	 * floating point in kernel space
 	 */
-	li t0, SR_FS
+	li t0, SR_FS | SR_VS
 	csrc CSR_STATUS, t0
 
 #ifdef CONFIG_SMP
@@ -290,6 +290,51 @@ ENTRY(reset_regs)
 	csrw	fcsr, 0
 	/* note that the caller must clear SR_FS */
 #endif /* CONFIG_FPU */
+
+#ifdef CONFIG_VECTOR
+	csrr	t0, CSR_MISA
+	li	t1, (COMPAT_HWCAP_ISA_V >> 16)
+	slli	t1, t1, 16
+	and	t0, t0, t1
+	beqz	t0, .Lreset_regs_done
+
+	li	t1, SR_VS
+	csrs	CSR_STATUS, t1
+	vmv.v.i v0, 0
+	vmv.v.i v1, 0
+	vmv.v.i v2, 0
+	vmv.v.i v3, 0
+	vmv.v.i v4, 0
+	vmv.v.i v5, 0
+	vmv.v.i v6, 0
+	vmv.v.i v7, 0
+	vmv.v.i v8, 0
+	vmv.v.i v9, 0
+	vmv.v.i v10, 0
+	vmv.v.i v11, 0
+	vmv.v.i v12, 0
+	vmv.v.i v13, 0
+	vmv.v.i v14, 0
+	vmv.v.i v15, 0
+	vmv.v.i v16, 0
+	vmv.v.i v17, 0
+	vmv.v.i v18, 0
+	vmv.v.i v19, 0
+	vmv.v.i v20, 0
+	vmv.v.i v21, 0
+	vmv.v.i v22, 0
+	vmv.v.i v23, 0
+	vmv.v.i v24, 0
+	vmv.v.i v25, 0
+	vmv.v.i v26, 0
+	vmv.v.i v27, 0
+	vmv.v.i v28, 0
+	vmv.v.i v29, 0
+	vmv.v.i v30, 0
+	vmv.v.i v31, 0
+	/* note that the caller must clear SR_VS */
+#endif /* CONFIG_VECTOR */
+
 .Lreset_regs_done:
 	ret
 END(reset_regs)
-- 
2.17.0
