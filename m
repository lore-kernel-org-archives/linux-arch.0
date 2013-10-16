From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 08/17] xtensa: update clockevent setup for SMP
Date: Thu, 17 Oct 2013 02:42:19 +0400
Message-ID: <1381963348-29448-9-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41343 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab3JPWm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:58 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so1199381lbh.19
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:57 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Provide per-cpu ccount_timer objects and use them appropriately.
Extract per-cpu clockevent setup function.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/time.c | 54 +++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 26eb6a9..4ce7aae 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -53,18 +53,12 @@ static int ccount_timer_set_next_event(unsigned long delta,
 		struct clock_event_device *dev);
 static void ccount_timer_set_mode(enum clock_event_mode mode,
 		struct clock_event_device *evt);
-static struct ccount_timer_t {
+struct ccount_timer {
 	struct clock_event_device evt;
 	int irq_enabled;
-} ccount_timer = {
-	.evt = {
-		.name		= "ccount_clockevent",
-		.features	= CLOCK_EVT_FEAT_ONESHOT,
-		.rating		= 300,
-		.set_next_event	= ccount_timer_set_next_event,
-		.set_mode	= ccount_timer_set_mode,
-	},
+	char name[24];
 };
+static DEFINE_PER_CPU(struct ccount_timer, ccount_timer);
 
 static int ccount_timer_set_next_event(unsigned long delta,
 		struct clock_event_device *dev)
@@ -85,8 +79,8 @@ static int ccount_timer_set_next_event(unsigned long delta,
 static void ccount_timer_set_mode(enum clock_event_mode mode,
 		struct clock_event_device *evt)
 {
-	struct ccount_timer_t *timer =
-		container_of(evt, struct ccount_timer_t, evt);
+	struct ccount_timer *timer =
+		container_of(evt, struct ccount_timer, evt);
 
 	/*
 	 * There is no way to disable the timer interrupt at the device level,
@@ -118,9 +112,28 @@ static struct irqaction timer_irqaction = {
 	.handler =	timer_interrupt,
 	.flags =	IRQF_TIMER,
 	.name =		"timer",
-	.dev_id =	&ccount_timer,
 };
 
+void local_timer_setup(unsigned cpu)
+{
+	struct ccount_timer *timer = &per_cpu(ccount_timer, cpu);
+	struct clock_event_device *clockevent = &timer->evt;
+
+	timer->irq_enabled = 1;
+	clockevent->name = timer->name;
+	snprintf(timer->name, sizeof(timer->name), "ccount_clockevent_%u", cpu);
+	clockevent->features = CLOCK_EVT_FEAT_ONESHOT;
+	clockevent->rating = 300;
+	clockevent->set_next_event = ccount_timer_set_next_event;
+	clockevent->set_mode = ccount_timer_set_mode;
+	clockevent->cpumask = cpumask_of(cpu);
+	clockevent->irq = irq_create_mapping(NULL, LINUX_TIMER_INT);
+	if (WARN(!clockevent->irq, "error: can't map timer irq"))
+		return;
+	clockevents_config_and_register(clockevent, ccount_freq,
+					0xf, 0xffffffff);
+}
+
 void __init time_init(void)
 {
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
@@ -132,16 +145,8 @@ void __init time_init(void)
 	ccount_freq = CONFIG_XTENSA_CPU_CLOCK*1000000UL;
 #endif
 	clocksource_register_hz(&ccount_clocksource, ccount_freq);
-
-	ccount_timer.evt.cpumask = cpumask_of(0);
-	ccount_timer.evt.irq = irq_create_mapping(NULL, LINUX_TIMER_INT);
-	if (WARN(!ccount_timer.evt.irq, "error: can't map timer irq"))
-		return;
-	clockevents_config_and_register(&ccount_timer.evt, ccount_freq, 0xf,
-			0xffffffff);
-	setup_irq(ccount_timer.evt.irq, &timer_irqaction);
-	ccount_timer.irq_enabled = 1;
-
+	local_timer_setup(0);
+	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
 	setup_sched_clock(ccount_sched_clock_read, 32, ccount_freq);
 }
 
@@ -149,10 +154,9 @@ void __init time_init(void)
  * The timer interrupt is called HZ times per second.
  */
 
-irqreturn_t timer_interrupt (int irq, void *dev_id)
+irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
-	struct ccount_timer_t *timer = dev_id;
-	struct clock_event_device *evt = &timer->evt;
+	struct clock_event_device *evt = &this_cpu_ptr(&ccount_timer)->evt;
 
 	evt->event_handler(evt);
 
-- 
1.8.1.4
