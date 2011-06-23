Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:53719 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab1FWL6p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2011 07:58:45 -0400
Message-ID: <4E032940.5010205@ge.com>
Date: Thu, 23 Jun 2011 12:53:36 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing	PAGE_KERNEL_NOCACHE
References: <20110623114536.GA14011@linux-mips.org>
In-Reply-To: <20110623114536.GA14011@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110623115336.Gmv7Fn2d1GCx3sJGiY4hGPARibSvKMeQ6ZaaaleEBnQ@z>

On 23/06/11 12:45, Ralf Baechle wrote:
> On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi driver turns
> into tragedy:
> 
>   CC [M]  drivers/staging/comedi/drivers.o
> drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
> drivers/staging/comedi/drivers.c:505:41: error: ‘PAGE_KERNEL_NOCACHE’ undeclared (first use in this function)
> drivers/staging/comedi/drivers.c:505:41: note: each undeclared identifier is rep orted only once for each function it appears in
> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> 
> Restrict the driver to only those architectures that define PAGE_KERNEL_NOCACHE.
> 
> PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as SGI IP27
> are even uable to offer uncached operation - at least in the way an unwitting
> driver might assume.  I haven't looked in details how the driver is using
> the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-style using
> cached memory and the flush_kernel_vmap_range / invalidate_kernel_vmap_range
> APIs in conjunction with the DMA API is a practical alternative.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  drivers/staging/comedi/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
> index 1502d80..bccdc12 100644
> --- a/drivers/staging/comedi/Kconfig
> +++ b/drivers/staging/comedi/Kconfig
> @@ -2,6 +2,7 @@ config COMEDI
>  	tristate "Data acquisition support (comedi)"
>  	default N
>  	depends on m
> +	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE || X86

I'm sure I got comedi to compile on a 32-bit PPC board not that long ago. Has
something changed, or is this just not an exhaustive list?

>  	---help---
>  	  Enable support a wide range of data acquisition devices
>  	  for Linux.
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/devel


-- 
Martyn Welch (Principal Software Engineer) | Registered in England and
GE Intelligent Platforms                   | Wales (3828642) at 100
T +44(0)127322748                          | Barbirolli Square, Manchester,
E martyn.welch@ge.com                      | M2 3AB  VAT:GB 927559189
