Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 21:20:24 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] consolidate shmat usage
Message-ID: <20050405202024.GQ16601@linux-mips.org>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au> <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk> <20050405180132.15e386cd.sfr@canb.auug.org.au> <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk> <20050405211619.A19117@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405211619.A19117@flint.arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Apr 05, 2005 at 09:16:19PM +0100, Russell King wrote:

> glibc probably doesn't use the new sys_shmat() syscall yet - it's a
> relatively recent addition, so I think we have the opportunity to fix
> it if needs be.
> 
> However, I don't know the glibc sources well enough to comment on the
> state of play there.  And what's more, I don't know any active ARM
> glibc folk to ask about it.  Sorry.
> 
> (For the record, I've never been interested in glibc myself, and I've
> always hoped that there would be someone else to look after that side
> of things.  However, it appears that this stance hasn't really resulted
> in a long lasting ARM glibc effort.  Maybe I'm wrong, but I don't see
> _any_ signs out there which indicate otherwise.)

Since you already kept me on the cc list ;-) ARM libc seems to use the
good old wrapper syscall.

  Ralf
