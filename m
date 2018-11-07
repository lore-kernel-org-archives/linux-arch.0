Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:48316 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbeKHDK2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Nov 2018 22:10:28 -0500
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed,  7 Nov 2018 10:38:57 -0700
Message-ID: <20181107173859.24096-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 0/2] Introduce common code for risc-v sparsemem support
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Logan Gunthorpe <logang@deltatee.com>
Message-ID: <20181107173857.MtD1swIlKQCGb_X4glCfCfGwqxF11o0zb5Xt1tel0-4@z>

These are the first two common patches in my series to introduce
sparsemem support to RISC-V. The full series was posted last cycle
here [1] and the latest version can be found here [2].

As recommended by Palmer, I'd like to get the changes to common code
merged and then I will pursue the cleanups in the individual arches (arm,
arm64, and sh) as well as adding the new feature to riscv.

I would suggest we merge these two patches through Andrew's mm tree.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/20181015175702.9036-1-logang@deltatee.com/T/#u
[2] https://github.com/sbates130272/linux-p2pmem.git riscv-sparsemem-v3

Logan Gunthorpe (2):
  mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
  mm/sparse: add common helper to mark all memblocks present

 arch/arm64/include/asm/memory.h |  9 ---------
 arch/arm64/mm/init.c            |  8 --------
 include/asm-generic/fixmap.h    |  1 +
 include/linux/mm_types.h        |  5 +++++
 include/linux/mmzone.h          |  6 ++++++
 mm/sparse.c                     | 11 +++++++++++
 6 files changed, 23 insertions(+), 17 deletions(-)

--
2.19.0
