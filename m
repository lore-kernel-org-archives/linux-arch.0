Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51263 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab1IUJe4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 05:34:56 -0400
From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 41/57] pcmcia: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 17:28:42 +0800
Message-ID: <1316597339-29861-42-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Wolfram Sang <w.sang@pengutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>, Joe Perches <joe@perches.com>, linux-pcmcia@lists.infradead.org
Message-ID: <20110921092842.Fcwcdg7OMS9MRS1wQB0brgS9dPengtnCVRc91Tnr6ms@z>

Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/pcmcia/db1xxx_ss.c  |    4 ++--
 drivers/pcmcia/soc_common.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 3e49df6..6d76a92 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -162,12 +162,12 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 */
 	if (sock->board_type == BOARD_TYPE_DB1200) {
 		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
-				  IRQF_DISABLED, "pcmcia_insert", sock);
+				  0, "pcmcia_insert", sock);
 		if (ret)
 			goto out1;
 
 		ret = request_irq(sock->eject_irq, db1200_pcmcia_cdirq,
-				  IRQF_DISABLED, "pcmcia_eject", sock);
+				  0, "pcmcia_eject", sock);
 		if (ret) {
 			free_irq(sock->insert_irq, sock);
 			goto out1;
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index a0a9c2a..0493a31 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -535,7 +535,7 @@ int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt,
 		if (irqs[i].sock != skt->nr)
 			continue;
 		res = request_irq(irqs[i].irq, soc_common_pcmcia_interrupt,
-				  IRQF_DISABLED, irqs[i].str, skt);
+				  0, irqs[i].str, skt);
 		if (res)
 			break;
 		irq_set_irq_type(irqs[i].irq, IRQ_TYPE_NONE);
-- 
1.7.4.1

