Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:59643 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbaLYKIO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Dec 2014 05:08:14 -0500
MIME-Version: 1.0
In-Reply-To: <1419423766-114457-25-git-send-email-kirill.shutemov@linux.intel.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
	<1419423766-114457-25-git-send-email-kirill.shutemov@linux.intel.com>
Date: Thu, 25 Dec 2014 11:08:11 +0100
Message-ID: <CAMuHMdWKNEeb3uOJ+gct06mbuD4RqP7F32FhMtax-tG7d_Yj1g@mail.gmail.com>
Subject: Re: [PATCH 24/38] mips: drop _PAGE_FILE and pte_file()-related helpers
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Dave Jones <davej@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20141225100811.6fjiK9IpD01FHN_8k7mGSeljBMXCxrPvHzafYBa9z1I@z>

On Wed, Dec 24, 2014 at 1:22 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/m68k/include/asm/mcf_pgtable.h  |  6 ++----

This contains a change to an m68k header file.
The same file was modified in the m68k part of the series, but this change was
not included?

> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -385,15 +385,13 @@ static inline void cache_page(void *vaddr)
>         *ptep = pte_mkcache(*ptep);
>  }
>
> -#define PTE_FILE_SHIFT         11
> -
>  /*
>   * Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e))
>   */
>  #define __swp_type(x)          ((x).val & 0xFF)
> -#define __swp_offset(x)                ((x).val >> PTE_FILE_SHIFT)
> +#define __swp_offset(x)                ((x).val >> 11)
>  #define __swp_entry(typ, off)  ((swp_entry_t) { (typ) | \
> -                                       (off << PTE_FILE_SHIFT) })
> +                                       (off << 11) })
>  #define __pte_to_swp_entry(pte)        ((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)  (__pte((x).val))

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
