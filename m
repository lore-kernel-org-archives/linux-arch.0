From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] generic asm: mman cleanup
Date: Fri, 8 Feb 2019 01:02:51 -0500
Message-ID: <20190124142448.23243-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
architectures, it probably makes sense to de-duplicate these
and put them into a common header.

Please review and consider merging though the generic tree.

Build tested on x86 only. Has been in linux-next for a while now.

Michael S. Tsirkin (3):
  x86/mpx: tweak header name
  drm: tweak header name
  arch: move common mmap flags to linux/mman.h

 arch/alpha/include/uapi/asm/mman.h     | 4 +---
 arch/mips/include/uapi/asm/mman.h      | 4 +---
 arch/parisc/include/uapi/asm/mman.h    | 4 +---
 arch/x86/mm/mpx.c                      | 2 +-
 arch/xtensa/include/uapi/asm/mman.h    | 4 +---
 include/drm/drmP.h                     | 3 +--
 include/uapi/asm-generic/mman-common.h | 4 +---
 include/uapi/linux/mman.h              | 4 ++++
 8 files changed, 11 insertions(+), 18 deletions(-)

-- 
MST
