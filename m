Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:6311 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751270AbWHYIL5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 04:11:57 -0400
Date: Fri, 25 Aug 2006 10:11:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0608251006390.3267@pademelon.sonytel.be>
References: <20060824234445.6B519D52@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 24 Aug 2006, Dave Hansen wrote:
> +config PAGE_SHIFT
> +	int
> +	default "13" if PAGE_SIZE_8KB || ALPHA || SUN3 || SUN4
> +	default "14" if PAGE_SIZE_16KB || FRV || CRIS
> +	default "16" if PAGE_SIZE_64KB || FRV || CRIS

Why do we have `|| FRV || CRIS' twice? Won't it always select 14 for FRV and
CRIS? Or am I missing some important Kconfig rule?

> +	default "19" if PAGE_SIZE_512KB
> +	default "22" if PAGE_SIZE_4MB
> +	default "12" # arm || h8300 || i386 | m68knommu |ppc
> +		     # s390 || um || v850 || xtensa
> +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
