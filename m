From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 07/18] mm, proc: make clear_refs killable
Date: Mon, 29 Feb 2016 14:26:46 +0100
Message-ID: <1456752417-9626-8-git-send-email-mhocko@kernel.org>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36725 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcB2N1W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 08:27:22 -0500
In-Reply-To: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>

From: Michal Hocko <mhocko@suse.com>

CLEAR_REFS_MM_HIWATER_RSS and CLEAR_REFS_SOFT_DIRTY are relying on
mmap_sem for write. If the waiting task gets killed by the oom killer
and it would operate on the current's mm it would block oom_reaper from
asynchronous address space reclaim and reduce the chances of timely OOM
resolving. Wait for the lock in the killable mode and return with EINTR
if the task got killed while waiting. This will also expedite the return
to the userspace and do_exit even if the mm is remote.

Cc: Petr Cermak <petrcermak@chromium.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/task_mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9df431642042..fc303fa1f5c0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1027,11 +1027,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		};
 
 		if (type == CLEAR_REFS_MM_HIWATER_RSS) {
+			if (down_write_killable(&mm->mmap_sem)) {
+				put_task_struct(task);
+				return -EINTR;
+			}
+
 			/*
 			 * Writing 5 to /proc/pid/clear_refs resets the peak
 			 * resident set size to this mm's current rss value.
 			 */
-			down_write(&mm->mmap_sem);
 			reset_mm_hiwater_rss(mm);
 			up_write(&mm->mmap_sem);
 			goto out_mm;
@@ -1043,7 +1047,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				up_read(&mm->mmap_sem);
-				down_write(&mm->mmap_sem);
+				if (down_write_killable(&mm->mmap_sem)) {
+					put_task_struct(task);
+					return -EINTR;
+				}
 				for (vma = mm->mmap; vma; vma = vma->vm_next) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
-- 
2.7.0
