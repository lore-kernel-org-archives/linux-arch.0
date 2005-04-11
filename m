Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 11 Apr 2005 21:29:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] consolidate shmat usage
Message-ID: <20050411212934.C5070@flint.arm.linux.org.uk>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au> <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk> <20050405180132.15e386cd.sfr@canb.auug.org.au> <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk> <20050407010501.1631e14f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407010501.1631e14f.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Thu, Apr 07, 2005 at 01:05:01AM +1000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Apr 07, 2005 at 01:05:01AM +1000, Stephen Rothwell wrote:
> On Tue, 5 Apr 2005 14:03:12 +0100 Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > Umm.  I think you've just discovered a bug in ARM and MIPS.  I don't see
> > any code in glibc for handling the 4-argument version of sys_shmat.
> > Russell, Ralf, could you comment?
> 
> OK, assuming that using the 4 argument version of sys_shmat as a system
> call, here is another version of the patch (not tested) for comment.

I suspect you mean "assuming that using the 4 argument version of
sys_shmat as a system call is wrong" because that seems to be what
you've implemented.

This patch converts ARM sys_shmat from the 4 arg to the 3 arg version.
I'm mostly happy with that, except for one exception - the effect of
running a glibc with sys_shmat support against an older kernel with
the 4 argument version will be inherently problematic - the system
call will appear to succeed, but not as one would expect.

Since sys_shmat was added to ARM on 2 March 2005, it means that the 4
argument version is in both 2.6.12-rc1 and 2.6.12-rc2, but not 2.6.11.
I guess that means we can fix the API now, before 2.6.12 happens.  This
would mean that we don't expect the kernel API to be stable for new
features until the following non-rc release?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
