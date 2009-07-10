Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42609 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343AbZGJS71 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2009 14:59:27 -0400
Subject: Re: [PATCH 3/8] parisc: implement dma_mmap_coherent()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20090710183925.GB1019@flint.arm.linux.org.uk>
References: <s5hprc8n0od.wl%tiwai@suse.de> <s5hljmwn0iw.wl%tiwai@suse.de>
	 <1247238689.3936.16.camel@mulgrave.site>
	 <20090710181620.GA1019@flint.arm.linux.org.uk>
	 <1247250650.3936.48.camel@mulgrave.site>
	 <20090710183925.GB1019@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 18:59:23 +0000
Message-ID: <1247252363.3936.52.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, linux-arch@vger.kernel.org, Gerhard Pircher <gerhard_pircher@gmx.net>, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20090710185923.4guIvsnjiG0XkOtxPun-cYrJZalPr3ewgcjloYrNP0s@z>

On Fri, 2009-07-10 at 19:39 +0100, Russell King wrote:
> On Fri, Jul 10, 2009 at 06:30:50PM +0000, James Bottomley wrote:
> > On Fri, 2009-07-10 at 19:16 +0100, Russell King wrote:
> > > As far as sound DMA goes, it's not about mailboxes.  It's about a circular
> > > buffer which you want the device to DMA from direct to/from the DAC/ADC
> > > and have the application write/read data directly to/from that same
> > > buffer.
> > 
> > But that makes it sound like ordinary streaming DMA from a device to
> > user space ... that's what the dma_map_xx APIs are already designed to
> > handle:  I don't understand why you need coherent memory for this (which
> > can be a scarce resource on some platforms).

> The streaming APIs are inefficient for this.  Consider the overhead of
> having to writeback and invalidate caches at 200KB/s (which is what
> you're requiring ARM to do).  That's far too much CPU overhead.

Um, but streaming APIs are what we use for all block and network I/O
from user space ... we don't see huge performance problems running up to
gigabits.  Even on parisc where we have to flush several times to make
this happen we can get up to several hundred megabytes per second.

> It's much more efficient to use non-cached memory for this on ARM.
> 
> We've been doing this for years and years, it's well proven.
> 
> > Why?  The dma_map_xx API is designed to be zero copy.
> 
> Except with a rather large overhead of repetitive cache handling.

OK, so this is the bit I don't get ... why isn't the streaming a problem
for I/O then, which even on arm wants far more than 200kb/s?

James


