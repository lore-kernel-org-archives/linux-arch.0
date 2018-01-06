From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 18/18] userns: prevent bounds-check bypass via speculative
 execution
Date: Fri, 05 Jan 2018 17:11:32 -0800
Message-ID: <151520109193.32271.1578212450835287742.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

Static analysis reports that 'pos' may be a user controlled value that
is used as a data dependency determining which extent to return out of
'map'. In order to avoid potential leaks of kernel memory values, block
speculative execution of the instruction stream that could issue further
reads based on an invalid speculative result from 'm_start()'.

Based on an original patch by Elena Reshetova.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/user_namespace.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 246d4d4ce5c7..e958f2e5c061 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -648,15 +648,13 @@ static void *m_start(struct seq_file *seq, loff_t *ppos,
 {
 	loff_t pos = *ppos;
 	unsigned extents = map->nr_extents;
-	smp_rmb();
 
-	if (pos >= extents)
-		return NULL;
+	/* paired with smp_wmb in map_write */
+	smp_rmb();
 
 	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-		return &map->extent[pos];
-
-	return &map->forward[pos];
+		return nospec_array_ptr(map->extent, pos, extents);
+	return nospec_array_ptr(map->forward, pos, extents);
 }
 
 static void *uid_m_start(struct seq_file *seq, loff_t *ppos)
