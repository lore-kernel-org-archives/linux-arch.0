From: guoren@kernel.org
Subject: [GIT PULL] csky updates for v5.7-rc8
Date: Thu, 28 May 2020 08:59:32 +0800
Message-ID: <1590627572-10100-1-git-send-email-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1A7p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 20:59:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org

Hi Linus,

Please pull the 4 fixups for v5.7-rc8.

Best Regards
 Guo Ren

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc8

for you to fetch changes up to f36e0aab6f1f78d770ce859df3f07a9c5763ce5f:

  csky: Fixup CONFIG_DEBUG_RSEQ (2020-05-28 00:18:36 +0000)

----------------------------------------------------------------
csky updates for 5.7-rc8

Another 4 fixups for csky:
 - fixup req_syscall debug
 - fixup abiv2 syscall_trace
 - fixup preempt enable
 - Cleanup regs usage in entry.S

----------------------------------------------------------------
Guo Ren (4):
      csky: Fixup CONFIG_PREEMPT panic
      csky: Fixup abiv2 syscall_trace break a4 & a5
      csky: Coding convention in entry.S
      csky: Fixup CONFIG_DEBUG_RSEQ

 arch/csky/abiv1/inc/abi/entry.h     |   6 --
 arch/csky/abiv2/inc/abi/entry.h     |   8 +--
 arch/csky/include/asm/thread_info.h |   6 ++
 arch/csky/kernel/entry.S            | 117 ++++++++++++++++++------------------
 4 files changed, 66 insertions(+), 71 deletions(-)
