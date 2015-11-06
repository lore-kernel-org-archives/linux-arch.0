From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic cleanups
Date: Fri, 06 Nov 2015 17:57:38 +0100
Message-ID: <33040668.avNmVjd66u@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-for-linus

for you to fetch changes up to 4008cb3ad223e39273b9cdfa578d04861b197c86:

  asm-generic: temporarily add back asm-generic/io-64-nonatomic*.h (2015-10-16 12:08:53 +0200)

----------------------------------------------------------------
asm-generic cleanups

The asm-generic changes for 4.4 are mostly a series from Christoph Hellwig
to clean up various abuses of headers in there. The patch to rename the
io-64-nonatomic-*.h headers caused some conflicts with new users, so I
added a workaround that we can remove in the next merge window.

The only other patch is a warning fix from Marek Vasut

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: temporarily add back asm-generic/io-64-nonatomic*.h

Christoph Hellwig (8):
      move io-64-nonatomic*.h out of asm-generic
      move count_zeroes.h out of asm-generic
      drbd: stop including <asm-generic/kmap_types.h>
      hifn_795x: stop including <asm-generic/kmap_types.h>
      mlx5: stop including <asm-generic/kmap_types.h>
      n_tracerouter: stop including <asm-generic/bug>
      n_tracesink: stop including <asm-generic/bug>
      gpio-mxc: stop including <asm-generic/bug>

Marek Vasut (1):
      asm-generic: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations

 drivers/acpi/nfit.c                                |  2 +-
 drivers/acpi/osl.c                                 |  2 +-
 drivers/block/drbd/drbd_bitmap.c                   |  2 +-
 drivers/block/nvme-core.c                          |  2 +-
 drivers/crypto/hifn_795x.c                         |  2 --
 drivers/edac/i3200_edac.c                          |  2 +-
 drivers/edac/ie31200_edac.c                        |  2 +-
 drivers/edac/x38_edac.c                            |  2 +-
 drivers/gpio/gpio-mxc.c                            |  2 +-
 drivers/i2c/busses/i2c-ismt.c                      |  2 +-
 drivers/infiniband/hw/mlx5/main.c                  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |  2 +-
 drivers/net/ethernet/intel/i40evf/i40e_osdep.h     |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |  2 +-
 drivers/net/ethernet/rocker/rocker.c               |  2 +-
 drivers/platform/x86/ibm_rtl.c                     |  2 +-
 drivers/platform/x86/intel_ips.c                   |  2 +-
 drivers/scsi/qla4xxx/ql4_nx.c                      |  2 +-
 drivers/tty/n_tracerouter.c                        |  2 +-
 drivers/tty/n_tracesink.c                          |  2 +-
 include/asm-generic/cmpxchg.h                      | 11 ++++---
 include/asm-generic/io-64-nonatomic-hi-lo.h        | 34 ++--------------------
 include/asm-generic/io-64-nonatomic-lo-hi.h        | 34 ++--------------------
 .../{asm-generic/bitops => linux}/count_zeros.h    |  6 ++--
 include/linux/io-64-nonatomic-hi-lo.h              | 32 ++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h              | 32 ++++++++++++++++++++
 lib/mpi/longlong.h                                 |  2 +-
 lib/mpi/mpicoder.c                                 |  2 +-
 30 files changed, 101 insertions(+), 96 deletions(-)
 rename include/{asm-generic/bitops => linux}/count_zeros.h (92%)
 create mode 100644 include/linux/io-64-nonatomic-hi-lo.h
 create mode 100644 include/linux/io-64-nonatomic-lo-hi.h
