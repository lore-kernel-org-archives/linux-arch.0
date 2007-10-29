Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:58710 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758953AbXJ2PVx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2007 11:21:53 -0400
Date: Mon, 29 Oct 2007 11:21:52 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Only show RESOURCES_64BIT on relevant architectures
Message-ID: <20071029152152.GD23138@fattire.cabal.ca>
References: <20071028201549.GA23138@fattire.cabal.ca> <20071029081010.GA32160@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071029081010.GA32160@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Oct 29, 2007 at 08:10:10AM +0000, Russell King wrote:
> On Sun, Oct 28, 2007 at 04:15:49PM -0400, Kyle McMartin wrote:
> > To quote lolcats: CONFIG_RESOURCES_64BIT DO NOT WANT!
> > 
> > I *think* I have the logic of this right... Anyway, I was annoyed by
> > having to do the bloody ugly casts to unsigned long long in
> > arch-specific code. As near as I can tell, we only want this selectable
> > in the case of PAE on x86, and some random PPC and MIPS embedded boards.
> 
> May I suggest trying:
> 
> $ grep RESOURCES_64BIT=y arch/*/configs/* arch/*/defconfig
> 
> to locate those architectures which use this?
> 
> FYI, that grep says ARM, ia64, mips, parisc, powerpc, PPC, s390, sparc64,
> and x86 use this feature.
> 

It would be nice if the people who actually needed it would have
select-ed it. That's how I built the list.

Most of the other examples you listed are obviously 64bit... there should be
more occurances, but I guess they've (alpha, for instance) not updated
their defconfig in a dogs age.

Anyway, sorry I didn't notice ARM. I'll add it to the list on the next
round.

Regards,
	Kyle
(but seriously, this should be select-ed, not just set in a defconfig
 somewhere...)
