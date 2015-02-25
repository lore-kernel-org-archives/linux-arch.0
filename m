Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44781 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbBYR61 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 12:58:27 -0500
Date: Wed, 25 Feb 2015 18:58:16 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/rtmutex: drop usage of __HAVE_ARCH_CMPXCHG
Message-ID: <20150225175816.GF6823@linutronix.de>
References: <20150225175613.GE6823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150225175613.GE6823@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-rt-users@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20150225175816.QF486bPS41NdKCB4kLZfRY0BsPKrkqEU6ELQ2FLi2oo@z>

* Sebastian Andrzej Siewior | 2015-02-25 18:56:13 [+0100]:

>To put some numbers on it: preempt -RT, am335x, 10 loops of
>100000 invocations of rt_spin_lock() + rt_spin_unlock() (time "total" is
>the average of the 10 loops for the 100000 invocations, "loop" is
>"total / 100000 * 1000"):

This is the test code I was running.

diff --git a/init/main.c b/init/main.c
index e7cb76c079d4..e74523feeddb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1004,6 +1004,29 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	{
+		spinlock_t main_l;
+		int loops;
+
+		spin_lock_init(&main_l);
+
+		for (loops = 0; loops < 10; loops++) {
+			ktime_t start, end;
+			int i;
+
+			local_irq_disable();
+			start = ktime_get();
+			for (i = 0; i <= 100000; i++) {
+				rt_spin_lock(&main_l);
+				rt_spin_unlock(&main_l);
+			}
+			end = ktime_get();
+			local_irq_enable();
+			pr_err("%s(%d) %lld\n", __func__, __LINE__,
+			       ktime_to_us(ktime_sub(end, start)));
+		}
+	}
+
 	/* Open the /dev/console on the rootfs, this should never fail */
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
