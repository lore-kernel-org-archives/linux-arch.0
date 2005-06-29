Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 29 Jun 2005 14:12:28 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050629121228.GH21575@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629164127.58e97376.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, matthew@wil.cx, ak@suse.de, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 29, 2005 at 04:41:27PM +1000, Stephen Rothwell wrote:
> On Tue, 28 Jun 2005 13:47:36 -0700 (PDT) "David S. Miller" <davem@davemloft.net> wrote:
> >
> > Why don't we do the following to resolve this issue?
> > Create a "is_compat_syscall()" macro, in compat syscall
> > trap entry, the bit is set, and it is cleared otherwise.
> > 
> > It nops out to always evaluate to "0" on non-compat platforms.
> 
> How about the patch below which defines is_compat_syscall() for ppc64 (and
> all the non-compat-requiring archs)?  (Yes, the ppc64 syscall entry really
> checks the thread flag.) The patch alos includes the fixes for the input
> layer mess.
> for the other 64 bit architectures.

I think for the particular input case it would be still better
to just define ->compat_write at the VFS level.


This would require a new compat_sys_write() wrapper, but that would
be straight forward.

-Andi
