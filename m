Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269192AbUJUH0y@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270321AbUJUH0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Oct 2004 03:26:15 -0400
Date: Thu, 21 Oct 2004 08:26:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Interrupts & total mess
Message-ID: <20041021082600.A31133@flint.arm.linux.org.uk>
References: <1098338732.3939.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098338732.3939.20.camel@gaston>; from benh@kernel.crashing.org on Thu, Oct 21, 2004 at 04:05:32PM +1000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Oct 21, 2004 at 04:05:32PM +1000, Benjamin Herrenschmidt wrote:
> Which is seriously starting to make no sense, especially when you don't
> really know who is including who, with also the strange rule of never
> including linux/irq.h directly from a driver since the arch may not use
> the definitions in there, etc... it's a complete can of worms...
> 
> So basically, linux/irq.h should be asm-generic/irq.h right ?

Correct, which is why I recently sent a patch to lkml to remove the
wrongly placed include file - in the hope that someone who cares about
it would fix it as you're suggesting (and that other people can suffer
some of the repeated breakage caused by that misplaced file.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
