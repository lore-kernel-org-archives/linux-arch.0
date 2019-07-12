Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42125 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLTXv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 15:23:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so7243860qkm.9
        for <linux-arch@vger.kernel.org>; Fri, 12 Jul 2019 12:23:50 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] be2net: fix adapter->big_page_size miscaculation
Date: Fri, 12 Jul 2019 15:23:21 -0400
Message-ID: <1562959401-19815-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davem@davemloft.net
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Message-ID: <20190712192321.iVsX8IqbzD4Q4HzmAq7T9kmCZ5KPmWL--UIrROrdOwk@z>

The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
problem for the be2net driver as "rx_frag_size" could be a module
parameter that can be changed while loading the module. That commit
checks __builtin_constant_p() first in get_order() which cause
"adapter->big_page_size" to be assigned a value based on the
the default "rx_frag_size" value at the compilation time. It also
generate a compilation warning,

In file included from ./arch/powerpc/include/asm/page_64.h:107,
                 from ./arch/powerpc/include/asm/page.h:242,
                 from ./arch/powerpc/include/asm/mmu.h:132,
                 from ./arch/powerpc/include/asm/lppaca.h:47,
                 from ./arch/powerpc/include/asm/paca.h:17,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./arch/powerpc/include/asm/processor.h:39,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
drivers/net/ethernet/emulex/benet/be_main.c: In function
'be_rx_cqs_create':
./include/asm-generic/getorder.h:54:9: warning: comparison is always
true due to limited range of data type [-Wtype-limits]
   (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
         ^
drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
of macro 'get_order'
  adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
                                 ^~~~~~~~~

Fix it by using __get_order() instead which will calculate in runtime.

Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 82015c8a5ed7..db13e714df7c 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3135,7 +3135,7 @@ static int be_rx_cqs_create(struct be_adapter *adapter)
 	if (adapter->num_rx_qs == 0)
 		adapter->num_rx_qs = 1;
 
-	adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
+	adapter->big_page_size = (1 << __get_order(rx_frag_size)) * PAGE_SIZE;
 	for_all_rx_queues(adapter, rxo, i) {
 		rxo->adapter = adapter;
 		cq = &rxo->cq;
-- 
1.8.3.1
