From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
Date: Thu, 10 May 2018 09:45:56 +0200
Message-ID: <CAMuHMdUJTKqqWzFi594_y_F1HdONr3+FOSTzg-n0ogoroFUqpA@mail.gmail.com>
References: <20180510014447.15989-1-mcgrof@kernel.org> <20180510014447.15989-3-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510014447.15989-3-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Luis,

On Thu, May 10, 2018 at 3:44 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
> and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for years.
> Move this fallback to asm-generic.
>
> Architectures which do not define PAGE_KERNEL_EXEC yet:
>
>   o alpha
>   o mips
>   o openrisc
>   o sparc64

The above list seems to be far from complete?

> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
