From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 02/18] icmp_push_reply(): reorder adding the checksum up
Date: Tue, 21 Jul 2020 21:25:33 +0100
Message-ID: <20200721202549.4150745-2-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgGUUZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:51 -0400
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

do csum_partial_copy_nocheck() on the first fragment, then
add the rest to it.  Equivalent transformation.

That was the only caller of csum_partial_copy_nocheck() that
might pass it non-zero as the last argument.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/ipv4/icmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 62d7a2bfc9a3..f93317157549 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -376,15 +376,15 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 		ip_flush_pending_frames(sk);
 	} else if ((skb = skb_peek(&sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = icmp_hdr(skb);
-		__wsum csum = 0;
+		__wsum csum;
 		struct sk_buff *skb1;
 
+		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
+						 (char *)icmph,
+						 icmp_param->head_len, 0);
 		skb_queue_walk(&sk->sk_write_queue, skb1) {
 			csum = csum_add(csum, skb1->csum);
 		}
-		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
-						 (char *)icmph,
-						 icmp_param->head_len, csum);
 		icmph->checksum = csum_fold(csum);
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(sk, fl4);
-- 
2.11.0
