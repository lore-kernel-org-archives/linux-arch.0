Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be ([80.88.33.193]:53199 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261763AbUEWJwV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 23 May 2004 05:52:21 -0400
Date: Sun, 23 May 2004 11:37:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: =?iso-8859-1?Q?Re:_[PATCH]_fixing_sendfile_on_64bit_architectures?=
In-Reply-To: <16556.19979.951743.994128@napali.hpl.hp.com>
Message-ID: <Pine.GSO.4.58.0405231135170.2027@waterleaf.sonytel.be>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
 <16556.19979.951743.994128@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: davidm@hpl.hp.com
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>, =?iso-8859-1?Q?Andi_Kleen?= <ak@suse.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 19 May 2004, David Mosberger wrote:
> >>>>> On Wed, 19 May 2004 21:26:01 +0200, Arnd Bergmann <arnd@arndb.de> said:
>
>   >> #ifdef SYS_NEED_OLD_STAT
>
>   >> instead of:
>
>   >> #if !defined(__alpha__) && !defined(__sparc__) &&
>   >> !defined(__ia64__) \ && !defined(CONFIG_ARCH_S390) &&
>   >> !defined(__hppa__) \ && !defined(__arm__) &&
>   >> !defined(CONFIG_V850) && !defined(__powerpc64__) \ &&
>   >> !defined(__mips__)
>
>   Arnd> Seconded. While it may not be that drastic in case of
>   Arnd> sys_sendfile, such constructions are always ugly and I suspect
>   Arnd> many of them would turn out to be incorrect after closer
>   Arnd> inspection.
>
> How about the attached?  I decided to use __ARCH_OMIT_foo instead
> of SYS_NEED_foo since that keeps the extra code in those platforms
> that want to drop the code.

Are you sure this logic is correct for obsolete features you want to keep for
backwards compatibility reasons on old^H^H^Hlong-existing architectures?

To me it sounds more logical if a new architecture would not get e.g.
sys_oldumount() by default.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
