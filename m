Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 1 Jul 2005 15:48:38 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050701134838.GA10260@wotan.suse.de>
References: <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au> <20050629121228.GH21575@bragg.suse.de> <20050630175741.0fba8049.sfr@canb.auug.org.au> <20050630084255.GC13890@bragg.suse.de> <20050701003806.1de72653.sfr@canb.auug.org.au> <20050701012857.6b6de8f9.sfr@canb.auug.org.au> <20050630154904.GQ13890@bragg.suse.de> <17092.32853.100878.228467@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17092.32853.100878.228467@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andi Kleen <ak@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Adding this infrastructure is just going to encourage people to do the
> wrong thing in future.  I know we already have the input layer doing
> the wrong thing, and we need to hack around that, but I think the hack
> should be as small and self-contained as possible, rather than adding

It won't be. It needs hacks in the system call entry part and
in other critical parts.  

> a whole infrastructure to support the brokenness.

I agree that a big fat comment, something like

"If you need to use this you did something very wrong and should 
be ashamed." (with a bit more explanation) 

on the new vectors would be a good idea.

On the other hand we probably need more Documentation on how
to design data structures to be compat clean. Too many people
get this wrong and it is admittedly a bit of black art.

-Andi
