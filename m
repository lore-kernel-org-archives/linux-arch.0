Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:56542 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0JDBNb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2010 21:13:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20100930221351.682772535@linutronix.de>
	<m1wrpzfctu.fsf@fess.ebiederm.org>
	<alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
Date: Sun, 03 Oct 2010 18:13:15 -0700
In-Reply-To: <alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
	(Thomas Gleixner's message of "Sun, 3 Oct 2010 21:16:47 +0200 (CEST)")
Message-ID: <m11v8692vo.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [patch 00/47] Sparse irq rework
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101004011315.aZpNVzTe6ZqrBPWRvHJ-b7zU3DepXPzzITkZXFqDsnw@z>

Thomas Gleixner <tglx@linutronix.de> writes:

>> I don't know that I have a problem with this but I do have a problem
>> with using a bitmap.  A lot of the kernels irq usage has been distored
>> because we use a compact array, that we cannot grow over time.  Using a
>> bitmap here essentially removes 90% of the point of sparse irq.  The
>> ability to remove a hard coded NR_IRQS from the kernel.
>
> Well, lets look at some (un)realistic numbers:
>
> Assume 16k cores and 32 irqs / core. That's 512k interrupts and
> requires a 64k bitmap.
>
> If we hit that limit, then we have some other more serious problems to
> solve.

Possibly. 

Fundamentally keeping NR_IRQS anywhere I see as a problem, and it
really disturbs me.  Even nr_irqs I see as pretty fishy.

Looking at this objectively I see a bitmap sized to the formula
32*NR_CPUS with NR_CPUS expected to double every 18-24 months.
Which means in a decade our worst case will be 2M not 64k.

Can we please build this with scalable interfaces so we don't have to do
this again in a couple of years, and so we don't have to have little
machines paying the price for big machines, and so that big machines
aren't hamstrung because of data structures built for little machines.

Perhaps this just requires using ida instead of a bitmap.


I really think it is a mistake to use an irq number outside of the
functions in interrupt.h that go to the drivers and the userspace
display functions.

Eric

