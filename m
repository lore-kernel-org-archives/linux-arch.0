From: guoren@kernel.org
Subject: [PATCH 10/10] irqchip/csky: Add support-vector-irq for apb-intc
Date: Tue, 29 Jan 2019 20:24:29 +0800
Message-ID: <1548764669-16656-10-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Some socs don't provide pending registers, so we must make the interrupt
controller working at vector mode. Add csky,support-vector-irq to
support this mode in dts.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index ae4c59b..14ef206 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -302,10 +302,17 @@ static void ck_irq_handler(struct pt_regs *regs)
 		pr_err("%s: none irq pending!\n", __func__);
 }
 
+static void ck_vec_irq_handler(struct pt_regs *regs)
+{
+	unsigned long vector = (mfcr("psr") >> 16) & 0xff;
+
+	handle_domain_irq(root_domain, vector - 32, regs);
+}
+
 static int __init
 ck_intc_init(struct device_node *node, struct device_node *parent)
 {
-	int ret;
+	int ret, i;
 
 	ret = ck_intc_init_comm(node, parent);
 	if (ret)
@@ -323,7 +330,16 @@ ck_intc_init(struct device_node *node, struct device_node *parent)
 
 	setup_irq_channel(0x00010203, reg_base + CK_INTC_SOURCE);
 
-	set_handle_irq(ck_irq_handler);
+	if (of_find_property(node, "csky,support-vector-irq", NULL)) {
+		set_handle_irq(ck_vec_irq_handler);
+
+		for (i = 32; i < 128; i++)
+			VEC_INIT(i, csky_irq);
+
+		writel(0, reg_base + CK_INTC_ICR);
+	} else {
+		set_handle_irq(ck_irq_handler);
+	}
 
 	return 0;
 }
-- 
2.7.4
