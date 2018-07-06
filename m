Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:39275 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933714AbeGFRPP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 13:15:15 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] devres: Really align data field to unsigned long long
Date: Fri,  6 Jul 2018 20:15:04 +0300
Message-ID: <20180706171504.10265-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, stable@vger.kernel.org
Message-ID: <20180706171504.hAOpyFUgJ_cNukbVSnha70qb2bXbjGz6pZkmcxWryGY@z>

It looks like on most of architectures "data" member of devres struture
gets aligned to 8-byte "unsigned long long" boundary as one may expect:
if we don't explicitly pack a structure then natural alignment
(which matches each member data type) is used.

But at least on 32-bit ARC architecture ABI requires "long long" types
to be aligned by normal 32-bit word. This makes "data" field aligned to
12 bytes. This is still OK as long as we use 32-bit data only.

But once we want to use native atomic64_t type (i.e. when we use special
instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
misaligned access exception.

That's because even on CPUs capable of non-aligned data access LL/SC
instructions require strict alignment.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: stable@vger.kernel.org
---
 drivers/base/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..35ddc8b66bc9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -25,7 +25,7 @@ struct devres_node {
 struct devres {
 	struct devres_node		node;
 	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	unsigned long long		data[] __aligned(sizeof(unsigned long long));
 };
 
 struct devres_group {
-- 
2.17.1
