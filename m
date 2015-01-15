From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/8] current ACCESS_ONCE patch queue
Date: Thu, 15 Jan 2015 09:58:26 +0100
Message-ID: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Folks,

fyi, this is my current patch queue for the next merge window. It
does contain a patch that will disallow ACCESS_ONCE on non-scalar
types.

The tree is part of linux-next and can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next


Christian Borntraeger (7):
  ppc/kvm: Replace ACCESS_ONCE with READ_ONCE
  ppc/hugetlbfs: Replace ACCESS_ONCE with READ_ONCE
  x86/xen/p2m: Replace ACCESS_ONCE with READ_ONCE
  x86/spinlock: Leftover conversion ACCESS_ONCE->READ_ONCE
  mm/gup: Replace ACCESS_ONCE with READ_ONCE
  kernel: tighten rules for ACCESS ONCE
  kernel: Fix sparse warning for ACCESS_ONCE

Guenter Roeck (1):
  next: sh: Fix compile error

 arch/powerpc/kvm/book3s_hv_rm_xics.c |  8 ++++----
 arch/powerpc/kvm/book3s_xics.c       | 16 ++++++++--------
 arch/powerpc/mm/hugetlbpage.c        |  4 ++--
 arch/sh/mm/gup.c                     |  2 +-
 arch/x86/include/asm/spinlock.h      |  2 +-
 arch/x86/xen/p2m.c                   |  2 +-
 include/linux/compiler.h             | 21 ++++++++++++++++-----
 mm/gup.c                             |  2 +-
 8 files changed, 34 insertions(+), 23 deletions(-)

-- 
1.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
