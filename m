From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RESEND 2/4] uaccess: Selectively open read or write user
 access
Date: Thu, 2 Apr 2020 00:51:26 -0700
Message-ID: <202004020047.401CEBED2@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36668 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbgDBHv3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 03:51:29 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so1201548pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 00:51:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:17AM +0000, Christophe Leroy wrote:
> [...]
> diff --git a/kernel/compat.c b/kernel/compat.c
> index 843dd17e6078..705ca7e418c6 100644
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
> @@ -199,7 +199,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_write_access_begin(umask, bitmap_size / 8))

This looks mismatched: should be user_read_access_begin()?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -211,11 +211,11 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_get_user(*mask, umask++, Efault);
> -	user_access_end();
> +	user_read_access_end();
>  	return 0;
>  
>  Efault:
> -	user_access_end();
> +	user_read_access_end();
>  	return -EFAULT;
>  }

(These correctly end read access.)

>  
> @@ -228,7 +228,7 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_read_access_begin(umask, bitmap_size / 8))

And ..._write_... here?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -239,10 +239,10 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
> -	user_access_end();
> +	user_write_access_end();
>  	return 0;
>  Efault:
> -	user_access_end();
> +	user_write_access_end();
>  	return -EFAULT;
>  }

(These correctly end write access.)


All the others look correct. With the above fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
