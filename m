From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Wed, 19 Oct 2016 19:28:10 +0100
Message-ID: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754353AbcJSS2z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Oct 2016 14:28:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de

Hi all,

Heiko and I have been working on THREAD_INFO_IN_TASK for s390 and arm64
respectively, and we're both targetting v4.10.

These are the common core changes which we both require, which happen to
touch x86 and some core headers. We'd either need these merged for
v4.9-rc*, or placed on a stable branch/tag that we can both base atop
of.

I've put together a branch [1,2] based on v4.9-rc1, but the patches themselves
are sorely lacking in relevant acks. Are people willing to help change that? ;)

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core/ti-stack-split
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=core/ti-stack-split

Heiko Carstens (1):
  sched/core,x86: make struct thread_info arch specific again

Mark Rutland (2):
  thread_info: factor out restart_block
  thread_info: include <current.h> for THREAD_INFO_IN_TASK

 arch/x86/include/asm/thread_info.h |  9 +++++++
 include/linux/restart_block.h      | 51 ++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h        | 53 ++------------------------------------
 3 files changed, 62 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/restart_block.h

-- 
1.9.1
