From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
Date: Tue, 14 Jul 2020 08:27:14 -0700
Message-ID: <CAHk-=wgpYFEPMfYmNR-9SuPaeC432sC7nmZrismRHQEiR2GM4g@mail.gmail.com>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNP1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 11:27:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28858C061755
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so23258060ljn.12
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:34 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a5sm5368081lfh.15.2020.07.14.08.27.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:27:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q7so23329988ljm.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 08:27:30 -0700 (PDT)
In-Reply-To: <20200714105505.935079-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Ack, just with a note:

On Tue, Jul 14, 2020 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -33,7 +33,7 @@ static inline void set_fs(mm_segment_t fs)
>         set_thread_flag(TIF_FSCHECK);
>  }
>
> -#define segment_eq(a, b)       ((a).seg == (b).seg)
> +#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
>  #define user_addr_max() (current->thread.addr_limit.seg)

This "uaccess_kernel()" interface is a better model anyway, because at
least on x86 (and from a quick glance at others), we might avoid the
exact equality comparison, and instead do simpler/better things.

On x86-64, for example, checking whether the limit has the high bit
set is not only more flexible and correct, it's much cheaper too.

Of course, trying to get rid of all this means that it doesn't matter
so much, but it would probably have been good to do this part years
ago regardless.

                  Linus
