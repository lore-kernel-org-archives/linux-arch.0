Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41089 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbdIAC4w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2017 22:56:52 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2 7/7] asm-generic: numa: Remove the unused parent_node() macro
Date: Fri, 1 Sep 2017 10:56:39 +0800
Message-ID: <1504234599-29533-8-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20170901025639.-USPo1LvmUn-laNw1JJX3QoQW3OzjsI-EwZvmXi-rNs@z>

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
index 5d2add1..2388737 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -44,9 +44,6 @@
 #define cpu_to_mem(cpu)		((void)(cpu),0)
 #endif
 
-#ifndef parent_node
-#define parent_node(node)	((void)(node),0)
-#endif
 #ifndef cpumask_of_node
   #ifdef CONFIG_NEED_MULTIPLE_NODES
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
-- 
2.5.5
