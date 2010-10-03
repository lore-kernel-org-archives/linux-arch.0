From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 46/47] powerpc: Use new irq allocator
Date: Sun, 03 Oct 2010 09:53:56 -0700
Message-ID: <m1bp7bfc9n.fsf@fess.ebiederm.org>
References: <20100930221351.682772535@linutronix.de>
	<20100930221743.014571381@linutronix.de>
	<1285893737.2463.4.camel@pasglop>
	<alpine.LFD.2.00.1010011504380.2416@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1010011504380.2416@localhost6.localdomain6>
	(Thomas Gleixner's message of "Fri, 1 Oct 2010 15:07:19 +0200 (CEST)")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-arch.vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

>> That would make things much cleaner and in fact move one large step
>> toward being able to make powerpc virq scheme generic, which seems to be
>> a good idea from what I've heard :-)
>
> Yep.

I'm not certain about making the ppc virq scheme generic.  Maybe it is
just my distorted impression but I have the understanding that ppc irq
numbers mean nothing and are totally unstable whereas on x86 irq numbers
in general are stable (across kernel upgrades and changes in device
probe order) and the irq number has a useful hardware meaning.  Which
means you don't have to go through several layers of translation tables
to figure out which hardware pin you are talking about.

Eric
