From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Wed, 4 Apr 2018 17:55:37 +0200
Message-ID: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4> <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Mark Rutland <mark.rutland@arm.com>, Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
