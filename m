Return-Path: <SRS0=t1zw=CH=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66509C433E6
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4135F2076D
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598706268;
	bh=9oQlGd1+Pkl4l313Q52v7ANZGwjXIwhw9+f/hm4+dQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K30iCTn8Jpl+blDv95NAyYGMQvfCbXySFwS/G02z1XnhGI+S4kxRf49OKa/LKcn+E
	 sUEtj5Rm9vskihrSciqagWlW3vTRo8ba6eDg0hy8woJEG8Sad3aaZlzqeoYQr9cTK6
	 /0imq+/PxLK+uEBJDLCYBHfVDWpgx6cLONiubAA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgH2NEQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgH2NDU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 09:03:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAAFB207DA;
        Sat, 29 Aug 2020 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706199;
        bh=9oQlGd1+Pkl4l313Q52v7ANZGwjXIwhw9+f/hm4+dQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYi+kcX5e1cc/3c0wTyXPe+nVMFsknk2fPhi9lfm2N9BXxlR49+BE2H4bATQmRquO
         uPq1E8TqopvbjO4U/r7CPOxMvA1Yb80e2GpUllWvSYIuzjUVnMdiMkNwG4oeX8v22T
         SlOhvnElBCXj+dFW9cKCYogk3dc1+4bwp4QyR7WM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, mhiramat@kernel.org
Subject: [PATCH v5 17/21] llist: Add nonatomic __llist_add() and __llist_dell_all()
Date:   Sat, 29 Aug 2020 22:03:13 +0900
Message-Id: <159870619318.1229682.13027387548510028721.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159870598914.1229682.15230803449082078353.stgit@devnote2>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/i915_request.c |    6 ------
 include/linux/llist.h               |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0b2fe55e6194..0e851b925c8c 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -357,12 +357,6 @@ void i915_request_retire_upto(struct i915_request *rq)
 	} while (i915_request_retire(tmp) && tmp != rq);
 }
 
-static void __llist_add(struct llist_node *node, struct llist_head *head)
-{
-	node->next = head->first;
-	head->first = node;
-}
-
 static struct i915_request * const *
 __engine_active(struct intel_engine_cs *engine)
 {
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2e9c7215882b..24f207b0190b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -197,6 +197,16 @@ static inline struct llist_node *llist_next(struct llist_node *node)
 extern bool llist_add_batch(struct llist_node *new_first,
 			    struct llist_node *new_last,
 			    struct llist_head *head);
+
+static inline bool __llist_add_batch(struct llist_node *new_first,
+				     struct llist_node *new_last,
+				     struct llist_head *head)
+{
+	new_last->next = head->first;
+	head->first = new_first;
+	return new_last->next == NULL;
+}
+
 /**
  * llist_add - add a new entry
  * @new:	new entry to be added
@@ -209,6 +219,11 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
 	return llist_add_batch(new, new, head);
 }
 
+static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
+{
+	return __llist_add_batch(new, new, head);
+}
+
 /**
  * llist_del_all - delete all entries from lock-less list
  * @head:	the head of lock-less list to delete all entries
@@ -222,6 +237,14 @@ static inline struct llist_node *llist_del_all(struct llist_head *head)
 	return xchg(&head->first, NULL);
 }
 
+static inline struct llist_node *__llist_del_all(struct llist_head *head)
+{
+	struct llist_node *first = head->first;
+
+	head->first = NULL;
+	return first;
+}
+
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
 struct llist_node *llist_reverse_order(struct llist_node *head);

