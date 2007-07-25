Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:47295 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759361AbXGYLkL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 07:40:11 -0400
Date: Wed, 25 Jul 2007 13:40:10 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 6/7] buffer lock: use lock bitops
Message-ID: <20070725114009.GL29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Convert buffer lock to new locking bitops. Like the page lock change, this
also requires name change, so convert the raw bitop to a trylock.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 fs/buffer.c                 |    7 +++----
 fs/jbd/commit.c             |    2 +-
 fs/jbd2/commit.c            |    2 +-
 fs/ntfs/aops.c              |    2 +-
 fs/ntfs/compress.c          |    2 +-
 fs/ntfs/mft.c               |    4 ++--
 fs/reiserfs/inode.c         |    2 +-
 fs/reiserfs/journal.c       |    4 ++--
 include/linux/buffer_head.h |    8 ++++++--
 9 files changed, 18 insertions(+), 15 deletions(-)

Index: linux-2.6/fs/jbd/commit.c
===================================================================
--- linux-2.6.orig/fs/jbd/commit.c
+++ linux-2.6/fs/jbd/commit.c
@@ -208,7 +208,7 @@ write_out_data:
 		 * blocking lock_buffer().
 		 */
 		if (buffer_dirty(bh)) {
-			if (test_set_buffer_locked(bh)) {
+			if (!trylock_buffer(bh)) {
 				BUFFER_TRACE(bh, "needs blocking lock");
 				spin_unlock(&journal->j_list_lock);
 				/* Write out all data to prevent deadlocks */
Index: linux-2.6/fs/jbd2/commit.c
===================================================================
--- linux-2.6.orig/fs/jbd2/commit.c
+++ linux-2.6/fs/jbd2/commit.c
@@ -208,7 +208,7 @@ write_out_data:
 		 * blocking lock_buffer().
 		 */
 		if (buffer_dirty(bh)) {
-			if (test_set_buffer_locked(bh)) {
+			if (!trylock_buffer(bh)) {
 				BUFFER_TRACE(bh, "needs blocking lock");
 				spin_unlock(&journal->j_list_lock);
 				/* Write out all data to prevent deadlocks */
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -76,8 +76,7 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
-	smp_mb__before_clear_bit();
-	clear_buffer_locked(bh);
+	clear_bit_unlock(BH_Lock, &bh->b_state);
 	smp_mb__after_clear_bit();
 	wake_up_bit(&bh->b_state, BH_Lock);
 }
@@ -1673,7 +1672,7 @@ static int __block_write_full_page(struc
 		 */
 		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
 			lock_buffer(bh);
-		} else if (test_set_buffer_locked(bh)) {
+		} else if (!trylock_buffer(bh)) {
 			redirty_page_for_writepage(wbc, page);
 			continue;
 		}
@@ -2734,7 +2733,7 @@ void ll_rw_block(int rw, int nr, struct 
 
 		if (rw == SWRITE)
 			lock_buffer(bh);
-		else if (test_set_buffer_locked(bh))
+		else if (!trylock_buffer(bh))
 			continue;
 
 		if (rw == WRITE || rw == SWRITE) {
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -115,7 +115,6 @@ BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
 BUFFER_FNS(Lock, locked)
-TAS_BUFFER_FNS(Lock, locked)
 BUFFER_FNS(Req, req)
 TAS_BUFFER_FNS(Req, req)
 BUFFER_FNS(Mapped, mapped)
@@ -304,10 +303,15 @@ static inline void wait_on_buffer(struct
 		__wait_on_buffer(bh);
 }
 
+static inline int trylock_buffer(struct buffer_head *bh)
+{
+	return likely(!test_and_set_bit_lock(BH_Lock, &bh->b_state));
+}
+
 static inline void lock_buffer(struct buffer_head *bh)
 {
 	might_sleep();
-	if (test_set_buffer_locked(bh))
+	if (!trylock_buffer(bh))
 		__lock_buffer(bh);
 }
 
Index: linux-2.6/fs/ntfs/aops.c
===================================================================
--- linux-2.6.orig/fs/ntfs/aops.c
+++ linux-2.6/fs/ntfs/aops.c
@@ -1183,7 +1183,7 @@ lock_retry_remap:
 		tbh = bhs[i];
 		if (!tbh)
 			continue;
-		if (unlikely(test_set_buffer_locked(tbh)))
+		if (!trylock_buffer(tbh))
 			BUG();
 		/* The buffer dirty state is now irrelevant, just clean it. */
 		clear_buffer_dirty(tbh);
Index: linux-2.6/fs/ntfs/compress.c
===================================================================
--- linux-2.6.orig/fs/ntfs/compress.c
+++ linux-2.6/fs/ntfs/compress.c
@@ -655,7 +655,7 @@ lock_retry_remap:
 	for (i = 0; i < nr_bhs; i++) {
 		struct buffer_head *tbh = bhs[i];
 
-		if (unlikely(test_set_buffer_locked(tbh)))
+		if (!trylock_buffer(tbh))
 			continue;
 		if (unlikely(buffer_uptodate(tbh))) {
 			unlock_buffer(tbh);
Index: linux-2.6/fs/ntfs/mft.c
===================================================================
--- linux-2.6.orig/fs/ntfs/mft.c
+++ linux-2.6/fs/ntfs/mft.c
@@ -586,7 +586,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vo
 		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
 			struct buffer_head *tbh = bhs[i_bhs];
 
-			if (unlikely(test_set_buffer_locked(tbh)))
+			if (!trylock_buffer(tbh))
 				BUG();
 			BUG_ON(!buffer_uptodate(tbh));
 			clear_buffer_dirty(tbh);
@@ -779,7 +779,7 @@ int write_mft_record_nolock(ntfs_inode *
 	for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
 		struct buffer_head *tbh = bhs[i_bhs];
 
-		if (unlikely(test_set_buffer_locked(tbh)))
+		if (!trylock_buffer(tbh))
 			BUG();
 		BUG_ON(!buffer_uptodate(tbh));
 		clear_buffer_dirty(tbh);
Index: linux-2.6/fs/reiserfs/inode.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/inode.c
+++ linux-2.6/fs/reiserfs/inode.c
@@ -2440,7 +2440,7 @@ static int reiserfs_write_full_page(stru
 		if (wbc->sync_mode != WB_SYNC_NONE || !wbc->nonblocking) {
 			lock_buffer(bh);
 		} else {
-			if (test_set_buffer_locked(bh)) {
+			if (!trylock_buffer(bh)) {
 				redirty_page_for_writepage(wbc, page);
 				continue;
 			}
Index: linux-2.6/fs/reiserfs/journal.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/journal.c
+++ linux-2.6/fs/reiserfs/journal.c
@@ -830,7 +830,7 @@ static int write_ordered_buffers(spinloc
 		jh = JH_ENTRY(list->next);
 		bh = jh->bh;
 		get_bh(bh);
-		if (test_set_buffer_locked(bh)) {
+		if (!trylock_buffer(bh)) {
 			if (!buffer_dirty(bh)) {
 				list_move(&jh->list, &tmp);
 				goto loop_next;
@@ -3838,7 +3838,7 @@ int reiserfs_prepare_for_journal(struct 
 {
 	PROC_INFO_INC(p_s_sb, journal.prepare);
 
-	if (test_set_buffer_locked(bh)) {
+	if (!trylock_buffer(bh)) {
 		if (!wait)
 			return 0;
 		lock_buffer(bh);
