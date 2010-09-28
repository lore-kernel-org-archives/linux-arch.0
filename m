From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] mfd: speedup twl4030 irq response time and decrease irq
 disable time
Date: Tue, 28 Sep 2010 13:01:32 +0800
Message-ID: <AANLkTimT8WkgiCANL4tXcNgnm63oMnO2d2bKjDD1chJv@mail.gmail.com>
References: <1285120171-3030-1-git-send-email-tom.leiming@gmail.com>
	<20100927154809.GI2560@sortiz-mobl>
	<AANLkTikjGD32hPhwPhZfETZX9H+--_SduTtqgyuqY_72@mail.gmail.com>
	<20100928042416.GA9359@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57602 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0I1FBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2010 01:01:34 -0400
In-Reply-To: <20100928042416.GA9359@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org

CC genirq guys

2010/9/28 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Sep 28, 2010 at 08:25:24AM +0800, Ming Lei wrote:
>> 2010/9/27 Samuel Ortiz <sameo@linux.intel.com>:
>
>> > Wouldn't converting your twl4030_irq_thread() to the threaded IRQ =
framework
>> > fix that problem ?
>
>> IRQ_DISABLED flag is set by disable_irq_nosync called from PIH handl=
er,
>> then thread function can't be executed in irq thread function, so we=
 can't
>> convert this to threaded IRQ framework simply.
>
> Have you raised this issue with the genirq guys? =A0This sounds like
> something that the core infrastructure should be able to cope with.
>

Even genirq guys can help us to convert to irq thread framework, I
don't think there is good way to set priority for one irq thread.

=46or twl4030, if we can make twl4030_irq_thread to run at higher
priority than that of other irq thread, the PIH irq disable time can be
decreased further since other irq thread waken up by twl4030_irq_thread
can preempt the running of twl4030_irq_thread, and the PIH irq will be
enabled until complete of twl4030_irq_thread.

thanks,
--=20
Lei Ming
