Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51096 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758193AbbKSL00 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 06:26:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
Date: Thu, 19 Nov 2015 12:25:45 +0100
Message-ID: <5663971.11WtULN11Y@wuerfel>
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: Chen Gang <xili_gchen_5257@hotmail.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "jonas@southpole.se" <jonas@southpole.se>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Message-ID: <20151119112545.NkiQCK6MLGYOBWH-ZZyg3lIaPSCBfHaDgOZo7uJq8pE@z>

On Thursday 19 November 2015 03:40:25 Chen Gang wrote:
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index 37d1fe2..67cfb7d 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -24,9 +24,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#define get_user_page(vaddr)           __get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)     free_page(addr)
> -
>  #define clear_page(page)       memset((page), 0, PAGE_SIZE)
>  #define copy_page(to,from)     memcpy((to), (from), PAGE_SIZE)
>  
> 

Looks good. I can take the asm-generic portion when you split it up, and
I can also help you merge the remaining patches in case some of
the arch maintainers fail to pick them up. I think all five of them
are actively maintained though, so the patches should just go through
the respective architecture trees.

	Arnd
