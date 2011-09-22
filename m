From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 16/55] score: irq: Remove IRQF_DISABLED
Date: Thu, 22 Sep 2011 16:58:43 +0800
Message-ID: <1316681962-8217-17-git-send-email-yong.zhang0@gmail.com>
References: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316681962-8217-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/score/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/score/kernel/time.c b/arch/score/kernel/time.c
index f0a43af..24770cd 100644
--- a/arch/score/kernel/time.c
+++ b/arch/score/kernel/time.c
@@ -41,7 +41,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction timer_irq = {
 	.handler = timer_interrupt,
-	.flags = IRQF_DISABLED | IRQF_TIMER,
+	.flags = IRQF_TIMER,
 	.name = "timer",
 };
 
-- 
1.7.4.1
