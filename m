From: David Howells <dhowells@redhat.com>
Subject: [PATCH 18/35] UAPI: Fix up linux/netfilter/xt_policy.h
Date: Sat, 02 Jul 2011 12:10:09 +0100
Message-ID: <20110702111009.21948.84496.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLKN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BADIR019333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:13 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Fix up linux/netfilter/xt_policy.h to make it splittable.  This requires a
mark to be placed on the #ifdef __KERNEL__ in struct xt_policy_elem to tell
the splitter to ignore it.

Would it be possible, I wonder, to rename union nf_inet_addr to xt_policy_addr
instead?

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/netfilter/xt_policy.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/netfilter/xt_policy.h b/include/linux/netfilter/xt_policy.h
index be8ead0..573da52 100644
--- a/include/linux/netfilter/xt_policy.h
+++ b/include/linux/netfilter/xt_policy.h
@@ -35,7 +35,7 @@ union xt_policy_addr {
 
 struct xt_policy_elem {
 	union {
-#ifdef __KERNEL__
+#ifdef __KERNEL__ // DISINTEGRATE: RETAIN
 		struct {
 			union nf_inet_addr saddr;
 			union nf_inet_addr smask;
