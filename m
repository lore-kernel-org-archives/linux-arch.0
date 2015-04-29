From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/13] Use bool with jbd2_journal_cancel_revoke()
Date: Wed, 29 Apr 2015 20:22:34 +0100
Message-ID: <20150429192233.24909.16973.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

jbd2_journal_cancel_revoke() should return a bool as it returns a boolean
value only, and should use bool type for a couple of internal variables.  This
allows gcc to make better decisions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/jbd2/revoke.c     |   10 +++++-----
 include/linux/jbd2.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index c6cbaef2bda1..587b4947f0d0 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -417,12 +417,12 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
  * do not trust the Revoked bit on buffers unless RevokeValid is also
  * set.
  */
-int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
+bool jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 {
 	struct jbd2_revoke_record_s *record;
 	journal_t *journal = handle->h_transaction->t_journal;
-	int need_cancel;
-	int did_revoke = 0;	/* akpm: debug */
+	bool need_cancel;
+	int did_revoke = false;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
 
 	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
@@ -434,7 +434,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	if (test_set_buffer_revokevalid(bh)) {
 		need_cancel = test_clear_buffer_revoked(bh);
 	} else {
-		need_cancel = 1;
+		need_cancel = true;
 		clear_buffer_revoked(bh);
 	}
 
@@ -447,7 +447,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 			list_del(&record->hash);
 			spin_unlock(&journal->j_revoke_lock);
 			kmem_cache_free(jbd2_revoke_record_cache, record);
-			did_revoke = 1;
+			did_revoke = true;
 		}
 	}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 20e7f78041c8..716f1d15e83d 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1219,7 +1219,7 @@ extern int	   jbd2_journal_init_revoke_caches(void);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
 extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
-extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
+extern bool	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
 extern void	   jbd2_journal_write_revoke_records(journal_t *journal,
 						     transaction_t *transaction,
 						     struct list_head *log_bufs,
