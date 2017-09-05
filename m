Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38706 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdIEPLv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2017 11:11:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170905112727.13668-1-tklauser@distanz.ch>
References: <20170905112727.13668-1-tklauser@distanz.ch>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Sep 2017 17:11:50 +0200
Message-ID: <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary include of linux/vmalloc.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170905151150.4f0P4pRz-nTPccJCh4mvvhq3idAcrHrSr6rBMeXL0IU@z>

On Tue, Sep 5, 2017 at 1:27 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> Including linux/vmalloc.h in asm-generic/io.h isn't necessary since none
> of the definitions are used in the header itself. Remove the include in
> order to avoid potential header dependency problems if other headers
> rely on implict inclusion of linux/vmalloc.h which means that changes
> there could break unrelated parts.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  include/asm-generic/io.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index b4531e3b2120..d2d3bd163f5f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
>
>  #ifdef __KERNEL__
>
> -#include <linux/vmalloc.h>
>  #define __io_virt(x) ((void __force *)(x))
>
>  #ifndef CONFIG_GENERIC_IOMAP

This seems like a good idea in principle, but I think it needs to be tested
well before we apply it, to avoid breaking random drivers that forgot to
add their own includes of that header.

I've added your patch to my testing queue, but not to the asm-generic
tree now. We should see if it leads to any randconfig build regressions
on the architectures I normally test.

Did you run into a specific problem with the #include, or did it just occur
to you that it might help in general?

      Arnd
