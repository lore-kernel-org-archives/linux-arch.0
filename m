From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 13/17] xtensa: clear timer IRQ unconditionally in its handler
Date: Thu, 17 Oct 2013 02:42:24 +0400
Message-ID: <1381963348-29448-14-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:38947 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761127Ab3JPWnF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:43:05 -0400
Received: by mail-la0-f51.google.com with SMTP id hp15so1104565lab.24
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:43:04 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

PIC irq_ack doesn't clear timer IRQ, because timer interrupt handler
usually set up new timer by writing to ccompare register and thus
clearing timer IRQ. However timer may not be set up in the IRQ handler,
e.g. with tickless idle on SMP, or when CPU is going offline, leaving
timer IRQ raised and making do_interrupt attempting to handle it
forever.

To fix this always write current value of ccompare SR chosen to be linux
timer back to that SR on entry to timer interrupt handler.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 4ce7aae..60dcb3f 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -158,6 +158,7 @@ irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &this_cpu_ptr(&ccount_timer)->evt;
 
+	set_linux_timer(get_linux_timer());
 	evt->event_handler(evt);
 
 	/* Allow platform to do something useful (Wdog). */
-- 
1.8.1.4
