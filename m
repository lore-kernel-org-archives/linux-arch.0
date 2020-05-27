From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpumask: guard cpumask_of_node() macro argument
Date: Wed, 27 May 2020 15:46:08 +0200
Message-ID: <20200527134623.930247-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:38093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgE0NrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 May 2020 09:47:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, Guenter Roeck <linux@roeck-us.net>, Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

drivers/hwmon/amd_energy.c:195:15: error: invalid operands to binary expression ('void' and 'int')
                                        (channel - data->nr_cpus));
                                        ~~~~~~~~~^~~~~~~~~~~~~~~~~
include/asm-generic/topology.h:51:42: note: expanded from macro 'cpumask_of_node'
    #define cpumask_of_node(node)       ((void)node, cpu_online_mask)
                                               ^~~~
include/linux/cpumask.h:618:72: note: expanded from macro 'cpumask_first_and'
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                       ^~~~~

Fixes: f0b848ce6fe9 ("cpumask: Introduce cpumask_of_{node,pcibus} to replace {node,pcibus}_to_cpumask")
Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 238873739550..5aa8705df87e 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -48,7 +48,7 @@
   #ifdef CONFIG_NEED_MULTIPLE_NODES
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
   #else
-    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
+    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
   #endif
 #endif
 #ifndef pcibus_to_node
-- 
2.26.2
