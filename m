From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: about __BITS_PER_LONG
Date: Mon, 11 Apr 2011 17:24:57 +0200
Message-ID: <201104111724.57607.arnd@arndb.de>
References: <003f01cbf81a$f48cfdf0$dda6f9d0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53006 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab1DKPZJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2011 11:25:09 -0400
In-Reply-To: <003f01cbf81a$f48cfdf0$dda6f9d0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 11 April 2011, Guan Xuetao wrote:
> --- a/include/asm-generic/bitsperlong.h
> +++ b/include/asm-generic/bitsperlong.h
> @@ -9,7 +9,11 @@
>   * to decide it, but rather check a compiler provided macro.
>   */
>  #ifndef __BITS_PER_LONG
> -#define __BITS_PER_LONG 32
> +#   ifdef CONFIG_64BIT
> +#      define __BITS_PER_LONG 64
> +#   else
> +#      define __BITS_PER_LONG 32
> +#   endif /* CONFIG_64BIT */
>  #endif
>  

Unfortunately, this does not work, because the __BITS_PER_LONG definition is meant
for user space. You have to make this depend on a preprocessor macro that
is provided by the compiler based on the command line switches (e.g. -m64) that
a use could pass to the compiler.

In user space, the CONFIG_* symbols are meaningless.

	Arnd
