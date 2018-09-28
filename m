From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/4] mm: move is_kernel_rodata() to asm-generic/sections.h
Date: Fri, 28 Sep 2018 09:29:55 +0200
Message-ID: <CAMuHMdXC+07PH+dhq-knno1rx+1vXm4BiFX9WPmfcTt4WNGNNA@mail.gmail.com>
References: <20180928071414.30703-1-brgl@bgdev.pl> <20180928071414.30703-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928071414.30703-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 9:14 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().
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
