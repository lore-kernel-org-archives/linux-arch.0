From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Fri, 05 Jan 2018 17:11:10 -0800
Message-ID: <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57189 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753938AbeAFBTY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 20:19:24 -0500
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

Static analysis reports that 'offset' may be a user controlled value
that is used as a data dependency reading from a raw_frag_vec buffer.
In order to avoid potential leaks of kernel memory values, block
speculative execution of the instruction stream that could issue further
reads based on an invalid '*(rfv->c + offset)' value.

Based on an original patch by Elena Reshetova.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 net/ipv4/raw.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 125c1eab3eaa..f72b20131a15 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -57,6 +57,7 @@
 #include <linux/in_route.h>
 #include <linux/route.h>
 #include <linux/skbuff.h>
+#include <linux/compiler.h>
 #include <linux/igmp.h>
 #include <net/net_namespace.h>
 #include <net/dst.h>
@@ -472,17 +473,17 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
 		       struct sk_buff *skb)
 {
 	struct raw_frag_vec *rfv = from;
+	char *rfv_buf;
 
-	if (offset < rfv->hlen) {
+	if ((rfv_buf = nospec_array_ptr(rfv->hdr.c, offset, rfv->hlen))) {
 		int copy = min(rfv->hlen - offset, len);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
-			memcpy(to, rfv->hdr.c + offset, copy);
+			memcpy(to, rfv_buf, copy);
 		else
 			skb->csum = csum_block_add(
 				skb->csum,
-				csum_partial_copy_nocheck(rfv->hdr.c + offset,
-							  to, copy, 0),
+				csum_partial_copy_nocheck(rfv_buf, to, copy, 0),
 				odd);
 
 		odd = 0;
