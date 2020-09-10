Return-Path: <SRS0=3HFy=CT=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50546C2D0A7
	for <linux-arch@archiver.kernel.org>; Thu, 10 Sep 2020 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D7D20809
	for <linux-arch@archiver.kernel.org>; Thu, 10 Sep 2020 09:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIJJLi (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:11:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbgIJJLb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 05:11:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8D79DF8AE19BE641BC5F;
        Thu, 10 Sep 2020 17:11:26 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 17:11:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <arnd@arndb.de>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] locking/atomic/bitops: Fix some wrong param names in comments
Date:   Thu, 10 Sep 2020 05:10:04 -0400
Message-ID: <20200910091004.8921-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Correct the wrong param name @addr to @p.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/asm-generic/bitops/lock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 3ae021368f48..cdd4fde2dacc 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -9,7 +9,7 @@
 /**
  * test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
- * @addr: Address to count from
+ * @p: Address to count from
  *
  * This operation is atomic and provides acquire barrier semantics if
  * the returned value is 0.
@@ -33,7 +33,7 @@ static inline int test_and_set_bit_lock(unsigned int nr,
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
- * @addr: the address to start counting from
+ * @p: the address to start counting from
  *
  * This operation is atomic and provides release barrier semantics.
  */
@@ -46,7 +46,7 @@ static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 /**
  * __clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
- * @addr: the address to start counting from
+ * @p: the address to start counting from
  *
  * A weaker form of clear_bit_unlock() as used by __bit_lock_unlock(). If all
  * the bits in the word are protected by this lock some archs can use weaker
@@ -69,7 +69,7 @@ static inline void __clear_bit_unlock(unsigned int nr,
  * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bottom
  *                                     byte is negative, for unlock.
  * @nr: the bit to clear
- * @addr: the address to start counting from
+ * @p: the address to start counting from
  *
  * This is a bit of a one-trick-pony for the filemap code, which clears
  * PG_locked and tests PG_waiters,
-- 
2.19.1

