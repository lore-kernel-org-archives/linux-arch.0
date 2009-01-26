From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] cpus4096 tree, part 3
Date: Mon, 26 Jan 2009 11:09:59 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901261107280.5284@localhost.localdomain>
References: <alpine.LFD.2.00.0901021149020.5086@localhost.localdomain> <20090102203839.GA26850@elte.hu> <alpine.LFD.2.00.0901021531140.3179@localhost.localdomain> <20090103193859.GB9805@elte.hu> <alpine.LFD.2.00.0901031225020.3179@localhost.localdomain>
 <20090103203621.GA2491@elte.hu> <20090103213856.GA24138@elte.hu> <alpine.LFD.2.00.0901031347570.3179@localhost.localdomain> <20090103223723.GA17047@elte.hu> <20090105011416.GG32239@wotan.suse.de> <20090105011630.GI32239@wotan.suse.de>
 <20090126110054.bdddbf38.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35832 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753998AbZAZTLF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jan 2009 14:11:05 -0500
In-Reply-To: <20090126110054.bdddbf38.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, mingo@elte.hu, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, travis@sgi.com, linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com, suresh.b.siddha@intel.com, arjan@infradead.org, hpa@zytor.com, tglx@linutronix.de



On Mon, 26 Jan 2009, Andrew Morton wrote:
> > +	write = error_code & PF_WRITE;
> 
> What's going on here?  We set `error_code' to PF_WRITE, which is some
> x86-specific thing.

No. We set "write" to non-zero if it was a write fault.

> >  	fault = handle_mm_fault(mm, vma, address, write);
> 
> and then pass it into handle_mm_fault(), which is expecting a bunch of
> flags in the FAULT_FLAG_foo domain.

No. "handle_mm_fault()" takes an integer that is non-zero if it's a write, 
zero if it's a read. That's how it has _always_ worked.

I don't see where you find that FAULT_FLAG_foo thing. That's much deeper 
down, when people do things like

        unsigned int flags = FAULT_FLAG_NONLINEAR |
                                (write_access ? FAULT_FLAG_WRITE : 0);

based on that whole "write_access" flag.

		Linus
