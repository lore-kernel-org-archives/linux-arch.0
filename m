From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] mm: expand documentation over __read_mostly
Date: Thu,  7 May 2020 16:14:24 +0000
Message-ID: <20200507161424.2584-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40922 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgEGQO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 12:14:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: cl@linux.com, akpm@linux-foundation.org
Cc: arnd@arndb.de, willy@infradead.org, aquini@redhat.com, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

__read_mostly can easily be misused by folks, its not meant for
just read-only data. There are performance reasons for using it, but
we also don't provide any guidance about its use. Provide a bit more
guidance over its use.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This v2 just has a few spelling fixes.

 include/linux/cache.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..8106fb304fa7 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -15,8 +15,14 @@
 
 /*
  * __read_mostly is used to keep rarely changing variables out of frequently
- * updated cachelines. If an architecture doesn't support it, ignore the
- * hint.
+ * updated cachelines. Its use should be reserved for data that is used
+ * frequently in hot paths. Performance traces can help decide when to use
+ * this. You want __read_mostly data to be tightly packed, so that in the
+ * best case multiple frequently read variables for a hot path will be next
+ * to each other in order to reduce the number of cachelines needed to
+ * execute a critical path. We should be mindful and selective of its use.
+ * ie: if you're going to use it please supply a *good* justification in your
+ * commit log
  */
 #ifndef __read_mostly
 #define __read_mostly
-- 
2.25.1
