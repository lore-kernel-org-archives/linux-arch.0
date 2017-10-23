From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 05/19] fs: ncpfs: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:15 -0700
Message-ID: <1508792849-3115-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751616AbdJWVHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7L70102853
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsnegxu3s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Petr Vandrovec <petr@vandrovec.name>

From: Mark Rutland <mark.rutland@arm.com>

The NCPFS code has some stale comments regarding ACCESS_ONCE() uses
which were removed a long time ago.

Let's remove the stale comments.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Petr Vandrovec <petr@vandrovec.name>
---
 fs/ncpfs/dir.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ncpfs/dir.c b/fs/ncpfs/dir.c
index 088f52484d6e..72cfaa253a8f 100644
--- a/fs/ncpfs/dir.c
+++ b/fs/ncpfs/dir.c
@@ -119,10 +119,6 @@ static inline int ncp_case_sensitive(const struct inode *i)
 /*
  * Note: leave the hash unchanged if the directory
  * is case-sensitive.
- *
- * Accessing the parent inode can be racy under RCU pathwalking.
- * Use ACCESS_ONCE() to make sure we use _one_ particular inode,
- * the callers will handle races.
  */
 static int 
 ncp_hash_dentry(const struct dentry *dentry, struct qstr *this)
@@ -147,11 +143,6 @@ ncp_hash_dentry(const struct dentry *dentry, struct qstr *this)
 	return 0;
 }
 
-/*
- * Accessing the parent inode can be racy under RCU pathwalking.
- * Use ACCESS_ONCE() to make sure we use _one_ particular inode,
- * the callers will handle races.
- */
 static int
 ncp_compare_dentry(const struct dentry *dentry,
 		unsigned int len, const char *str, const struct qstr *name)
-- 
2.5.2
