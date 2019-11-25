Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37208 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:02:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so1027901wmf.2
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
In-Reply-To: <3ed3c306fc51b0073fcf3a222f7314fcaf50ccf4.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:02:04 +0100
Message-ID: <CAFLxGvzXv7pHaY8i_RBs2BL5qHLMQJO97MWGF5cnh34kmeGZJg@mail.gmail.com>
Subject: Re: [RFC v2 01/37] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, Linux-Arch <linux-arch@vger.kernel.org>, Akira Moroo <retrage01@gmail.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> are not compiled due to type conflict of atomic64_t defined in
> linux/type.h.
>
> This commit fixes the issue and allow using generic atomic64 ops.

Hmm, why is this specific to LKL?
This need a review from core developers.

> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  include/asm-generic/atomic64.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 370f01d4450f..9b15847baae5 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -9,9 +9,11 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>  #include <linux/types.h>
>
> +#ifndef CONFIG_64BIT
>  typedef struct {
>         s64 counter;
>  } atomic64_t;
> +#endif
>
>  #define ATOMIC64_INIT(i)       { (i) }
>
> --
> 2.20.1 (Apple Git-117)
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard
