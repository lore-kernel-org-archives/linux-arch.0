From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 3/8] parisc: implement dma_mmap_coherent()
Date: Fri, 17 Jul 2009 19:16:49 +0000
Message-ID: <1247858209.7319.35.camel@mulgrave.site>
References: <s5hprc8n0od.wl%tiwai@suse.de> <s5hljmwn0iw.wl%tiwai@suse.de>
	 <1247238689.3936.16.camel@mulgrave.site>
	 <20090710181620.GA1019@flint.arm.linux.org.uk>
	 <1247250650.3936.48.camel@mulgrave.site>
	 <20090710183925.GB1019@flint.arm.linux.org.uk>
	 <1247252363.3936.52.camel@mulgrave.site>  <s5hljmn8kjg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <s5hljmn8kjg.wl%tiwai@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, Gerhard Pircher <gerhard_pircher@gmx.net>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2009-07-17 at 16:13 +0200, Takashi Iwai wrote:
> [Sorry for the late follow-up as I've been absent]
> 
> At Fri, 10 Jul 2009 18:59:23 +0000,
> James Bottomley wrote:
> > 
> > On Fri, 2009-07-10 at 19:39 +0100, Russell King wrote:
> > > On Fri, Jul 10, 2009 at 06:30:50PM +0000, James Bottomley wrote:
> > > > On Fri, 2009-07-10 at 19:16 +0100, Russell King wrote:
> > > > > As far as sound DMA goes, it's not about mailboxes.  It's about a circular
> > > > > buffer which you want the device to DMA from direct to/from the DAC/ADC
> > > > > and have the application write/read data directly to/from that same
> > > > > buffer.
> > > > 
> > > > But that makes it sound like ordinary streaming DMA from a device to
> > > > user space ... that's what the dma_map_xx APIs are already designed to
> > > > handle:  I don't understand why you need coherent memory for this (which
> > > > can be a scarce resource on some platforms).
> > 
> > > The streaming APIs are inefficient for this.  Consider the overhead of
> > > having to writeback and invalidate caches at 200KB/s (which is what
> > > you're requiring ARM to do).  That's far too much CPU overhead.
> > 
> > Um, but streaming APIs are what we use for all block and network I/O
> > from user space ... we don't see huge performance problems running up to
> > gigabits.  Even on parisc where we have to flush several times to make
> > this happen we can get up to several hundred megabytes per second.
> 
> Well, the requirement of the non-streaming mmap is rather a historical
> reason.  From the fairly early time, the sound driver provided the
> mmap of a whole ring buffer since it's practical and efficient for
> real-time sound processes.  But, usually the mmap mode is optional.
> If it's not supported, apps should fall back to the normal read/write
> mode.

But what I don't understand is why you can't treat the ring buffer as
streaming.  Sure, you have a head pointer and a tail pointer, but
everything between head and tail is owned by the device and everything
between tail and head is owned by the kernel, surely?  In that case, you
can manipulate head and tail movements simply via the streaming API?
(when head moves, map the delta to the device; when tail moves, map the
delta to the kernel) and we can simply then use the standard APIs?

> Now, the problem is that we have no way to tell whether the DMA
> ring-buffer mmap is available or not on each architecture.  So, my
> proposal has basically two meanings:
> 
> - clarify which arch / platform supports the coherent DMA mapping
>   of a whole ring-buffer
> - provide the same API to cover the possible archs / platforms
> 
> In that sense, if a few (or all) PA-RISC platforms don't give the
> proper coherent mapping that the sound apps require, it's OK.  We
> just drop the flag in the driver as "unsupported", then.

That would work for us too ... I can see that x86 will have little
problem with this, but I can predict that most other architectures will
have some difficulty.

> So... before going to the detail of PA-RISC implementation, I'd like
> to know your opinions: whether applying dma_mmap_coherent() to
> possible archs/platforms is a reasonable solution for such a
> scenario.

Realistically, the only way to make it work as you want on parisc is to
have a kernel/user congruence (it's an address rule [virtual addresses
are equal modulo the congruence step, which is 4MB]) which would ensure
this would work without flushing ... that's hard for the kernel to make
happen on its own.

> [Why not using the standard map->sync procedure is another level of
>  question :)  My goal here is to improve the current (partly broken)
>  situation in a minimal effort.  The change of mmap procedure would
>  lead to major rewrites of API, and thus has to be discussed more
>  deeply.]

So, yes, there is an equivalent used by the frame buffer which basically
tries to place a dma mapped page into a user address space ... that
might also work in this case.

> Any comments appreciated.

James


