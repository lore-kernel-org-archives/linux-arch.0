From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 04/15] fs/dcache: Use release-acquire for name/length update
Date: Mon,  9 Oct 2017 17:22:38 -0700
Message-ID: <1507594969-8347-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755765AbdJJAWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0KIVR062193
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:54 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgkjxr3ce-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:54 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

The code in __d_alloc() carefully orders filling in the NUL character
of the name (and the length, hash, and the name itself) with assigning
of the name itself.  However, prepend_name() does not order the accesses
to the ->name and ->len fields, other than on TSO systems.  This commit
therefore replaces prepend_name()'s READ_ONCE() of ->name with an
smp_load_acquire(), which orders against the subsequent READ_ONCE() of
->len.  Because READ_ONCE() now incorporates smp_read_barrier_depends(),
prepend_name()'s smp_read_barrier_depends() is removed.  Finally,
to save a line, the smp_wmb()/store pair in __d_alloc() is replaced
by smp_store_release().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/dcache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f283cd31a491..c40ae213fd2f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1636,8 +1636,7 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dname[name->len] = 0;
 
 	/* Make sure we always see the terminating NUL character */
-	smp_wmb();
-	dentry->d_name.name = dname;
+	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
 
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
@@ -3049,17 +3048,14 @@ static int prepend(char **buffer, int *buflen, const char *str, int namelen)
  * retry it again when a d_move() does happen. So any garbage in the buffer
  * due to mismatched pointer and length will be discarded.
  *
- * Data dependency barrier is needed to make sure that we see that terminating
- * NUL.  Alpha strikes again, film at 11...
+ * Load acquire is needed to make sure that we see that terminating NUL.
  */
 static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
 {
-	const char *dname = READ_ONCE(name->name);
+	const char *dname = smp_load_acquire(&name->name); /* ^^^ */
 	u32 dlen = READ_ONCE(name->len);
 	char *p;
 
-	smp_read_barrier_depends();
-
 	*buflen -= dlen + 1;
 	if (*buflen < 0)
 		return -ENAMETOOLONG;
-- 
2.5.2
