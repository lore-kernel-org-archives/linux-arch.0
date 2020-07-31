From: Christoph Hellwig <hch@lst.de>
Subject: improve compat handling for the i386 u64 alignment quirk v2
Date: Fri, 31 Jul 2020 14:21:59 +0200
Message-ID: <20200731122202.213333-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Jan Kara <jack@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi all,

the i386 ABI is a little special in that it uses less than natural
alignment for 64-bit integer types (u64 and s64), and a significant
amount of our compat handlers deals with just that.  Unfortunately
there is no good way to check for this specific quirk at runtime,
similar how in_compat_syscall() checks for a compat syscall.  This
series adds such a check, and then uses the quota code as an example
of how this improves the compat handling.  I have a few other places
in mind where this will also be useful going forward.

Changes since v1:
 - use asm-generic/compat.h instead of linux/compat.h for
   compat_u64 and compat_s64
 - fix a typo

Diffstat:
 b/arch/arm64/include/asm/compat.h        |    2 
 b/arch/mips/include/asm/compat.h         |    2 
 b/arch/parisc/include/asm/compat.h       |    2 
 b/arch/powerpc/include/asm/compat.h      |    2 
 b/arch/s390/include/asm/compat.h         |    2 
 b/arch/sparc/include/asm/compat.h        |    3 
 b/arch/x86/entry/syscalls/syscall_32.tbl |    2 
 b/arch/x86/include/asm/compat.h          |    3 
 b/fs/quota/Kconfig                       |    5 -
 b/fs/quota/Makefile                      |    1 
 b/fs/quota/compat.h                      |   34 ++++++++
 b/fs/quota/quota.c                       |   73 +++++++++++++++---
 b/include/asm-generic/compat.h           |    8 ++
 b/include/linux/compat.h                 |    9 ++
 b/include/linux/quotaops.h               |    3 
 b/kernel/sys_ni.c                        |    1 
 fs/quota/compat.c                        |  120 -------------------------------
 17 files changed, 113 insertions(+), 159 deletions(-)
