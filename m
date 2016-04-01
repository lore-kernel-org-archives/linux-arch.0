Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33883 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895AbcDALFR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2016 07:05:17 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 09/11] xtensa, rwsem: provide __down_write_killable
Date: Fri,  1 Apr 2016 13:04:53 +0200
Message-ID: <1459508695-14915-10-git-send-email-mhocko@kernel.org>
In-Reply-To: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
References: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Message-ID: <20160401110453.ePqgWV9G4_9XpL-yBV8rbs_sgo7mHoD1P-jgk7UqO74@z>

From: Michal Hocko <mhocko@suse.com>

which uses the same fast path as __down_write except it falls back to
rwsem_down_write_failed_killable slow path and return -EINTR if killed.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/xtensa/include/asm/rwsem.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/xtensa/include/asm/rwsem.h b/arch/xtensa/include/asm/rwsem.h
index 593483f6e1ff..6283823b8040 100644
--- a/arch/xtensa/include/asm/rwsem.h
+++ b/arch/xtensa/include/asm/rwsem.h
@@ -59,6 +59,19 @@ static inline void __down_write(struct rw_semaphore *sem)
 		rwsem_down_write_failed(sem);
 }
 
+static inline int __down_write_killable(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
+				(atomic_t *)(&sem->count));
+	if (tmp != RWSEM_ACTIVE_WRITE_BIAS)
+		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
+			return -EINTR;
+
+	return 0;
+}
+
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	int tmp;
-- 
2.8.0.rc3

