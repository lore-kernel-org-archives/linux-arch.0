Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 11:50:48 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050206105047.GB6819@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org> <20050205090619.C30866@flint.arm.linux.org.uk> <20050205154448.1cc89ee9.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205154448.1cc89ee9.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Russell King <rmk@arm.linux.org.uk>, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Feb 05, 2005 at 03:44:48PM -0800, David S. Miller wrote:
> On Sat, 5 Feb 2005 09:06:19 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > Except that "addr_limit" may be defined by an architecture to be zero
> > (which can be interpreted as 4GB by the arch specific code) for the
> > case where we allow kernel mode access.
> 
> I believe this to be a problematic scheme, let me explain why.
> 
> First, "set_fs(KERNEL_DS)" allows kernel mode access, but it absolutely
> must not allow user mode accesses.  It seems to suggest we might need
> some "addr_min" value for access_ok() checking purposes...

That's an unreasonable requirement which no architecture other than
those with truly separate address spaces follow.

I think on the others it would lead to quite bad code bloat
for the additional tests (access_ok is called very often) 

-Andi
