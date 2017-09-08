From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] openrisc: add forward declaration for struct vm_area_struct
Date: Fri,  8 Sep 2017 10:25:08 +0200
Message-ID: <20170908082508.14325-1-tklauser@distanz.ch>
References: <201709080345.bk1IOlp7%fengguang.wu@intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:49958 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754774AbdIHIZL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Sep 2017 04:25:11 -0400
In-Reply-To: <201709080345.bk1IOlp7%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, openrisc@lists.librecores.org, linux-arch@vger.kernel.org, kbuild-all@01.org, kbuild test robot <lkp@intel.com>

After removing linux/vmalloc.h from asm-generic/io.h, the following
warning occurs on openrisc:

   In file included from arch/openrisc/include/asm/io.h:33:0,
                    from include/linux/io.h:25,
                    from drivers/tty/serial/earlycon.c:19:
   arch/openrisc/include/asm/pgtable.h:424:2: warning: 'struct vm_area_struct' declared inside parameter list
     unsigned long address, pte_t *pte)
     ^
   arch/openrisc/include/asm/pgtable.h:424:2: warning: its scope is only this definition or declaration, which is probably not what you want

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/openrisc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index ff97374ca069..71a6f08de8f2 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -414,6 +414,8 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD]; /* defined in head.S */
 
+struct vm_area_struct;
+
 /*
  * or32 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
-- 
2.13.0
