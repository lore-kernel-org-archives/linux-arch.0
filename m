From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 01/19] dm integrity: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:11 -0700
Message-ID: <1508792849-3115-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't pick up some uses, including those
in dm-integrity.c. As a preparatory step, this patch converts the driver
to use {READ,WRITE}_ONCE() consistently.

At the same time, this patch adds the missing include of
<linux/compiler.h> necessary for the {READ,WRITE}_ONCE() definitions.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-integrity.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 096fe9b66c50..8c5756e1df94 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -6,6 +6,7 @@
  * This file is released under the GPL.
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/device-mapper.h>
 #include <linux/dm-io.h>
@@ -80,13 +81,13 @@ struct journal_entry {
 #define journal_entry_tag(ic, je)		((__u8 *)&(je)->last_bytes[(ic)->sectors_per_block])
 
 #if BITS_PER_LONG == 64
-#define journal_entry_set_sector(je, x)		do { smp_wmb(); ACCESS_ONCE((je)->u.sector) = cpu_to_le64(x); } while (0)
+#define journal_entry_set_sector(je, x)		do { smp_wmb(); WRITE_ONCE((je)->u.sector, cpu_to_le64(x)); } while (0)
 #define journal_entry_get_sector(je)		le64_to_cpu((je)->u.sector)
 #elif defined(CONFIG_LBDAF)
-#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); ACCESS_ONCE((je)->u.s.sector_hi) = cpu_to_le32((x) >> 32); } while (0)
+#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); WRITE_ONCE((je)->u.s.sector_hi, cpu_to_le32((x) >> 32)); } while (0)
 #define journal_entry_get_sector(je)		le64_to_cpu((je)->u.sector)
 #else
-#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); ACCESS_ONCE((je)->u.s.sector_hi) = cpu_to_le32(0); } while (0)
+#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); WRITE_ONCE((je)->u.s.sector_hi, cpu_to_le32(0)); } while (0)
 #define journal_entry_get_sector(je)		le32_to_cpu((je)->u.s.sector_lo)
 #endif
 #define journal_entry_is_unused(je)		((je)->u.s.sector_hi == cpu_to_le32(-1))
@@ -320,7 +321,7 @@ static void dm_integrity_io_error(struct dm_integrity_c *ic, const char *msg, in
 
 static int dm_integrity_failed(struct dm_integrity_c *ic)
 {
-	return ACCESS_ONCE(ic->failed);
+	return READ_ONCE(ic->failed);
 }
 
 static commit_id_t dm_integrity_commit_id(struct dm_integrity_c *ic, unsigned i,
@@ -1545,7 +1546,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 		smp_mb();
 		if (unlikely(waitqueue_active(&ic->copy_to_journal_wait)))
 			wake_up(&ic->copy_to_journal_wait);
-		if (ACCESS_ONCE(ic->free_sectors) <= ic->free_sectors_threshold) {
+		if (READ_ONCE(ic->free_sectors) <= ic->free_sectors_threshold) {
 			queue_work(ic->commit_wq, &ic->commit_work);
 		} else {
 			schedule_autocommit(ic);
@@ -1798,7 +1799,7 @@ static void integrity_commit(struct work_struct *w)
 	ic->n_committed_sections += commit_sections;
 	spin_unlock_irq(&ic->endio_wait.lock);
 
-	if (ACCESS_ONCE(ic->free_sectors) <= ic->free_sectors_threshold)
+	if (READ_ONCE(ic->free_sectors) <= ic->free_sectors_threshold)
 		queue_work(ic->writer_wq, &ic->writer_work);
 
 release_flush_bios:
@@ -1980,7 +1981,7 @@ static void integrity_writer(struct work_struct *w)
 	unsigned prev_free_sectors;
 
 	/* the following test is not needed, but it tests the replay code */
-	if (ACCESS_ONCE(ic->suspending))
+	if (READ_ONCE(ic->suspending))
 		return;
 
 	spin_lock_irq(&ic->endio_wait.lock);
-- 
2.5.2
