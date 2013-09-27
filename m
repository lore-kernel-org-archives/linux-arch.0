Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:36288 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab3I0K6i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Sep 2013 06:58:38 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 4/4] ARC: Use clockevents_config_and_register over clockevents_register_device
Date: Fri, 27 Sep 2013 16:27:37 +0530
Message-ID: <1380279457-14299-5-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1380279457-14299-1-git-send-email-vgupta@synopsys.com>
References: <1380279457-14299-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: arc-linux-dev@synopsys.com, u.kleine-koenig@pengutronix.de, Noam Camus <noamc@ezchip.com>, Gilad Ben-Yossef <gilad@benyossef.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20130927105737.ubu6H873Q9mx5OWdb7nEzrOySXeVxnONr4Xras6-SJQ@z>

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

clockevents_config_and_register is more clever and correct than doing it
by hand; so use it.

[vgupta: fixed build failure due to missing ; in patch]

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/time.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/time.c b/arch/arc/kernel/time.c
index 0e51e69..3fde7de 100644
--- a/arch/arc/kernel/time.c
+++ b/arch/arc/kernel/time.c
@@ -227,12 +227,9 @@ void __attribute__((weak)) arc_local_timer_setup(unsigned int cpu)
 {
 	struct clock_event_device *clk = &per_cpu(arc_clockevent_device, cpu);
 
-	clockevents_calc_mult_shift(clk, arc_get_core_freq(), 5);
-
-	clk->max_delta_ns = clockevent_delta2ns(ARC_TIMER_MAX, clk);
 	clk->cpumask = cpumask_of(cpu);
-
-	clockevents_register_device(clk);
+	clockevents_config_and_register(clk, arc_get_core_freq(),
+					0, ARC_TIMER_MAX);
 
 	/*
 	 * setup the per-cpu timer IRQ handler - for all cpus
-- 
1.8.1.2

