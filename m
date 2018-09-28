Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39725 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbeI1NxW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 09:53:22 -0400
MIME-Version: 1.0
References: <20180928071414.30703-1-brgl@bgdev.pl> <20180928071414.30703-4-brgl@bgdev.pl>
In-Reply-To: <20180928071414.30703-4-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Sep 2018 09:30:45 +0200
Message-ID: <CAMuHMdVF9zD+KZ8E1-BCrn4W2QngABHqnCajOhk3Y=xpq4R=Cg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] devres: provide devm_kstrdup_const()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Message-ID: <20180928073045.xOhKKF0ARhP1IWlq6gn2JPNSmV8fq5cwXtfG-OEzrAc@z>

On Fri, Sep 28, 2018 at 9:14 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Provide a resource managed version of kstrdup_const(). This variant
> internally calls devm_kstrdup() on pointers that are outside of
> .rodata section and returns the string as is otherwise.
>
> Make devm_kfree() check if the passed pointer doesn't point to .rodata
> and if so - don't actually destroy the resource.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
