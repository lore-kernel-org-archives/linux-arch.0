Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 21:16:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] consolidate shmat usage
Message-ID: <20050405211619.A19117@flint.arm.linux.org.uk>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au> <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk> <20050405180132.15e386cd.sfr@canb.auug.org.au> <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Tue, Apr 05, 2005 at 02:03:12PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Apr 05, 2005 at 02:03:12PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 05, 2005 at 06:01:32PM +1000, Stephen Rothwell wrote:
> > On Wed, 23 Mar 2005 14:51:32 +0000 Matthew Wilcox <matthew@wil.cx> wrote:
> > > I dislike the naming here.  The manpage for shmat is the three-argument
> > > version.  The only reason we have the four-argument version is because
> > > of the silly sys_ipc multiplexer.  So I think sys_shmat() should be
> > > the three-argument form and we should rename the existing sys_shmat()
> > > to something like ipc_shmat().  Does it need to be asmlinkage?
> > 
> > OK, I have changed sys_shmat to sys_shmat4 and sys_shmatcall to sys_shmat.
> > There are some architectures that use each of these directly as system
> > calls.
> 
> Umm.  I think you've just discovered a bug in ARM and MIPS.  I don't see
> any code in glibc for handling the 4-argument version of sys_shmat.
> Russell, Ralf, could you comment?

glibc probably doesn't use the new sys_shmat() syscall yet - it's a
relatively recent addition, so I think we have the opportunity to fix
it if needs be.

However, I don't know the glibc sources well enough to comment on the
state of play there.  And what's more, I don't know any active ARM
glibc folk to ask about it.  Sorry.

(For the record, I've never been interested in glibc myself, and I've
always hoped that there would be someone else to look after that side
of things.  However, it appears that this stance hasn't really resulted
in a long lasting ARM glibc effort.  Maybe I'm wrong, but I don't see
_any_ signs out there which indicate otherwise.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
