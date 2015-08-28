From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/9] hifn_795x: stop including <asm-generic/kmap_types.h>
Date: Fri, 28 Aug 2015 09:27:18 +0200
Message-ID: <1440746842-19029-6-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

<linux/highmem.h> is the placace the get the kmap type flags, asm-generic
files are generic implementations only to be used by architecture code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/crypto/hifn_795x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index 8d2a772..ca5c71a 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -36,8 +36,6 @@
 #include <crypto/algapi.h>
 #include <crypto/des.h>
 
-#include <asm/kmap_types.h>
-
 //#define HIFN_DEBUG
 
 #ifdef HIFN_DEBUG
-- 
1.9.1
