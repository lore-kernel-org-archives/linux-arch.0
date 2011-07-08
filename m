From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 20/39] UAPI: Fix up linux/netfilter/xt_policy.h
Date: Fri, 08 Jul 2011 15:26:12 +0100
Message-ID: <20110708142612.31344.15209.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51465 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GHO0x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:53 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

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
