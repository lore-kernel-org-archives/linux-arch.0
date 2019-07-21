Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36069 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfGUVw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jul 2019 17:52:59 -0400
Date: Mon, 22 Jul 2019 00:52:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] unaligned: delete 1-byte accessors
Message-ID: <20190721215253.GA18177@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, axboe@kernel.dk, kvalo@codeaurora.org, john.johansen@canonical.com, linux-arch@vger.kernel.org
Message-ID: <20190721215253.zFz-PAX4ytFRKVWooOybSd6GVuQRJJCcM9CWM5IKKvY@z>

Each and every 1-byte access is aligned!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	There may be more unaligned stuff in arch/.

 block/partitions/ldm.h                      |    2 +-
 block/partitions/msdos.c                    |    2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c |    2 +-
 include/linux/unaligned/generic.h           |   12 ++----------
 net/core/netpoll.c                          |    4 ++--
 security/apparmor/policy_unpack.c           |    2 +-
 6 files changed, 8 insertions(+), 16 deletions(-)

--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -85,7 +85,7 @@ struct parsed_partitions;
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
+#define SYS_IND(p)		((p)->sys_ind)
 
 struct frag {				/* VBLK Fragment handling */
 	struct list_head list;
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -33,7 +33,7 @@
  */
 #include <asm/unaligned.h>
 
-#define SYS_IND(p)	get_unaligned(&p->sys_ind)
+#define SYS_IND(p)	((p)->sys_ind)
 
 static inline sector_t nr_sects(struct partition *p)
 {
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -1090,7 +1090,7 @@ static int mwifiex_pcie_alloc_sleep_cookie_buf(struct mwifiex_adapter *adapter)
 
 	mwifiex_dbg(adapter, INFO,
 		    "alloc_scook: sleep cookie=0x%x\n",
-		    get_unaligned(card->sleep_cookie_vbase));
+		    *card->sleep_cookie_vbase);
 
 	return 0;
 }
--- a/include/linux/unaligned/generic.h
+++ b/include/linux/unaligned/generic.h
@@ -9,27 +9,22 @@
 extern void __bad_unaligned_access_size(void);
 
 #define __get_unaligned_le(ptr) ((__force typeof(*(ptr)))({			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
 	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_le16((ptr)),	\
 	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),	\
 	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),	\
-	__bad_unaligned_access_size()))));					\
+	__bad_unaligned_access_size())));					\
 	}))
 
 #define __get_unaligned_be(ptr) ((__force typeof(*(ptr)))({			\
-	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
 	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_be16((ptr)),	\
 	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_be32((ptr)),	\
 	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_be64((ptr)),	\
-	__bad_unaligned_access_size()))));					\
+	__bad_unaligned_access_size())));					\
 	}))
 
 #define __put_unaligned_le(val, ptr) ({					\
 	void *__gu_p = (ptr);						\
 	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(u8 *)__gu_p = (__force u8)(val);			\
-		break;							\
 	case 2:								\
 		put_unaligned_le16((__force u16)(val), __gu_p);		\
 		break;							\
@@ -48,9 +43,6 @@ extern void __bad_unaligned_access_size(void);
 #define __put_unaligned_be(val, ptr) ({					\
 	void *__gu_p = (ptr);						\
 	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(u8 *)__gu_p = (__force u8)(val);			\
-		break;							\
 	case 2:								\
 		put_unaligned_be16((__force u16)(val), __gu_p);		\
 		break;							\
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -408,7 +408,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		ip6h = ipv6_hdr(skb);
 
 		/* ip6h->version = 6; ip6h->priority = 0; */
-		put_unaligned(0x60, (unsigned char *)ip6h);
+		*(unsigned char *)ip6h = 0x60;
 		ip6h->flow_lbl[0] = 0;
 		ip6h->flow_lbl[1] = 0;
 		ip6h->flow_lbl[2] = 0;
@@ -436,7 +436,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		iph = ip_hdr(skb);
 
 		/* iph->version = 4; iph->ihl = 5; */
-		put_unaligned(0x45, (unsigned char *)iph);
+		*(unsigned char *)iph = 0x45;
 		iph->tos      = 0;
 		put_unaligned(htons(ip_len), &(iph->tot_len));
 		iph->id       = htons(atomic_inc_return(&ip_ident));
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -301,7 +301,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
 		if (!inbounds(e, sizeof(u8)))
 			goto fail;
 		if (data)
-			*data = get_unaligned((u8 *)e->pos);
+			*data = *(u8 *)e->pos;
 		e->pos += sizeof(u8);
 		return 1;
 	}
