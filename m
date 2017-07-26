Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:39238 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751596AbdGZNfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2017 09:35:04 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 11/11] asm-generic: numa: Remove the unused parent_node() macro
Date: Wed, 26 Jul 2017 21:34:36 +0800
Message-ID: <1501076076-1974-12-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, Dou Liyang <douly.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20170726133436.bUEzS9_8rOE-Uk7mIgKePg5XETBoJNXeWvf9P9iknAE@z>

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macro in generic situation is unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/topology.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index fc824e2..a91d842 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -44,9 +44,6 @@
 #define cpu_to_mem(cpu)		((void)(cpu),0)
 #endif
 
-#ifndef parent_node
-#define parent_node(node)	((void)(node),0)
-#endif
 #ifndef cpumask_of_node
 #define cpumask_of_node(node)	((void)node, cpu_online_mask)
 #endif
-- 
2.5.5
