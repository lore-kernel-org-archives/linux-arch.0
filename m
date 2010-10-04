From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Mon, 4 Oct 2010 08:36:34 +0200
Message-ID: <20101004063634.GA2230@elte.hu>
References: <20100930221351.682772535@linutronix.de>
 <m1wrpzfctu.fsf@fess.ebiederm.org>
 <alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
 <m11v8692vo.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51825 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab0JDGhB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Oct 2010 02:37:01 -0400
Content-Disposition: inline
In-Reply-To: <m11v8692vo.fsf@fess.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Looking at this objectively I see a bitmap sized to the formula 
> 32*NR_CPUS with NR_CPUS expected to double every 18-24 months. Which 
> means in a decade our worst case will be 2M not 64k.

On a 16 TB box? Noise.

> Can we please build this with scalable interfaces so we don't have to 
> do this again in a couple of years, and so we don't have to have 
> little machines paying the price for big machines, and so that big 
> machines aren't hamstrung because of data structures built for little 
> machines.

Bitmaps are rather scalable, we use them all around the place.

> Perhaps this just requires using ida instead of a bitmap.

Erm, IDA/IDR uses a bitmap ...

IDA is a dynamically allocated bitmap - but for something as critical as 
IRQs i'd rather like to see a preallocated bitmap and platform control 
over the max (nr_irqs). We dont want to allow crappy drivers to install 
irq 0x12345678 and blow up the bitmap size to dozens of MB, etc.

Bitmaps are simple - and that's a virtue.

Thanks,

	Ingo
