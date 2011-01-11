From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic headers: add arch-specific __strnlen_user calling in uaccess.h
Date: Tue, 11 Jan 2011 16:49:14 +0100
Message-ID: <201101111649.14711.arnd@arndb.de>
References: <008801cbb166$96cd0430$c4670c90$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <008801cbb166$96cd0430$c4670c90$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 11 January 2011, Guan Xuetao wrote:
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index b218b85..ac68c99 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -288,14 +288,16 @@ strncpy_from_user(char *dst, const char __user *src, long count)
>   *
>   * Return 0 on exception, a value greater than N if too long
>   */
> -#ifndef strnlen_user
> +#ifndef __strnlen_user
> +#define __strnlen_user strnlen
> +#endif
> +
>  static inline long strnlen_user(const char __user *src, long n)
>  {
>         if (!access_ok(VERIFY_READ, src, 1))
>                 return 0;
> -       return strlen((void * __force)src) + 1;
> +       return __strnlen_user(src, n);
>  }
> -#endif
>  
>  static inline long strlen_user(const char __user *src)

Yes, looks good. I believe no architecture currently uses the generic
uaccess.h file directly, so it's not surprising that you find problems
like this in it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
