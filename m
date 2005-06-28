Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 13:47:36 -0700 (PDT)
Message-Id: <20050628.134736.45885284.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au>
	<20050628091704.GP4171@wotan.suse.de>
	<20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: ak@suse.de, sfr@canb.auug.org.au, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Date: Tue, 28 Jun 2005 12:18:28 +0100

> On Tue, Jun 28, 2005 at 11:17:04AM +0200, Andi Kleen wrote:
> > No, it's not because it makes it impossible to have 64bit processes
> > that run with 32bit ABI (not implemented right now but we don't
> > want to break that).
> > 
> > Please don't do this. It is absolutely the wrong thing to do.
> 
> So.  You want to deliver a signal to a task.  How do you know whether
> to send it a 64-bit signal or a 32-bit signal?

There is a difference between syscal ABI and execution ABI.
I think Andi is kind of right about this.

Why don't we do the following to resolve this issue?
Create a "is_compat_syscall()" macro, in compat syscall
trap entry, the bit is set, and it is cleared otherwise.

It nops out to always evaluate to "0" on non-compat platforms.

That should resolve all of the concerns, I think.
