Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGSI7t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 04:59:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so28259592wmj.5
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2019 01:59:48 -0700 (PDT)
Date: Fri, 19 Jul 2019 10:59:45 +0200
From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <20190719085944.n4ypavxdlf6go4tl@brauner.io>
References: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190719085945.sT7UM3XKgsrNQvEjIzHny_ctJ_F_Q6FuYd6MvzqBI7o@z>

On Thu, Jul 18, 2019 at 09:20:01PM -0700, Paul Walmsley wrote:
> 
> Enable the sys_clone3 syscall for RV64.  We simply include the generic
> version.
> 
> Tested by running the program from
> 
>    https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> 
> and verifying that it completes successfully.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Christian Brauner <christian@brauner.io>

Thank you!

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  arch/riscv/include/uapi/asm/unistd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> index 0e2eeeb1fd27..13ce76cc5aff 100644
> --- a/arch/riscv/include/uapi/asm/unistd.h
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -18,6 +18,7 @@
>  #ifdef __LP64__
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SET_GET_RLIMIT
> +#define __ARCH_WANT_SYS_CLONE3
>  #endif /* __LP64__ */
>  
>  #include <asm-generic/unistd.h>
> -- 
> 2.22.0
> 
