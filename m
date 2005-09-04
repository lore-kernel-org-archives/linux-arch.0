Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 4 Sep 2005 07:28:52 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Fwd: [PATCH 2.6.13] lockless pagecache 2/7]
Message-ID: <20050904132852.GA4316@parisc-linux.org>
References: <4317F2FE.8030109@yahoo.com.au> <20050902.003940.68050984.davem@davemloft.net> <431807DD.5030105@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431807DD.5030105@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 02, 2005 at 06:05:49PM +1000, Nick Piggin wrote:
> David S. Miller wrote:
> >Sparc32 lacks compare and exchange.  I think PARISC lacks it
> >as well.
> >
> >For these older SMP systems, at best you can assume there
> >is some kind of spinlock and perhaps a straight atomic
> >exchange instruction.  You really can't assume the existance
> >of compare-and-swap.
> >
> 
> Thanks David, I suspected as much.
> 
> PARISC emulates cmpxchg. I suspect sparc could do the same?
> (provided all access goes through the atomic_xxx accessors)

If Sparc has atomic stores to aligned addresses (and I bet it does),
then the PA-RISC style emulation should work just fine.
