Return-Path: <SRS0=g7wM=BF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGZQEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 12:04:07 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: improve compat handling for the i386 u64 alignment quirk
Date: Sun, 26 Jul 2020 18:03:57 +0200
Message-ID: <20200726160401.311569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, Jan Kara <jack@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200726160357.CqKn8q4S7hDGssiKRRlmM84M0UBG1-MO4T-gRruLtWc@z>

Hi all,

the i386 ABI is a little special in that it uses less than natural
alignment for 64-bit integer types (u64 and s64), and a significant
amount of our compat handlers deals with just that.  Unfortunately
there is no good way to check for this specific quirk at runtime,
similar how in_compat_syscall() checks for a compat syscall.  This
series adds such a check, and then uses the quota code as an example
of how this improves the compat handling.  I have a few other places
in mind where this will also be useful going forward.

Diffstat:
 b/arch/arm64/include/asm/compat.h        |    2 
 b/arch/arm64/include/asm/stat.h          |    2 
 b/arch/arm64/kernel/process.c            |    1 
 b/arch/arm64/kernel/ptrace.c             |    1 
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
 b/include/linux/compat.h                 |   17 ++++
 b/include/linux/quotaops.h               |    3 
 b/kernel/sys_ni.c                        |    1 
 fs/quota/compat.c                        |  120 -------------------------------
 19 files changed, 114 insertions(+), 162 deletions(-)
