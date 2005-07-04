Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17096.44712.93088.756834@cargo.ozlabs.ibm.com>
Date: Mon, 4 Jul 2005 13:36:08 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: RFC: is_compat_task
In-Reply-To: <20050701134838.GA10260@wotan.suse.de>
References: <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
	<20050630175741.0fba8049.sfr@canb.auug.org.au>
	<20050630084255.GC13890@bragg.suse.de>
	<20050701003806.1de72653.sfr@canb.auug.org.au>
	<20050701012857.6b6de8f9.sfr@canb.auug.org.au>
	<20050630154904.GQ13890@bragg.suse.de>
	<17092.32853.100878.228467@cargo.ozlabs.ibm.com>
	<20050701134838.GA10260@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen writes:

> > Adding this infrastructure is just going to encourage people to do the
> > wrong thing in future.  I know we already have the input layer doing
> > the wrong thing, and we need to hack around that, but I think the hack
> > should be as small and self-contained as possible, rather than adding
> 
> It won't be. It needs hacks in the system call entry part and
> in other critical parts.  

Unfortunately it's not just compat versions of read and write, there
are pread/pwrite, and the various socket send and receive functions.
The number of extra bits of infrastructure we need to add seems to
just keep growing.  On the other hand, with an is_compat_syscall() we
could handle all of those with one piece of infrastructure.

Paul.
