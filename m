Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:52305 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831AbbB1A7b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2015 19:59:31 -0500
Message-ID: <1425085168.24292.35.camel@x220>
Subject: Re: fs: dax: do not build on ARC or SH
From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 28 Feb 2015 01:59:28 +0100
In-Reply-To: <5778538.KJ98x3yxkB@wuerfel>
References: <5778538.KJ98x3yxkB@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150228005928.rtxokf3gKl64reg-gQgiKEu-r0_scumt7hWFXjUonOI@z>

On Mon, 2015-02-23 at 12:29 +0100, Arnd Bergmann wrote:
> The DAX implementation relies on the architecture to provide a working
> copy_user_page() function, as reported by Michael Ellerman's kisskb
> build bot:
> 
> fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> 
> We already have a list of architectures that are known to be incompatible,
> but the list is missing ARC and SH at the moment. Further, blackfin and
> c6x also lack support for this function, but are already excluded because
> they do not support MMU-based kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> diff --git a/fs/Kconfig b/fs/Kconfig
> index ec35851e5b71..a24d496787d6 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -36,7 +36,7 @@ source "fs/nilfs2/Kconfig"
>  config FS_DAX
>  	bool "Direct Access (DAX) support"
>  	depends on MMU
> -	depends on !(ARM || MIPS || SPARC)
> +	depends on !(ARC || ARM || MIPS || SH || SPARC)

Did you mean
                                             SUPERH?

>  	help
>  	  Direct Access (DAX) can be used on memory-backed block devices.
>  	  If the block device supports DAX and the filesystem supports DAX,
> 

Thanks,


Paul Bolle

