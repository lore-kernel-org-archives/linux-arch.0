Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.179]:37673 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759088AbYDNQiK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 12:38:10 -0400
Received: by el-out-1112.google.com with SMTP id n30so59361elf.21
        for <linux-arch@vger.kernel.org>; Mon, 14 Apr 2008 09:38:08 -0700 (PDT)
Subject: [PATCH 02/10] hid-core:  Use get_unaligned_* helpers
From: Harvey Harrison <harvey.harrison@gmail.com>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 09:37:54 -0700
Message-ID: <1208191074.5721.24.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080414163754.d7Eng12sHvxS4-Y1fshWRds5JZR9ULeB6O_y1HjMfWM@z>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/hid/hid-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f0b00ec..d76fec3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -606,7 +606,7 @@ static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 		case 2:
 			if ((end - start) < 2)
 				return NULL;
-			item->data.u16 = le16_to_cpu(get_unaligned((__le16*)start));
+			item->data.u16 = get_unaligned_le16(start);
 			start = (__u8 *)((__le16 *)start + 1);
 			return start;
 
@@ -614,7 +614,7 @@ static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 			item->size++;
 			if ((end - start) < 4)
 				return NULL;
-			item->data.u32 = le32_to_cpu(get_unaligned((__le32*)start));
+			item->data.u32 = get_unaligned_le32(start);
 			start = (__u8 *)((__le32 *)start + 1);
 			return start;
 	}
@@ -765,7 +765,7 @@ static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
 
 	report += offset >> 3;  /* adjust byte index */
 	offset &= 7;            /* now only need bit offset into one byte */
-	x = le64_to_cpu(get_unaligned((__le64 *) report));
+	x = get_unaligned_le64(report);
 	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
 	return (u32) x;
 }
-- 
1.5.5.144.g3e42


