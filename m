From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 0/2] mm: PAGE_KERNEL_* fallbacks
Date: Wed,  9 May 2018 18:44:45 -0700
Message-ID: <20180510014447.15989-1-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, willy@infradead.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

While dusting out the firmware loader closet I spotted a PAGE_KERNEL_*
fallback hack. This hurts my eyes, and it should also be blinding
others. Turns out we have other PAGE_KERNEL_* fallback hacks in
other places.

This moves them to asm-generic, and keeps track of architectures which
need some love or review. At least 0-day was happy with the changes.

Matthew Wilcox did put together a PAGE_KERNEL_RO patch for ia64, that
needs review and testing, and if it goes well it should be merged.

Luis R. Rodriguez (2):
  mm: provide a fallback for PAGE_KERNEL_RO for architectures
  mm: provide a fallback for PAGE_KERNEL_EXEC for architectures

 drivers/base/firmware_loader/fallback.c |  5 ----
 include/asm-generic/pgtable.h           | 36 +++++++++++++++++++++++++
 mm/nommu.c                              |  4 ---
 mm/vmalloc.c                            |  4 ---
 4 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.17.0
