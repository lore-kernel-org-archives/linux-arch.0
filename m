Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268111AbUJSJYd@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4358 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268104AbUJSJYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 05:24:06 -0400
Date: Tue, 19 Oct 2004 10:23:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: All archs: NO_IRQ definition
Message-ID: <20041019102359.A8991@flint.arm.linux.org.uk>
References: <1098169077.11400.51.camel@gaston> <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Tue, Oct 19, 2004 at 10:22:38AM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 19, 2004 at 10:22:38AM +0100, Matthew Wilcox wrote:
> BTW, we could just force everyone to add it themselves by merging this
> patch:

IRQ_NONE?  What's that?  We're talking about NO_IRQ here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
