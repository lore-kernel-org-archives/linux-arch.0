From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/4] m68k/mm: Add missing initialization of max_pfn and {min,max}_low_pfn
Date: Sun, 15 Nov 2015 12:04:11 +0100
Message-ID: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@uclinux.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

	Hi,

This patch series adds missing initialization of max_pfn, min_low_pfn,
and max_low_pfn on various m68k platforms.

This was exposed by failing selftests/vm/mlock2-tests.

Note that several other architectures lack a proper initialization of
max_pfn. On some of them it's completely missing, on others max_pfn is a
local variable, hence it hides the global max_pfn, which is thus not
initialized neither.

On platforms with MMU, this can easily be verified by reading the
following virtual files (CONFIG_PROC_PAGE_MONITOR=y):

    /proc/kpagecount
    /proc/kpageflags
    /proc/kpagecgroup (CONFIG_MEMCG=y)

If max_pfn is not initialized, all three virtual files are empty.

Besides the above, max_pfn is also used to calculate DMA masks for block
devices. An uninitialized (zero) value means all RAM is suitable for
DMA.

Absence of initialization of min_low_pfn and max_low_pfn is more subtle.
(are there any bad side-effects?).

Geert Uytterhoeven (4):
  m68k/mm: motorola - Add missing initialization of max_pfn
  m68k/mm: m54xx - Add missing initialization of max_pfn
  m68k/mm: sun3 - Add missing initialization of max_pfn and
    {min,max}_low_pfn
  m68knommu: Add missing initialization of max_pfn and {min,max}_low_pfn

 arch/m68k/coldfire/m54xx.c  | 2 +-
 arch/m68k/kernel/setup_no.c | 9 ++++++---
 arch/m68k/mm/motorola.c     | 2 +-
 arch/m68k/sun3/config.c     | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
