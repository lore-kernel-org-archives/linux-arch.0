Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:40673 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753341AbdFVM10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jun 2017 08:27:26 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/5] Last bits for initial 5-level paging enabling
Date: Thu, 22 Jun 2017 15:26:03 +0300
Message-ID: <20170622122608.80435-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20170622122603.3lu9s2DPYsRPn0SJmzJzLfHaM4r7mBD0o93ioN32zOU@z>

As Ingo requested I've split and updated last two patches for my previous
patchset.

Please review and consider applying.

Kirill A. Shutemov (5):
  x86: Enable 5-level paging support
  x86/mm: Rename tasksize_32bit/64bit to task_size_32bit/64bit
  x86/mpx: Do not allow MPX if we have mappings above 47-bit
  x86/mm: Prepare to expose larger address space to userspace
  x86/mm: Allow userspace have mapping above 47-bit

 Documentation/x86/x86_64/5level-paging.txt | 64 ++++++++++++++++++++++++++++++
 arch/x86/Kconfig                           | 18 +++++++++
 arch/x86/include/asm/elf.h                 |  6 +--
 arch/x86/include/asm/mpx.h                 |  9 +++++
 arch/x86/include/asm/processor.h           | 12 ++++--
 arch/x86/kernel/sys_x86_64.c               | 30 ++++++++++++--
 arch/x86/mm/hugetlbpage.c                  | 27 +++++++++++--
 arch/x86/mm/mmap.c                         | 12 +++---
 arch/x86/mm/mpx.c                          | 33 ++++++++++++++-
 arch/x86/xen/Kconfig                       |  3 ++
 10 files changed, 193 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/x86/x86_64/5level-paging.txt

-- 
2.11.0
