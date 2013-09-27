From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 4/4] ARC: Use clockevents_config_and_register over clockevents_register_device
Date: Fri, 27 Sep 2013 16:27:37 +0530
Message-ID: <1380279457-14299-5-git-send-email-vgupta@synopsys.com>
References: <1380279457-14299-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380279457-14299-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: arc-linux-dev@synopsys.com, u.kleine-koenig@pengutronix.de, Noam Camus <noamc@ezchip.com>, Gilad Ben-Yossef <gilad@benyossef.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

clockevents_config_and_register is more clever and correct than doing i=
t
by hand; so use it.

[vgupta: fixed build failure due to missing ; in patch]

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/time.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arc/kernel/time.c b/arch/arc/kernel/time.c
index 0e51e69..3fde7de 100644
--- a/arch/arc/kernel/time.c
+++ b/arch/arc/kernel/time.c
@@ -227,12 +227,9 @@ void __attribute__((weak)) arc_local_timer_setup(u=
nsigned int cpu)
 {
 	struct clock_event_device *clk =3D &per_cpu(arc_clockevent_device, cp=
u);
=20
-	clockevents_calc_mult_shift(clk, arc_get_core_freq(), 5);
-
-	clk->max_delta_ns =3D clockevent_delta2ns(ARC_TIMER_MAX, clk);
 	clk->cpumask =3D cpumask_of(cpu);
-
-	clockevents_register_device(clk);
+	clockevents_config_and_register(clk, arc_get_core_freq(),
+					0, ARC_TIMER_MAX);
=20
 	/*
 	 * setup the per-cpu timer IRQ handler - for all cpus
--=20
1.8.1.2
