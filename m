Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:54770 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbXJ2PMA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2007 11:12:00 -0400
Date: Mon, 29 Oct 2007 11:11:58 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Only show RESOURCES_64BIT on relevant architectures
Message-ID: <20071029151158.GC23138@fattire.cabal.ca>
References: <20071028201549.GA23138@fattire.cabal.ca> <20071028.180949.233462591.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028.180949.233462591.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Oct 28, 2007 at 06:09:49PM -0700, David Miller wrote:
> From: Kyle McMartin <kyle@mcmartin.ca>
> Date: Sun, 28 Oct 2007 16:15:49 -0400
> 
> > To quote lolcats: CONFIG_RESOURCES_64BIT DO NOT WANT!
> > 
> > I *think* I have the logic of this right... Anyway, I was annoyed by
> > having to do the bloody ugly casts to unsigned long long in
> > arch-specific code. As near as I can tell, we only want this selectable
> > in the case of PAE on x86, and some random PPC and MIPS embedded boards.
> > 
> > For everyone else, it should be whatever the value of 64BIT is.
> > 
> > And I can be happy and continue using unsigned long and going about my
> > merry business.
> > 
> > Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>
> 
> 32-bit sparc has 36-bit physical addresses and thus needs
> 64-bit resources too

I didn't realize this, since it wasn't set in any of the configs, or
select-ed by any of the Kconfig. Will add this in the next go 'round.

Cheers,
	Kyle
