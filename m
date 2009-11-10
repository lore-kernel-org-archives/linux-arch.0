From: Imre Deak <imre.deak@nokia.com>
Subject: DMA from user space buffer/VIPT cache flushing wows (was: Minutes:
	21 Sept,09 RMK meeting)
Date: Tue, 10 Nov 2009 18:03:34 +0200
Message-ID: <20091110160334.GE734@localhost>
References: <20091027163551.GA1446@flint.arm.linux.org.uk> <20091028.143432.241464826.Hiroshi.DOYU@nokia.com> <20091028174920.GA20945@flint.arm.linux.org.uk> <20091029.151251.45877478.Hiroshi.DOYU@nokia.com> <20091029133703.GA3860@flint.arm.linux.org.uk> <20091106151558.GA7986@localhost> <20091108184753.GA31433@flint.arm.linux.org.uk> <20091109001509.GB28928@localhost> <20091109101056.GA29621@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52303 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749AbZKJQCy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Nov 2009 11:02:54 -0500
Content-Disposition: inline
In-Reply-To: <20091109101056.GA29621@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-arch@vger.kernel.org, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "vikram.pandita@ti.com" <vikram.pandita@ti.com>, "tony@atomide.com" <tony@atomide.com>, "rak@arm.linux.org.uk" <rak@arm.linux.org.uk>, "rhishi@ti.com" <rhishi@ti.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Mon, Nov 09, 2009 at 11:10:56AM +0100, ext Russell King wrote:
> On Mon, Nov 09, 2009 at 02:15:09AM +0200, Imre Deak wrote:
> > The problem with mlock is that in case of shared memory it needs to
> > be called in the context of each process that does flushing. This
> > I think complicates unnecessarily the quota management as we'd have
> > to increase the mlock quota for each such process.
> 
> We have to deal with the cache lines associated with the user addresses,
> otherwise we're not solving anything and userspace can't do any DMA.
> The easiest all-round solution is to operate on the user addresses.
> However, if those user PTEs can vanish beneath us, that's bad news.
> We have to have some way to lock them in while the cache operation
> occurs.

Yes but this is purely an ARM VIPT architecture specific issue and so
any solution should be contained in the kernel if at all possible. And
in this case it is possible using kernel addresses as you also stated.

> The only way to do that would be to hold the spinlock for the page table,
> but spinlocks are no-ops on UP (so the cache flush could be preempted,
> and the page swapped out).
> 
> > As far as I know
> > no other architectures require mlock for DMA'ing so it wouldn't be
> > nice to introduce arch specific tweaks in the process management
> > level.
> 
> Let me be totally clear about this: The Linux Kernel does *not* support
> user-driven DMA operations on any architecture.

By user-driven DMA you mean DMA'ing directly from an _arbitrary_ user space
buffer? The V4L2_MEMORY_USERPTR method supports this. That at least
contradicts with your statement.

> That's why no other architectures require mlock for DMA from userspace -
> the problem does not exist elsewhere because there is no one else doing
> this.  Everyone else writes proper kernel-side drivers, even if they're
> just a message passing API.

What do you mean by proper? Does the kernel support only the following two
DMA methods:

- directly from a buffer allocated by the driver and mapped by user space
- from an arbitrary user space buffer by first copying it to a secondary
  buffer allocated by the driver

If this is true it's not possible to DMA for example from an SHM buffer,
something done often for shared 3D pixel buffers.

> > I don't understand why can't we flush through the kernel address of
> > each page. I know you mentioned the aliasing issue before, but that
> > needs to be solved at other places too that flush through kernel
> > addresses, for example __flush_anon_page, couldn't this also work in
> > a similar way?
> 
> For __flush_anon_page, we only flush the user mapping if we have VIVT
> caches.  VIVT caches don't care about whether there's a mapping present
> and so don't oops the kernel if there isn't a page present.
> 
> For aliasing VIPT caches, we can get away with re-mapping a page at an
> address with the same cache colour as the user mapping, and flushing
> it there to get rid of user data - and so this avoids the problem of
> the user mapping disappearing beneath us.  This 'trick' is specific to
> aliasing VIPT caches only.
> 
> So, yes, we could do it this way, conditional on the cache type, and
> for VIPT, map each page into a high kernel address, operate on it, and
> unmap it, thereby eating through additional TLB entries for each page.

To me this seems to be still much better solution than the mlock way.
With mlocking you have to eat through additional TLB entries anyway,
since mlock will call __get_user_pages internally which does cache
flushing on ARM for each page through it's kernel address.

Additionally as I said we would need a kernel interface for flushing
user space buffers and mlock is not exposed to drivers. For that we
would also need to add reference counting for mlock.

--Imre
