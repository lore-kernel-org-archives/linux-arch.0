Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 5 Apr 2005 21:00:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] consolidate shmat usage
Message-ID: <20050405200055.GO16601@linux-mips.org>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au> <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk> <20050405180132.15e386cd.sfr@canb.auug.org.au> <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405130312.GC16157@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
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

On MIPS it affects only 64-bit systems running native code which few people
do.  Fixing it as I'm writing this,

  Ralf
