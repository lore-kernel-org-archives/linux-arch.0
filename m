Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32906 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbcB2N1l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 08:27:41 -0500
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 18/18] drm/amdgpu: make amdgpu_mn_get wait for mmap_sem killable
Date: Mon, 29 Feb 2016 14:26:57 +0100
Message-ID: <1456752417-9626-19-git-send-email-mhocko@kernel.org>
In-Reply-To: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr Cermak <petrcermak@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>
Message-ID: <20160229132657.DDwa4LXji5FAm8vFJE-21K6U0ohp0EPst0o5kL8xIeU@z>

From: Michal Hocko <mhocko@suse.com>

amdgpu_mn_get which is called during ioct path relies on mmap_sem for
write. If the waiting task gets killed by the oom killer it would block
oom_reaper from asynchronous address space reclaim and reduce the
chances of timely OOM resolving. Wait for the lock in the killable mode
and return with EINTR if the task got killed while waiting.

Cc: David Airlie <airlied@linux.ie>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index d7ec9bd6755f..6f44f1c23be3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -181,7 +181,10 @@ static struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev)
 	int r;
 
 	mutex_lock(&adev->mn_lock);
-	down_write(&mm->mmap_sem);
+	if (down_write_killable(&mm->mmap_sem)) {
+		mutex_unlock(&adev->mn_lock);
+		return -EINTR;
+	}
 
 	hash_for_each_possible(adev->mn_hash, rmn, node, (unsigned long)mm)
 		if (rmn->mm == mm)
-- 
2.7.0

