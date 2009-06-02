From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 23:40:05 +0200
Message-ID: <20090602214005.GL32630@pengutronix.de>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com> <20090602211057.GA10800@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57424 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFBVkH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 17:40:07 -0400
Content-Disposition: inline
In-Reply-To: <20090602211057.GA10800@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-e

On Tue, Jun 02, 2009 at 10:10:58PM +0100, Russell King wrote:
> I really don't think combining SoC support is going to be realistic,
> device tree or not.  When we had just four machine types (RiscPC,
> EBSA110, EBSA285, Netwinder) I did look into this and came to the
> conclusion that it would be far too inefficient for there to be any
> win.
>
> The big problem we have is that the only commonality between different
> SoCs is that the CPU executes ARM instructions.  Everything else is
> entirely up to the SoC designer - eg location of memory, spacing of
> memory banks, type of interrupt controller, etc is all highly SoC
> specific.  Nothing outside of the ARM CPU itself is standardized.

And even with the cpu core, we usually build kernels with optimized
toolchains for their cpu family. But nevertheless - describing hardware
inside a mach* makes sense.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
