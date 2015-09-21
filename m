From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 0/2] mm: soft-dirty bits for s390
Date: Mon, 21 Sep 2015 17:22:18 +0200
Message-ID: <1442848940-22108-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Cyrill Gorcunov <gorcunov@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Greetings,

this patch set of two adds memory change tracking alias soft-dirty
feature to the s390 architecture.

The first patch is a cleanup of the existing x86 support, it adds two
arch specific functions pte_clear_soft_dirty and pmd_clear_soft_dirty
to complement the other xxx_soft_dirty functions. This removes the
use of a x86 specific function in fs/proc/tasm_mmu.c.

The second patch is the s390 arch support.

Tested on x86 and s390, seems to work as intended for both platforms.
If the first patch is acceptable I can queue the set on the linux-s390
tree for the 4.4 merge window in a couple of weeks.

Martin Schwidefsky (2):
  mm: add architecture primitives for software dirty bit clearing
  s390/mm: implement soft-dirty bits for user memory change tracking

 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/pgtable.h | 59 ++++++++++++++++++++++++++++++++++++++---
 arch/s390/mm/hugetlbpage.c      |  2 ++
 arch/x86/include/asm/pgtable.h  | 10 +++++++
 fs/proc/task_mmu.c              |  4 +--
 include/asm-generic/pgtable.h   | 10 +++++++
 6 files changed, 80 insertions(+), 6 deletions(-)

-- 
1.9.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
