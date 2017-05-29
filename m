From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Mon, 29 May 2017 20:33:55 +1000
Message-ID: <20170529203355.4ebd1062@canb.auug.org.au>
References: <20170529081103.29999-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbdE2Kd6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 May 2017 06:33:58 -0400
In-Reply-To: <20170529081103.29999-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Hi Nick,

On Mon, 29 May 2017 18:11:03 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6c00e5b00f8b..28e64cb65dd5 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -511,10 +511,23 @@ config CC_STACKPROTECTOR_STRONG
>  endchoice
>  
>  config THIN_ARCHIVES
> -	bool
> +	bool "Build the kernel using thin archives"
> +	default n

Of course, this will be enabled by allmodconfig, etc builds ...

-- 
Cheers,
Stephen Rothwell
