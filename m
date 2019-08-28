Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38393 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1VNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 17:13:49 -0400
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
References: <20190828210934.17711-1-efremov@linux.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <4ad61875-f694-58a6-f5d8-fca52c093c1d@linux.com>
Date: Thu, 29 Aug 2019 00:13:45 +0300
MIME-Version: 1.0
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190828211345.aLstD5tSntnVWNrX-x67gv4piJHE2JNuoJuWGLL4sF0@z>

Maybe it will be better to move this define out of ifdef, i.e.:

#ifdef CONFIG_BUG
...
-#define BUG_ON()...
...
#else
...
-#define BUG_ON()...
...
#endif

+#define BUG_ON()...

I can prepare a patch if you think it worth it.

Thanks,
Denis

On 29.08.2019 00:09, Denis Efremov wrote:
> Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> the define consistent with BUG_ON(x) in CONFIG_BUG.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>
> ---
>  include/asm-generic/bug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index aa6c093d9ce9..7357a3c942a0 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -185,7 +185,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  #endif
>  
>  #ifndef HAVE_ARCH_BUG_ON
> -#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
> +#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
>  #endif
>  
>  #ifndef HAVE_ARCH_WARN_ON
> 
