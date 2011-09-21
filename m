From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 11/57] microblaze: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 17:28:12 +0800
Message-ID: <1316597339-29861-12-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Michal Simek <monstr@monstr.eu>, Joe Perches <joe@perches.com>, John Stultz <johnstul@us.ibm.com>, microblaze-uclinux@itee.uq.edu.au
List-Id: linux-arch.vger.kernel.org

Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/microblaze/kernel/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index e5550ce..bb86351 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -163,7 +163,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction timer_irqaction = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_TIMER,
+	.flags = IRQF_TIMER,
 	.name = "timer",
 	.dev_id = &clockevent_microblaze_timer,
 };
-- 
1.7.4.1
