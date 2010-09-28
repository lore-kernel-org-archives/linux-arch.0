From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: speedup twl4030 irq response time and decrease
 irq disable time
Date: Mon, 27 Sep 2010 22:12:26 -0700
Message-ID: <20100928051225.GA9864@opensource.wolfsonmicro.com>
References: <1285120171-3030-1-git-send-email-tom.leiming@gmail.com>
 <20100927154809.GI2560@sortiz-mobl>
 <AANLkTikjGD32hPhwPhZfETZX9H+--_SduTtqgyuqY_72@mail.gmail.com>
 <20100928042416.GA9359@opensource.wolfsonmicro.com>
 <AANLkTimT8WkgiCANL4tXcNgnm63oMnO2d2bKjDD1chJv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58698 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750767Ab0I1FMM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Sep 2010 01:12:12 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimT8WkgiCANL4tXcNgnm63oMnO2d2bKjDD1chJv@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org

On Tue, Sep 28, 2010 at 01:01:32PM +0800, Ming Lei wrote:
> 2010/9/28 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > Have you raised this issue with the genirq guys? =A0This sounds lik=
e
> > something that the core infrastructure should be able to cope with.

> Even genirq guys can help us to convert to irq thread framework, I
> don't think there is good way to set priority for one irq thread.

What I'm saying is that this sounds like something it's reasonable to
want to do so if there's no way currently to get high priority handling
of timing sensitive interrupt controllers it'd be good if there could
be.
