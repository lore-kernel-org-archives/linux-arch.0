Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:60599 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751216AbWEQLSb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 May 2006 07:18:31 -0400
Date: Wed, 17 May 2006 13:18:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] s390 kconfig cleanup.
In-Reply-To: <1147853851.6661.2.camel@localhost>
Message-ID: <Pine.LNX.4.62.0605171314440.30686@pademelon.sonytel.be>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
 <20060515212431.GA25010@moss.sous-sol.org> <1147766908.5289.4.camel@localhost>
 <20060516211216.GE23243@moss.sous-sol.org> <1147853851.6661.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 17 May 2006, Martin Schwidefsky wrote:
> --- linux-2.6/drivers/char/Kconfig	2006-04-13 10:36:54.000000000 +0200
> +++ linux-2.6-kconfig/drivers/char/Kconfig	2006-05-15 13:21:15.000000000 +0200
> @@ -761,7 +763,7 @@ config SGI_IP27_RTC
>  
>  config GEN_RTC
>  	tristate "Generic /dev/rtc emulation"
> -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you

Which driver do you use for /dev/rtc? I couldn't find it at first sight.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
