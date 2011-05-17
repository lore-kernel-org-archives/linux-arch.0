From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix generic get_user and put_user
Date: Tue, 17 May 2011 22:26:53 +0200
Message-ID: <201105172226.54517.arnd@arndb.de>
References: <1305657349-2783-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1EQU05 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2011 16:26:57 -0400
In-Reply-To: <1305657349-2783-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Tuesday 17 May 2011, Mark Salter wrote:
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 1d0fdf8..5079335 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -162,9 +162,10 @@ static inline __must_check long __copy_to_user(void __user *to,
>  
>  #define put_user(x, ptr)                                       \
>  ({                                                             \
> +       __typeof__(*(ptr)) *__pu_ptr = (ptr);                   \
>         might_sleep();                                          \
> -       access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)) ?            \
> -               __put_user(x, ptr) :                            \
> +       access_ok(VERIFY_WRITE, __pu_ptr, sizeof(*ptr)) ?       \
> +               __put_user(x, __pu_ptr) :                       \
>                 -EFAULT;                                        \
>  })
>  
> @@ -218,9 +219,10 @@ extern int __put_user_bad(void) __attribute__((noreturn));
>  
>  #define get_user(x, ptr)                                       \
>  ({                                                             \
> +       __typeof__(*(ptr)) *__gu_ptr = (ptr);                   \
>         might_sleep();                                          \
> -       access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?             \
> -               __get_user(x, ptr) :                            \
> +       access_ok(VERIFY_READ, __gu_ptr, sizeof(*ptr)) ?        \
> +               __get_user(x, __gu_ptr) :                       \
>                 -EFAULT;                                        \
>  })
>  

IIRC, this doesn't work for get_user if the pointer is marked const.
Do you see a real problem with the current definitions, or are you
just trying to improve them genrally?

	Arnd
