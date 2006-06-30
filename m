Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:19699 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932565AbWF3Mjy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 08:39:54 -0400
Date: Fri, 30 Jun 2006 14:39:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
In-Reply-To: <1151670404.11575.5.camel@localhost>
Message-ID: <Pine.LNX.4.62.0606301435430.12536@pademelon.sonytel.be>
References: <1151670404.11575.5.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, ak@suse.de, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

	Hi Martin,

On Fri, 30 Jun 2006, Martin Schwidefsky wrote:
> --- linux-2.6/drivers/char/Kconfig	2006-06-30 13:35:13.000000000 +0200
> +++ linux-2.6-patched/drivers/char/Kconfig	2006-06-30 11:21:06.000000000 +0200
> @@ -765,7 +767,7 @@ config SGI_IP27_RTC
>  
>  config GEN_RTC
>  	tristate "Generic /dev/rtc emulation"
> -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390

You still don't like genrtc (for hwclock)? ;-)

> --- linux-2.6/drivers/ieee1394/Kconfig	2006-06-30 13:35:13.000000000 +0200
> +++ linux-2.6-patched/drivers/ieee1394/Kconfig	2006-06-30 11:21:06.000000000 +0200
> @@ -1,6 +1,7 @@
>  # -*- shell-script -*-
>  
>  menu "IEEE 1394 (FireWire) support"
> +	depends on PCI || BROKEN
>  
>  config IEEE1394
>  	tristate "IEEE 1394 (FireWire) support"
> diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
> --- linux-2.6/drivers/infiniband/Kconfig	2006-06-30 13:35:13.000000000 +0200
> +++ linux-2.6-patched/drivers/infiniband/Kconfig	2006-06-30 11:21:06.000000000 +0200
> @@ -1,4 +1,5 @@
>  menu "InfiniBand support"
> +	depends on !S390

Perhaps just `depends on PCI || BROKEN' (cfr. IEEE1394), so the whole menu will
be hidden for other non-PCI platforms?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
