From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 0/2] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Wed, 26 Oct 2016 18:43:05 +0100
Message-ID: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, keescook@chromium.org, luto@kernel.org, mark.rutland@arm.com
List-Id: linux-arch.vger.kernel.org

Hi all,

[resending for linux-arch, apologies for spam]

Heiko and I have been working on THREAD_INFO_IN_TASK for s390 and arm64
respectively, and we're both targetting v4.10.

These are the common core changes which we both require. I've put together a
branch [1,2] based on v4.9-rc2. I intend to tag this at some point next week so
that Heiko and I have a stable base.

Until then, any and all acks appreciated. ;)

Thanks,
Mark.

Since v1:
* Rebase to v4.9-rc2
* Drop Heiko's patch that was merged before -rc2
* Add Heiko's Acked-by
* Add Andy's Reviewed-by

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core/ti-stack-split
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=core/ti-stack-split

Mark Rutland (2):
  thread_info: factor out restart_block
  thread_info: include <current.h> for THREAD_INFO_IN_TASK

 include/linux/restart_block.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h   | 42 ++---------------------------------
 2 files changed, 53 insertions(+), 40 deletions(-)
 create mode 100644 include/linux/restart_block.h

-- 
1.9.1
