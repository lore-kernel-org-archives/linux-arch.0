From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 15/15] keyring: Remove now-redundant smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:49 -0700
Message-ID: <1507594969-8347-15-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755833AbdJJAW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JP2P139032
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:56 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd11ab54-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:55 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Now that the associative-array library properly heads dependency chains,
the various smp_read_barrier_depends() calls in security/keys/keyring.c
are no longer needed.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <keyrings@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
---
 security/keys/keyring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4fa82a8a9c0e..fb44c9169125 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -712,7 +712,6 @@ static bool search_nested_keyrings(struct key *keyring,
 		 * doesn't contain any keyring pointers.
 		 */
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
 			goto not_this_keyring;
 
@@ -722,8 +721,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	}
 
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
-
 	ptr = node->slots[0];
 	if (!assoc_array_ptr_is_meta(ptr))
 		goto begin_node;
@@ -735,7 +732,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	kdebug("descend");
 	if (assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->next_node);
 		BUG_ON(!assoc_array_ptr_is_node(ptr));
 	}
@@ -743,7 +739,6 @@ static bool search_nested_keyrings(struct key *keyring,
 
 begin_node:
 	kdebug("begin_node");
-	smp_read_barrier_depends();
 	slot = 0;
 ascend_to_node:
 	/* Go through the slots in a node */
@@ -791,14 +786,12 @@ static bool search_nested_keyrings(struct key *keyring,
 
 	if (ptr && assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
 	}
 	if (!ptr)
 		goto not_this_keyring;
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
 	slot++;
 
 	/* If we've ascended to the root (zero backpointer), we must have just
-- 
2.5.2
