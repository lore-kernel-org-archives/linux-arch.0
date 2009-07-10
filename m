From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 3/8] parisc: implement dma_mmap_coherent()
Date: Fri, 10 Jul 2009 18:30:50 +0000
Message-ID: <1247250650.3936.48.camel@mulgrave.site>
References: <s5hprc8n0od.wl%tiwai@suse.de> <s5hljmwn0iw.wl%tiwai@suse.de>
	 <1247238689.3936.16.camel@mulgrave.site>
	 <20090710181620.GA1019@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37823 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754823AbZGJSa5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2009 14:30:57 -0400
In-Reply-To: <20090710181620.GA1019@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, linux-arch@vger.kernel.org, Gerhard Pircher <gerhard_pircher@gmx.net>, Parisc List <linux-parisc@vger.kernel.org>

On Fri, 2009-07-10 at 19:16 +0100, Russell King wrote:
> On Fri, Jul 10, 2009 at 03:11:29PM +0000, James Bottomley wrote:
> > The design of coherent memory was for memory based device mailboxes
> > managed by the kernel ... trying to give userspace coherent access to
> > the same mailbox is problematic because it gives a direct way for the
> > process to interfere with a device function ... shouldn't whatever
> > you're trying to do be better accomplished by using an API to control
> > the device and keeping the coherent mailbox fully in the kernel address
> > space?
> 
> As far as sound DMA goes, it's not about mailboxes.  It's about a circular
> buffer which you want the device to DMA from direct to/from the DAC/ADC
> and have the application write/read data directly to/from that same
> buffer.

But that makes it sound like ordinary streaming DMA from a device to
user space ... that's what the dma_map_xx APIs are already designed to
handle:  I don't understand why you need coherent memory for this (which
can be a scarce resource on some platforms).

> Without this, you end up having to copy the sound data - at something
> around 200KB/s from applications into a driver managed buffer, which is
> quite an unnecessary overhead for the CPU.

Why?  The dma_map_xx API is designed to be zero copy.

James
