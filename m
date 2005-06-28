Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 14:05:35 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050628120534.GM8035@wotan.suse.de>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <ak@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 28, 2005 at 12:18:28PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 28, 2005 at 11:17:04AM +0200, Andi Kleen wrote:
> > No, it's not because it makes it impossible to have 64bit processes
> > that run with 32bit ABI (not implemented right now but we don't
> > want to break that).
> > 
> > Please don't do this. It is absolutely the wrong thing to do.
> 
> So.  You want to deliver a signal to a task.  How do you know whether
> to send it a 64-bit signal or a 32-bit signal?

For the 32bit-on-64bit case?  You always send 64bit.  Either the
ABI defines 64bit signal data structures or some monitor (like
valgrind or qemu) catches and converts signals themselves.
For the ELF32 case you can test.

-Andi
