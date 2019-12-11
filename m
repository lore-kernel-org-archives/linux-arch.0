Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44003 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfLKNTY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 08:19:24 -0500
MIME-Version: 1.0
References: <20191211120713.360281197@infradead.org> <20191211122955.769069740@infradead.org>
In-Reply-To: <20191211122955.769069740@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Dec 2019 14:19:11 +0100
Message-ID: <CAMuHMdUA-Bj+q4g2NimMv3nnu5v=X81BEkoSgUTOTLG+rsPK4g@mail.gmail.com>
Subject: Re: [PATCH 02/17] asm-gemeric/tlb: Remove stray function declarations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191211131911.rmRE2v2tfCbMO3STLB0QLK-ZEMlFLID0cG5no-5dvxM@z>

On Wed, Dec 11, 2019 at 1:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> We removed the actual functions a while ago.
>
> Fixes: 1808d65b55e4 ("asm-generic/tlb: Remove arch_tlb*_mmu()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
