Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34896 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbcB2N1j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 08:27:39 -0500
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 14/18] prctl: make PR_SET_THP_DISABLE wait for mmap_sem killable
Date: Mon, 29 Feb 2016 14:26:53 +0100
Message-ID: <1456752417-9626-15-git-send-email-mhocko@kernel.org>
In-Reply-To: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr Cermak <petrcermak@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>
Message-ID: <20160229132653.S01AcI4X3rWXrY3uJRJ6Ve7T_cDsRTzXDp85FlFftCs@z>

From: Michal Hocko <mhocko@suse.com>

PR_SET_THP_DISABLE requires mmap_sem for write. If the waiting
task gets killed by the oom killer it would block oom_reaper from
asynchronous address space reclaim and reduce the chances of timely OOM
resolving. Wait for the lock in the killable mode and return with EINTR
if the task got killed while waiting.

Cc: Alex Thorlton <athorlton@sgi.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index cf8ba545c7d3..89d5be418157 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2246,7 +2246,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_THP_DISABLE:
 		if (arg3 || arg4 || arg5)
 			return -EINVAL;
-		down_write(&me->mm->mmap_sem);
+		if (down_write_killable(&me->mm->mmap_sem))
+			return -EINTR;
 		if (arg2)
 			me->mm->def_flags |= VM_NOHUGEPAGE;
 		else
-- 
2.7.0

