Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57002 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab0KWNju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2010 08:39:50 -0500
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 08/22] rds: stop including asm-generic/bitops/le.h
Date: Tue, 23 Nov 2010 22:38:10 +0900
Message-ID: <1290519504-3958-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
References: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Andy Grover <andy.grover@oracle.com>, rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <20101123133810.dkBMQVNWP_xYq2r0az_roRmkuXn9qZhmXK-DkcJsNa0@z>

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
index 90ca44f..fa578d3 100644
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
1.7.3.2

