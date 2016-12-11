From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Sun, 11 Dec 2016 18:26:39 +0530
Message-ID: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
References: <20161210092130.GA19309@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:20237
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751335AbcLKM5U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Dec 2016 07:57:20 -0500
In-Reply-To: <20161210092130.GA19309@xo-6d-61-c0.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kerne

This is the draft of sys_mmap64() support in the kernel. For 64-bit
kernels everything is simple. For 32-bit kernels we have a problem.
pgoff_t is declared as unsigned long, and should be turned to 
unsigned long long. It affects the number of structures and interfaces.
Last patch does the change. It should be wide-tested on 32-bit kernels
whith I didn't do. Arm64 kernel is working with this patchset, and I don't
expect difficulties there.

Yury Norov (3):
  mm: move argument checkers of mmap_pgoff() to separated routine
  sys_mmap64()
  mm: turn page offset types to 64-bit

 fs/btrfs/extent_io.c              |  2 +-
 fs/ext2/dir.c                     |  4 +--
 include/linux/mm.h                |  9 +++---
 include/linux/radix-tree.h        |  8 ++---
 include/linux/syscalls.h          |  3 ++
 include/linux/types.h             |  2 +-
 include/uapi/asm-generic/unistd.h |  4 ++-
 lib/radix-tree.c                  |  8 ++---
 mm/debug.c                        |  2 +-
 mm/internal.h                     |  2 +-
 mm/memory.c                       |  4 +--
 mm/mmap.c                         | 66 ++++++++++++++++++++++++++++++++-------
 mm/readahead.c                    |  4 +--
 mm/util.c                         |  3 +-
 14 files changed, 85 insertions(+), 36 deletions(-)

-- 
2.7.4
