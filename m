From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/9] amdkfd: use <linux/mman.h> instead of <uapi/asm-generic/mman-common.h>
Date: Fri, 28 Aug 2015 09:27:16 +0200
Message-ID: <1440746842-19029-4-git-send-email-hch@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33391 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbbH1Har (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2015 03:30:47 -0400
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

The latter is a default version of <asm/mman.h> and not for driver use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index c991973..c6a1b4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -31,7 +31,7 @@
 #include <uapi/linux/kfd_ioctl.h>
 #include <linux/time.h>
 #include <linux/mm.h>
-#include <uapi/asm-generic/mman-common.h>
+#include <linux/mman.h>
 #include <asm/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 35b9875..2b65510 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -33,7 +33,7 @@
 #include <linux/time.h>
 #include "kfd_priv.h"
 #include <linux/mm.h>
-#include <uapi/asm-generic/mman-common.h>
+#include <linux/mman.h>
 #include <asm/processor.h>
 
 /*
-- 
1.9.1
