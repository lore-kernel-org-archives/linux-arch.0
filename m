From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/2] Enable s390/arc/sparc to use generic thp deposit/withdraw
Date: Thu, 11 Feb 2016 14:58:25 +0530
Message-ID: <1455182907-15445-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Alex Thorlton <athorlton@sgi.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This came out my debugging THP on ARC. The generic deposit/withdraw routines
can be easily adapted to work with pgtable_t != struct page *.

Build/Run tested on ARC only.

Thx,
-Vineet

Vineet Gupta (2):
  mm,thp: refactor generic deposit/withdraw routines for wider usage
  ARC: mm: THP: use generic THP deposit/withdraw

 arch/arc/include/asm/hugepage.h |  8 --------
 arch/arc/mm/tlb.c               | 37 -------------------------------------
 mm/pgtable-generic.c            | 27 +++++++++++++++++----------
 3 files changed, 17 insertions(+), 55 deletions(-)

-- 
2.5.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
