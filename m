Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 0/2] fix recent nds32 build breakage
Date: Mon, 23 Dec 2019 13:00:02 +0200
Message-ID: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191223110002.ou-1DeHw-ubj-uQTOKog4dd_W1JYwEPOgRZ1Xz1WQOI@z>

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The kbuild robot reported build breakage of nds32 architecture [1] that
happens with CONFIG_CPU_CACHE_ALIASING=n and CONFIG_HUGHMEM=y.

There are two issues: one with a missing macro during conversion of page
folding and another one is a conflict between cacheflush.h definitions in
arch/nds32 and asm-generic.

[1] https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/

Mike Rapoport (2):
  asm-generic/nds32: don't redefine cacheflush primitives
  nds32: fix build failure caused by page table folding updates

 arch/nds32/include/asm/cacheflush.h | 11 ++++++----
 arch/nds32/include/asm/pgtable.h    |  2 +-
 include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.24.0
