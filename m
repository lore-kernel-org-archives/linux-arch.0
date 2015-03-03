From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH 1/4] mm: move memtest under /mm
Date: Mon, 02 Mar 2015 17:52:00 -0800
Message-ID: <54F513C0.4000706@infradead.org>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com> <1425308145-20769-2-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39632 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbbCCBw1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2015 20:52:27 -0500
In-Reply-To: <1425308145-20769-2-git-send-email-vladimir.murzin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org

On 03/02/15 06:55, Vladimir Murzin wrote:
> There is nothing platform dependent in the core memtest code, so other platform
> might benefit of this feature too.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/x86/Kconfig            |   11 ----
>  arch/x86/include/asm/e820.h |    8 ---
>  arch/x86/mm/Makefile        |    2 -
>  arch/x86/mm/memtest.c       |  118 -------------------------------------------
>  include/linux/memblock.h    |    8 +++
>  lib/Kconfig.debug           |   11 ++++
>  mm/Makefile                 |    1 +
>  mm/memtest.c                |  118 +++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 138 insertions(+), 139 deletions(-)
>  delete mode 100644 arch/x86/mm/memtest.c
>  create mode 100644 mm/memtest.c

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c5cefb3..8eb064fd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1732,6 +1732,17 @@ config TEST_UDELAY
>  
>  	  If unsure, say N.
>  
> +config MEMTEST
> +	bool "Memtest"
> +	---help---
> +	  This option adds a kernel parameter 'memtest', which allows memtest
> +	  to be set.
> +	        memtest=0, mean disabled; -- default
> +	        memtest=1, mean do 1 test pattern;
> +	        ...
> +	        memtest=4, mean do 4 test patterns.

This sort of implies a max of 4 test patterns, but it seems to be 17
if I counted correctly, so if someone wants to test all of the possible
'memtest' patterns, they would need to use 'memtest=17', is that correct?


> +	  If you are unsure how to answer this question, answer N.

Thanks,
-- 
~Randy
