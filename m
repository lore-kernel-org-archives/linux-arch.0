From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 11/11] asm-generic: numa: Remove the unused parent_node() macro
Date: Wed, 26 Jul 2017 21:34:36 +0800
Message-ID: <1501076076-1974-12-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, Dou Liyang <douly.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
