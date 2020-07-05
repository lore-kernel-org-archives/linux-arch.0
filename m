From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
Date: Sun,  5 Jul 2020 16:26:40 +0200
Message-ID: <20200705142640.279439-1-kernel@esmil.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgGEO1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 10:27:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C95C061794
        for <linux-arch@vger.kernel.org>; Sun,  5 Jul 2020 07:27:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so36449383wmj.2
        for <linux-arch@vger.kernel.org>; Sun, 05 Jul 2020 07:27:14 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Emil Renner Berthing <kernel@esmil.dk>, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-arch@vger.kernel.org

Without this enabling CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT
results in many errors like this on the HiFive Unleashed
RISC-V board:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is regmap_mmio_write32le+0x1c/0x46
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
Call Trace:
[<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
[<ffffffe0005b290e>] dump_stack+0x6e/0x88
[<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
[<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
[<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
[<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
[<ffffffe0004715c4>] regmap_write+0x28/0x48
[<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
[<ffffffe00000113e>] rdinit_setup+0x22/0x26
[<ffffffe000469054>] platform_drv_probe+0x24/0x52
[<ffffffe000467e16>] really_probe+0x92/0x21a
[<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
[<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
[<ffffffe0004683f0>] __driver_attach+0x40/0xac
[<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
[<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
[<ffffffe000467118>] bus_add_driver+0x11e/0x184
[<ffffffe00046889a>] driver_register+0x32/0xc6
[<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
[<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
[<ffffffe00000113e>] rdinit_setup+0x22/0x26
[<ffffffe000001bea>] kernel_init_freeable+0x152/0x1da
[<ffffffe0005c4d28>] rest_init+0xde/0xe2
[<ffffffe0005c4d36>] kernel_init+0xa/0x11a
[<ffffffe0005c4d28>] rest_init+0xde/0xe2
[<ffffffe000200ff6>] ret_from_syscall_rejected+0x8/0xc

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
This patch fixes it, but my guess is that it's not the right
fix. Do anyone have a better idea?

 include/asm-generic/mmiowb.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
index 9439ff037b2d..31a21cdfbbcf 100644
--- a/include/asm-generic/mmiowb.h
+++ b/include/asm-generic/mmiowb.h
@@ -34,8 +34,12 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
 
 static inline void mmiowb_set_pending(void)
 {
-	struct mmiowb_state *ms = __mmiowb_state();
+	struct mmiowb_state *ms;
+
+	get_cpu();
+	ms = __mmiowb_state();
 	ms->mmiowb_pending = ms->nesting_count;
+	put_cpu();
 }
 
 static inline void mmiowb_spin_lock(void)
-- 
2.27.0
