Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 30 Jun 2005 17:49:04 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050630154904.GQ13890@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au> <20050629121228.GH21575@bragg.suse.de> <20050630175741.0fba8049.sfr@canb.auug.org.au> <20050630084255.GC13890@bragg.suse.de> <20050701003806.1de72653.sfr@canb.auug.org.au> <20050701012857.6b6de8f9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701012857.6b6de8f9.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ak@suse.de, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jul 01, 2005 at 01:28:57AM +1000, Stephen Rothwell wrote:
> On Fri, 1 Jul 2005 00:38:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Like below?  I am not sure that this is better as we duplicate the code
> > that selects the write_func ...
> 
> This is seeming like a lot of infrastructure change (I did the read
> version as well) for a single (badly done) API.  How about we go with
> is_compat_syscall() for 2.6.13 and revisit the VFS changes after that?

Please just do the infrastructure change. If we start with hacks
they will never come out again.

-Andi
