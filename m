Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261519AbULFNbV@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63243 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261516AbULFNbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Dec 2004 08:31:21 -0500
Date: Mon, 6 Dec 2004 13:31:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: mask_irq
Message-ID: <20041206133115.A19395@flint.arm.linux.org.uk>
References: <20041206124553.GM15450@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206124553.GM15450@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Mon, Dec 06, 2004 at 12:45:53PM +0000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Dec 06, 2004 at 12:45:53PM +0000, Matthew Wilcox wrote:
> 
> I don't know when it happened, but mask_irq() is no longer required
> as an interface.  The following architectures still define and/or use
> it internally:
> 
> arm arm26 cris mips parisc ppc ppc64 sh sh64 x86_64

I guess this is a result of a quick grep without looking at the
results.  I think you'll find that mask_irq() isn't an interface
ARM architectures export, but is part of a function name, eg,
dummy_mask_unmask_irq().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
