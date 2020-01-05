Return-Path: <SRS0=cGiU=22=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAECw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 4 Jan 2020 21:52:26 -0500
From: guoren@kernel.org
Subject: [PATCH 1/2] riscv: Fixup obvious bug for fp-regs reset
Date: Sun,  5 Jan 2020 10:52:14 +0800
Message-ID: <20200105025215.2522-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com, zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com, atish.patra@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20200105025214.Z5cxs5i-hKKLbOCXavs76uf1e94lbDW_ETBlP4VZ0fk@z>

From: Guo Ren <ren_guo@c-sky.com>

CSR_MISA is defined in Privileged Architectures' spec: 3.1.1 Machine
ISA Register misa. Every bit:1 indicate a feature, so we should beqz
reset_done when there is no F/D bit in csr_msia register.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 797802c73dee..2227db63f895 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -251,7 +251,7 @@ ENTRY(reset_regs)
 #ifdef CONFIG_FPU
 	csrr	t0, CSR_MISA
 	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
-	bnez	t0, .Lreset_regs_done
+	beqz	t0, .Lreset_regs_done
 
 	li	t1, SR_FS
 	csrs	CSR_STATUS, t1
-- 
2.17.0
