Return-Path: <SRS0=Q31O=AZ=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNK5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 06:57:25 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: clean up address limit helpers v2
Date: Tue, 14 Jul 2020 12:54:59 +0200
Message-ID: <20200714105505.935079-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200714105459.g1L8ML9Upen5wniB1ZsFKUag9ufrCC1TzUMUs0DMEH4@z>

Hi all,

in preparation for eventually phasing out direct use of set_fs(), this
series removes the segment_eq() arch helper that is only used to
implement or duplicate the uaccess_kernel() API, and then adds
descriptive helpers to force the kernel address limit.


Changes since v1:
 - drop to incorrect hunks
 - fix a commit log typo

Diffstat:
 arch/alpha/include/asm/uaccess.h      |    2 +-
 arch/arc/include/asm/segment.h        |    3 +--
 arch/arm/include/asm/uaccess.h        |    4 ++--
 arch/arm64/include/asm/uaccess.h      |    2 +-
 arch/arm64/kernel/sdei.c              |    2 +-
 arch/csky/include/asm/segment.h       |    2 +-
 arch/h8300/include/asm/segment.h      |    2 +-
 arch/ia64/include/asm/uaccess.h       |    2 +-
 arch/m68k/include/asm/segment.h       |    2 +-
 arch/m68k/include/asm/tlbflush.h      |    6 +++---
 arch/microblaze/include/asm/uaccess.h |    2 +-
 arch/mips/include/asm/uaccess.h       |    2 +-
 arch/mips/kernel/unaligned.c          |   27 +++++++++++++--------------
 arch/nds32/include/asm/uaccess.h      |    2 +-
 arch/nds32/kernel/process.c           |    2 +-
 arch/nds32/mm/alignment.c             |    7 +++----
 arch/nios2/include/asm/uaccess.h      |    2 +-
 arch/openrisc/include/asm/uaccess.h   |    2 +-
 arch/parisc/include/asm/uaccess.h     |    2 +-
 arch/powerpc/include/asm/uaccess.h    |    3 +--
 arch/riscv/include/asm/uaccess.h      |    6 +++---
 arch/s390/include/asm/uaccess.h       |    2 +-
 arch/sh/include/asm/segment.h         |    3 +--
 arch/sh/kernel/traps_32.c             |   12 +++++-------
 arch/sparc/include/asm/uaccess_32.h   |    2 +-
 arch/sparc/include/asm/uaccess_64.h   |    2 +-
 arch/x86/include/asm/uaccess.h        |    2 +-
 arch/xtensa/include/asm/uaccess.h     |    2 +-
 drivers/firmware/arm_sdei.c           |    5 ++---
 fs/exec.c                             |    7 ++++++-
 include/asm-generic/uaccess.h         |    4 ++--
 include/linux/syscalls.h              |    2 +-
 include/linux/uaccess.h               |   20 ++++++++++++++++++--
 kernel/events/callchain.c             |    5 ++---
 kernel/events/core.c                  |    5 ++---
 kernel/exit.c                         |    2 +-
 kernel/kthread.c                      |    5 ++---
 kernel/stacktrace.c                   |    5 ++---
 mm/maccess.c                          |   22 ++++++++++------------
 39 files changed, 99 insertions(+), 92 deletions(-)
