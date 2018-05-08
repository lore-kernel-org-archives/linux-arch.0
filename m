From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2] mm: expland documentation over __read_mostly
Date: Tue,  8 May 2018 11:19:24 -0700
Message-ID: <20180508181924.19939-1-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, arnd@arndb.de, cl@linux.com
Cc: keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com, willy@infradead.org, ebiederm@xmission.com, rdunlap@infradead.org, joel.opensrc@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

__read_mostly can easily be misused by folks, its not meant for
just read-only data. There are performance reasons for using it, but
we also don't provide any guidance about its use. Provide a bit more
guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/linux/cache.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..4967566ed08c 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -15,8 +15,16 @@
 
 /*
  * __read_mostly is used to keep rarely changing variables out of frequently
- * updated cachelines. If an architecture doesn't support it, ignore the
- * hint.
+ * updated cachelines. Its use should be reserved for data that is used
+ * frequently in hot paths. Performance traces can help decide when to use
+ * this. You want __read_mostly data to be tightly packed, so that in the
+ * best case multiple frequently read variables for a hot path will be next
+ * to each other in order to reduce the number of cachelines needed to
+ * execute a critial path. We should be mindful and selective of its use.
+ * ie: if you're going to use it please supply a *good* justification in your
+ * commit log.
+ *
+ * If an architecture doesn't support it, ignore the hint.
  */
 #ifndef __read_mostly
 #define __read_mostly
-- 
2.17.0
