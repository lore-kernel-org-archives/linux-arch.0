Return-Path: <SRS0=//km=6U=kvack.org=owner-linux-mm@kernel.org>
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] mm: expland documentation over __read_mostly
Date: Wed,  6 May 2020 23:13:53 +0000
Message-ID: <20200506231353.32451-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: cl@linux.com, akpm@linux-foundation.org
Cc: arnd@arndb.de, willy@infradead.org, aquini@redhat.com, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200506231353.VtXNt0JsngsJR9WNY951WEFT-1kSrLFAkghH8lFdR94@z>

__read_mostly can easily be misused by folks, its not meant for
just read-only data. There are performance reasons for using it, but
we also don't provide any guidance about its use. Provide a bit more
guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

I sent this 2 years ago, but it fell through the cracks. This time
I'm adding Andrew Morton now, the fix0r-of-falling-through-the-cracks.

Resending as I just saw a patch which doesn't clearly justifiy the
merits of the use of __read_mostly on it.

 include/linux/cache.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..8106fb304fa7 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -15,8 +15,14 @@
=20
 /*
  * __read_mostly is used to keep rarely changing variables out of freque=
ntly
- * updated cachelines. If an architecture doesn't support it, ignore the
- * hint.
+ * updated cachelines. Its use should be reserved for data that is used
+ * frequently in hot paths. Performance traces can help decide when to u=
se
+ * this. You want __read_mostly data to be tightly packed, so that in th=
e
+ * best case multiple frequently read variables for a hot path will be n=
ext
+ * to each other in order to reduce the number of cachelines needed to
+ * execute a critial path. We should be mindful and selective of its use=
.
+ * ie: if you're going to use it please supply a *good* justification in=
 your
+ * commit log
  */
 #ifndef __read_mostly
 #define __read_mostly
--=20
2.25.1
