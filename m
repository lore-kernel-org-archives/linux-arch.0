Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38564 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 23:35:03 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/5] Allow CPU0 to be nohz full
Date: Thu, 11 Apr 2019 13:34:43 +1000
Message-ID: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190411033443.dn4SEx5DajEJx2ROPrp9-8jn4AX0fBWrJZXgrowfpLI@z>

Since last time, I added a compile time option to opt-out of this
if the platform does not support suspend on non-zero, and tried to
improve legibility of changelogs and explain the justification
better.

I have been testing this on powerpc/pseries and it seems to work
fine (the firmware call to suspend can be called on any CPU and
resumes where it left off), but not included here because the
code has some bitrot unrelated to this series which I hacked to
fix. I will discuss it and either send an acked patch to go with
this series if it is small, or fix it in powerpc tree.

Thanks,
Nick

Nicholas Piggin (5):
  sched/core: allow the remote scheduler tick to be started on CPU0
  PM / suspend: add function to disable secondaries for suspend
  kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec
    freeze
  kernel/sched/isolation: require a present CPU in housekeeping mask
  nohz_full: Allow the boot CPU to be nohz_full

 include/linux/cpu.h       | 15 ++++++++++++
 kernel/cpu.c              | 10 +++++++-
 kernel/kexec_core.c       |  4 ++--
 kernel/power/Kconfig      |  9 +++++++
 kernel/power/hibernate.c  | 12 +++++-----
 kernel/power/suspend.c    |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/sched/isolation.c  | 18 ++++++++++----
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++--------
 11 files changed, 131 insertions(+), 31 deletions(-)

-- 
2.20.1
