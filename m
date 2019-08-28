From: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Date: Thu, 29 Aug 2019 00:13:45 +0300
Message-ID: <4ad61875-f694-58a6-f5d8-fca52c093c1d@linux.com>
References: <20190828210934.17711-1-efremov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
