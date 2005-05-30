Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id j4UBZLjr132042
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 11:35:21 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4UBZLl5133124
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 13:35:21 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id j4UBZLJr022124
	for <linux-arch@vger.kernel.org>; Mon, 30 May 2005 13:35:21 +0200
In-Reply-To: <429AF694.4080104@yahoo.com.au>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <OFB45EDFAC.AFFB6ECD-ONC1257011.003ED09F-C1257011.003F9081@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 30 May 2005 13:34:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <czankel@tensilica.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-ID: <linux-arch.vger.kernel.org>

> > Well, currently there seems to be only the pfault interrupt that can
> > set TIF_NEED_RESCHED and pfault interrupts can't happen for idle. So
> > it should work. But if there is any chance that an interrupt will ever
> > set TIF_NEED_RESCHED we have to disable the interrupts before doing
> > the resched check.
>
> But other processors can set your TIF_NEED_RESCHED too,
> so simply disabling local interrupts does not give any
> synchronisation of TIF_NEED_RESCHED.

But these other processors need to send the idle cpu an IPI to make it
aware of the TIF_NEED_RESCHED bit. The order of events is important
here. While the interrupts are disabled the IPI is pending, only after
the enabled-wait psw has been loaded the IPI interrupts comes in.

After you threw in set_bit(TIF_NEED_RESCHED) from another processor
I realized that without the local_irq_disable() the code would even be
wrong. We can loose a reschedule without it, consider the following:
cpu-a checks for reschedule, cpu-b sets TIF_NEED_RESCHED, cpu-b sends
IPI, cpu-a receives IPI as external interrupt, cpu-a continues in
default_idle() after the reschedule check. With the NO_IDLE_HZ option
the cpu-a can now wait for a very long time until the next interrupt
wakes it up again.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
