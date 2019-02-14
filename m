From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem implementation
Date: Thu, 14 Feb 2019 09:03:01 +0100
Message-ID: <CAMuHMdX0oJeGO90E9O=vVoDjahS5M8Rku+JGD1Tt+t-oKHnPJQ@mail.gmail.com>
References: <20190213174621.29297-1-hch@lst.de> <20190213174621.29297-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213174621.29297-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux MM <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 14, 2019 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
> For most architectures free_initrd_mem just expands to the same
> free_reserved_area call.  Provide that as a generic implementation
> marked __weak.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/mm/init.c       | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
