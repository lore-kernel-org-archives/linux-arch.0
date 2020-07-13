From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/6] uaccess: remove segment_eq
Date: Mon, 13 Jul 2020 11:16:24 +0200
Message-ID: <CAMuHMdXQGj=ic_8U4GRmpPtECsC=2pVi-Mjrek9RoC-126yDRg@mail.gmail.com>
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39662 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 05:16:36 -0400
In-Reply-To: <20200710135706.537715-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv <linux-riscv@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 10, 2020 at 3:58 PM Christoph Hellwig <hch@lst.de> wrote:
> segment_eq is only used to implement uaccess_kernel.  Just open code
> uaccess_kernel in the arch uaccess headers and remove one layer of
> indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/segment.h       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
