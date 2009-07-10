From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] parisc: implement dma_mmap_coherent()
Date: Fri, 10 Jul 2009 19:16:20 +0100
Message-ID: <20090710181620.GA1019@flint.arm.linux.org.uk>
References: <s5hprc8n0od.wl%tiwai@suse.de> <s5hljmwn0iw.wl%tiwai@suse.de> <1247238689.3936.16.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59765 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZGJSQh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 14:16:37 -0400
Content-Disposition: inline
In-Reply-To: <1247238689.3936.16.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-arch@vger.kernel.org, Gerhard Pircher <gerhard_pircher@gmx.net>, Parisc List <linux-parisc@vger.kernel.org>

On Fri, Jul 10, 2009 at 03:11:29PM +0000, James Bottomley wrote:
> The design of coherent memory was for memory based device mailboxes
> managed by the kernel ... trying to give userspace coherent access to
> the same mailbox is problematic because it gives a direct way for the
> process to interfere with a device function ... shouldn't whatever
> you're trying to do be better accomplished by using an API to control
> the device and keeping the coherent mailbox fully in the kernel address
> space?

As far as sound DMA goes, it's not about mailboxes.  It's about a circular
buffer which you want the device to DMA from direct to/from the DAC/ADC
and have the application write/read data directly to/from that same
buffer.

Without this, you end up having to copy the sound data - at something
around 200KB/s from applications into a driver managed buffer, which is
quite an unnecessary overhead for the CPU.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
