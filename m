Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35901 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbeDDPzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Apr 2018 11:55:39 -0400
MIME-Version: 1.0
In-Reply-To: <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4> <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 17:55:37 +0200
Message-ID: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Mark Rutland <mark.rutland@arm.com>, Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180404155537.mpGH-540zKAJOJTe4lbDeM3rRgQXrsSdLz3-iLS59hc@z>

On Wed, Apr 4, 2018 at 5:52 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/3/2018 6:29 PM, Palmer Dabbelt wrote:
>>
>
> Are we looking for something like this?

Yes, exactly, plus the same for write and in/out of course.

> diff --git a/inc
>  #ifndef readb
>  #define readb readb
> -static inline u8 readb(const volatile void __iomem *addr)
> -{
> -       return __raw_readb(addr);
> -}
> +#define readb(c)                               \
> +       ({ u8  __v;                             \
> +        __io_br();                             \
> +        __v = __raw_readb(c);                  \
> +        __io_ar();                             \
> +        __v; })
>  #endif

I would prefer leaving these as inline functions, but that's only
a cosmetic difference.

       Arnd
