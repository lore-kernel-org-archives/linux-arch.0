From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/4] mm: mmu_gather changes to support explicit paging
Date: Thu, 26 Jul 2018 00:06:37 +1000
Message-ID: <20180725140641.30372-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>
List-Id: linux-arch.vger.kernel.org

The first 3 patches in this series are some generic mm changes I
would like to make, including a possible fix which may(?) be needed
for ARM64. Other than the bugfix, these first 3 patches should not
change anything so hopefully they aren't too controversial.

The powerpc patch is also there for reference. 

Thanks,
Nick

Nicholas Piggin (4):
  mm: move tlb_table_flush to tlb_flush_mmu_free
  mm: mmu_notifier fix for tlb_end_vma
  mm: allow arch to have tlb_flush caled on an empty TLB range
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/include/asm/tlb.h | 34 +++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb-radix.c    | 10 ++++++++++
 include/asm-generic/tlb.h      | 35 ++++++++++++++++++++++++++++++----
 mm/memory.c                    | 14 ++------------
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.17.0
