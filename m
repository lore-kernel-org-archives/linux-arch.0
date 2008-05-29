From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 36/37] decnet: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:14 -0700
Message-ID: <1212092354.28403.138.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:42423 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbYE2UTP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083607wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:15 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 net/decnet/af_decnet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index fc2efe8..c20d98c 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1129,8 +1129,8 @@ static int dn_accept(struct socket *sock, struct socket *newsock, int flags)
 
 	skb_pull(skb, dn_username2sockaddr(skb->data, skb->len, &(DN_SK(newsk)->addr), &type));
 	skb_pull(skb, dn_username2sockaddr(skb->data, skb->len, &(DN_SK(newsk)->peer), &type));
-	*(__le16 *)(DN_SK(newsk)->peer.sdn_add.a_addr) = cb->src;
-	*(__le16 *)(DN_SK(newsk)->addr.sdn_add.a_addr) = cb->dst;
+	put_le16(cb->src, (__le16 *)(DN_SK(newsk)->peer.sdn_add.a_addr));
+	put_le16(cb->dst, (__le16 *)(DN_SK(newsk)->addr.sdn_add.a_addr));
 
 	menuver = *skb->data;
 	skb_pull(skb, 1);
-- 
1.5.6.rc0.277.g804cf
