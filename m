Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17092.32853.100878.228467@cargo.ozlabs.ibm.com>
Date: Fri, 1 Jul 2005 09:29:25 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: RFC: is_compat_task
In-Reply-To: <20050630154904.GQ13890@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
	<20050628.134736.45885284.davem@davemloft.net>
	<20050629164127.58e97376.sfr@canb.auug.org.au>
	<20050629121228.GH21575@bragg.suse.de>
	<20050630175741.0fba8049.sfr@canb.auug.org.au>
	<20050630084255.GC13890@bragg.suse.de>
	<20050701003806.1de72653.sfr@canb.auug.org.au>
	<20050701012857.6b6de8f9.sfr@canb.auug.org.au>
	<20050630154904.GQ13890@bragg.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen writes:

> On Fri, Jul 01, 2005 at 01:28:57AM +1000, Stephen Rothwell wrote:
> > On Fri, 1 Jul 2005 00:38:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Like below?  I am not sure that this is better as we duplicate the code
> > > that selects the write_func ...
> > 
> > This is seeming like a lot of infrastructure change (I did the read
> > version as well) for a single (badly done) API.  How about we go with
> > is_compat_syscall() for 2.6.13 and revisit the VFS changes after that?
> 
> Please just do the infrastructure change. If we start with hacks
> they will never come out again.

The problem with that is that it seems horrible to me to interpret the
contents of a buffer being given to write() differently depending on
whether it's a 32-bit or a 64-bit task that is writing it.  The data
format *should* be designed so that it is wordsize-independent (and
preferably endian-independent too), or else it should at least be
self-describing.

Adding this infrastructure is just going to encourage people to do the
wrong thing in future.  I know we already have the input layer doing
the wrong thing, and we need to hack around that, but I think the hack
should be as small and self-contained as possible, rather than adding
a whole infrastructure to support the brokenness.

Regards,
Paul.
