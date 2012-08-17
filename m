From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 02/31] arm64: Kernel booting and initialisation
Date: Fri, 17 Aug 2012 14:21:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1208171407540.1541@xanadu.home>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-3-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1208161438110.1541@xanadu.home>
 <201208171120.40740.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:60581 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758706Ab2HQSVZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 14:21:25 -0400
In-reply-to: <201208171120.40740.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Fri, 17 Aug 2012, Arnd Bergmann wrote:

> On Thursday 16 August 2012, Nicolas Pitre wrote:
> > Some people will want to use bzip2 or whatever other decompressor du 
> > jour.  Maybe this shouldn't be gzip specific, or just presented as a 
> > possible option?
> 
> Good point. Whether this should be part of this document depends on
> what assumptions we make about the boot loader getting the image
> in the first place.
> 
> In the strict sense, we are documenting the interface between the boot
> loader and the kernel here, which already specifies that  the kernel
> must be uncompressed by the time we enter it. If the boot loader wants
> to add its own encryption or compression methods, or its own headers
> in front of the binary, the boot protocol isn't really impacted.

Right.  And someone else will insist on wrapping the kernel into a boot 
loader specific image format e.g. u-Boot.  If all those variations could 
be kept out of the kernel build that would be a good thing.

That means the kernel should be wrapped/compressed/scrambled at 
installation time, not at build time.  This way the kernel image remains 
universal and flexibility in its installation is possible.

> That said, I think it's a good idea to also specify what kind of 
> format we want to be used, e.g. a stripped ELF Image compressed with 
> one of gzip/bzip2/lzo/xz and with no other headers added, on a 
> vfat/ext4/btrfs formatted file system. There are probably a lot of 
> other things one might want to specify if we go down this route. Or we 
> could refer to the UEFI spec and mandate that the same format that 
> UEFI uses should be used here independent of what boot loader is used. 
> I think we can still allow other ways to get to the image for deeply 
> embedded systems, e.g. linking the kernel into the boot loader as a 
> blob on tightly constrained systems. For that case, we'd only specify 
> the interface between boot loader and kernel as described above.

I don't think we'll have to concern ourselves with tightly constrained 
systems that much on ARM64.


Nicolas
