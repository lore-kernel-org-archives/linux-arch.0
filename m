Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261519AbULFNgc@vger.kernel.org>
Received: from pD956258C.dip.t-dialin.net ([217.86.37.140]:8338 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261312AbULFNgc
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Dec 2004 08:36:32 -0500
Date: Mon, 6 Dec 2004 14:36:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: mask_irq
Message-ID: <20041206133627.GB19072@linux-mips.org>
References: <20041206124553.GM15450@parcelfarce.linux.theplanet.co.uk> <20041206133115.A19395@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206133115.A19395@flint.arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Dec 06, 2004 at 01:31:15PM +0000, Russell King wrote:

> > I don't know when it happened, but mask_irq() is no longer required
> > as an interface.  The following architectures still define and/or use
> > it internally:
> > 
> > arm arm26 cris mips parisc ppc ppc64 sh sh64 x86_64
> 
> I guess this is a result of a quick grep without looking at the
> results.  I think you'll find that mask_irq() isn't an interface
> ARM architectures export, but is part of a function name, eg,
> dummy_mask_unmask_irq().

Same for MIPS but it deserved a little cleanup anyway which I just did.

  Ralf
