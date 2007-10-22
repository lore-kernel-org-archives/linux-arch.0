Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49775 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbXJVUrm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Oct 2007 16:47:42 -0400
Message-ID: <471D0C54.7060207@garzik.org>
Date: Mon, 22 Oct 2007 16:47:16 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <20071022152912.GA841@linux-mips.org> <20071022112110.105b8e11.akpm@linux-foundation.org> <200710222110.34768.arnd@arndb.de> <20071022194714.GI27248@parisc-linux.org> <alpine.LFD.0.999.0710221254550.30120@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710221254550.30120@woody.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@ftp.linux.org.uk>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:

>> > On Mon, 22 Oct 2007, Matthew Wilcox wrote:
>>> > > We certainly don't want to encourage people to blindly make those
>>> > > conversions ... and I've seen the results of encouraging kernel janitors
>>> > > to do things a certain way.

>> > There's another issue: the "irqsave/irqrestore" versions are much safer 
>> > than the plain "irq" versions, in case the caller already has interrupts 
>> > disabled. 

> It's almost always a bug to do spin_lock_irq() when local interrupts are
> disabled.


Let me add to the chorus of voices:  I continually see two cases where 
real bugs crop up:

1) hacker uses spin_lock_irq() in incorrect context (where it is not 
safe to do a blind enable/disable)

2) hacker uses spin_lock_irq() correctly, but the surrounding code 
changes, thus invalidating prior assumptions.

I would even go so far as to support the drastic measure of deleting 
spin_lock_irq().

spin_lock_irqsave() generates fewer bugs, is more future-proof, and by 
virtue of 'flags' permits architectures a bit more flexibility.

	Jeff



