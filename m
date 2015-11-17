Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:24289
	"EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbbKQARn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Nov 2015 19:17:43 -0500
Subject: Re: [PATCH 0/4] m68k/mm: Add missing initialization of max_pfn and
 {min,max}_low_pfn
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
From: Greg Ungerer <gerg@uclinux.org>
Message-ID: <564A7224.2030105@uclinux.org>
Date: Tue, 17 Nov 2015 10:17:40 +1000
MIME-Version: 1.0
In-Reply-To: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151117001740.S9Ox_33OL8em5dVvQzS8XTkRD-MJ6STjg2HIZ-y-pkY@z>

Hi Geert,

On 15/11/15 21:04, Geert Uytterhoeven wrote:
> This patch series adds missing initialization of max_pfn, min_low_pfn,
> and max_low_pfn on various m68k platforms.
> 
> This was exposed by failing selftests/vm/mlock2-tests.
> 
> Note that several other architectures lack a proper initialization of
> max_pfn. On some of them it's completely missing, on others max_pfn is a
> local variable, hence it hides the global max_pfn, which is thus not
> initialized neither.
> 
> On platforms with MMU, this can easily be verified by reading the
> following virtual files (CONFIG_PROC_PAGE_MONITOR=y):
> 
>     /proc/kpagecount
>     /proc/kpageflags
>     /proc/kpagecgroup (CONFIG_MEMCG=y)
> 
> If max_pfn is not initialized, all three virtual files are empty.
> 
> Besides the above, max_pfn is also used to calculate DMA masks for block
> devices. An uninitialized (zero) value means all RAM is suitable for
> DMA.

All looks good to me. Tested-by acks set separately. But otherwise

Acked-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg


> Absence of initialization of min_low_pfn and max_low_pfn is more subtle.
> (are there any bad side-effects?).
> 
> Geert Uytterhoeven (4):
>   m68k/mm: motorola - Add missing initialization of max_pfn
>   m68k/mm: m54xx - Add missing initialization of max_pfn
>   m68k/mm: sun3 - Add missing initialization of max_pfn and
>     {min,max}_low_pfn
>   m68knommu: Add missing initialization of max_pfn and {min,max}_low_pfn
> 
>  arch/m68k/coldfire/m54xx.c  | 2 +-
>  arch/m68k/kernel/setup_no.c | 9 ++++++---
>  arch/m68k/mm/motorola.c     | 2 +-
>  arch/m68k/sun3/config.c     | 4 ++--
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 

