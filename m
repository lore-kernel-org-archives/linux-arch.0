From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Introduce mips_late_time_init
Date: Wed, 8 Dec 2010 20:37:04 +0000
Message-ID: <20101208203704.GB30923@linux-mips.org>
References: <1291623812.31822.6.camel@paanoop1-desktop>
 <4CFD2095.9040404@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37440 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab0LHUhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Dec 2010 15:37:22 -0500
Content-Disposition: inline
In-Reply-To: <4CFD2095.9040404@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Anoop P A <anoop.pa@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Mon, Dec 06, 2010 at 09:42:45AM -0800, David Daney wrote:

> On 12/06/2010 12:23 AM, Anoop P A wrote:
> >This patch moves plat_time_init and clocksoure init funtion calls to
> >late_time_init.
> >
> 
> Why would you want to do this?
> 
> The current code works perfectly, so I see no reason to change it.

Well, not really.  By the time time_init is called kmalloc isn't ready yet.
That's why mips_clockevent_device pretty much had to be statically
allocated and is also why interrupts have to use setup_irq instead of
request_irq.

Keeping mips_clockevent_device statically allocated as per-CPU makes sense.
Less for the struct irqaction and he'll have to allocate one for each
VPE (think CPU) he installs a clockevent device on.

Running everything from late_time_init() instead allows the use of kmalloc.
X86 has the same issue with requiring kmalloc in time_init which is why
they had moved everything to late_time_init.

So the real question is, why can't we just move the call of time_init()
in setup_kernel() to where late_time_init() is getting called from for
all architectures, does anything rely on it getting called early?

  Ralf
