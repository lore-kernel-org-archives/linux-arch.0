Return-Path: <SRS0=XT2V=55=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] huge vmalloc mappings
Date: Mon, 13 Apr 2020 22:52:59 +1000
Message-ID: <20200413125303.423864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200413125259.XQKjC4w-_vtk1oBMIvppMUiIY1VWG0OdJLRiLKoLVN8@z>

We can get a significant win with larger mappings for some of the big
global hashes.

Since RFC, relevant architectures have added p?d_leaf accessors so no
real arch changes required, and I changed it not to allocate huge
mappings for modules and a bunch of other fixes.

Nicholas Piggin (4):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: Move ioremap page table mapping function to mm/
  mm: HUGE_VMAP arch query functions cleanup
  mm/vmalloc: Hugepage vmalloc mappings

 arch/arm64/mm/mmu.c                      |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c |   6 +-
 arch/x86/mm/ioremap.c                    |   6 +-
 include/linux/io.h                       |   3 -
 include/linux/vmalloc.h                  |  15 +
 lib/ioremap.c                            | 203 +----------
 mm/vmalloc.c                             | 413 +++++++++++++++++++----
 7 files changed, 380 insertions(+), 274 deletions(-)

--=20
2.23.0
