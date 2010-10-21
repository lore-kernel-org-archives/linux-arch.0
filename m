Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62035 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0JUOnr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2010 10:43:47 -0400
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 08/22] rds: stop including asm-generic/bitops/le.h
Date: Thu, 21 Oct 2010 23:41:03 +0900
Message-ID: <1287672077-5797-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Andy Grover <andy.grover@oracle.com>, rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20101021144103.VaGO0VqLfiqJWb11CwETIiVi_tucF8G48FLV3MSJvjM@z>

No need to include asm-generic/bitops/le.h as all architectures
provide little-endian bit operations now.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andy Grover <andy.grover@oracle.com>
Cc: rds-devel@oss.oracle.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
---
No change from previous submission

 net/rds/cong.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/rds/cong.c b/net/rds/cong.c
index c6784d5..15a65f0 100644
--- a/net/rds/cong.c
+++ b/net/rds/cong.c
@@ -34,8 +34,6 @@
 #include <linux/types.h>
 #include <linux/rbtree.h>
 
-#include <asm-generic/bitops/le.h>
-
 #include "rds.h"
 
 /*
-- 
1.7.1.231.gd0b16

