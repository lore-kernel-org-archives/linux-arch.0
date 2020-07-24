From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2 03/20] icmp_push_reply(): reorder adding the checksum up
Date: Fri, 24 Jul 2020 02:25:29 +0100
Message-ID: <20200724012546.302155-3-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
