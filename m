From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] huge vmalloc mappings
Date: Mon, 13 Apr 2020 22:52:59 +1000
Message-ID: <20200413125303.423864-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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

-- 
2.23.0
