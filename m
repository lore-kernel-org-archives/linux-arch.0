From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for architectures
Date: Wed, 2 May 2018 12:08:57 +0200
Message-ID: <CAMuHMdUpc6=j62E7Xrcid6tKU5FRUZsiSVK7J=KD09epQ=9xfA@mail.gmail.com>
References: <20180428001526.22475-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180428001526.22475-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

Hi Luis,

On Sat, Apr 28, 2018 at 2:15 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Some architectures do not define PAGE_KERNEL_RO, best we can do
> for them is to provide a fallback onto PAGE_KERNEL. Remove the
> hack from the firmware loader and move it onto the asm-generic
> header, and document while at it the affected architectures
> which do not have a PAGE_KERNEL_RO:
>
>   o alpha
>   o ia64
>   o m68k
>   o mips
>   o sparc64
>   o sparc
>
> Blessed-by: 0-day
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

I believe the "best we can do" is to add the missing definitions for the
architectures where the hardware does support it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
