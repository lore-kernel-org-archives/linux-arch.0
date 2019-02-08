Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46419 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfBHGDA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 01:03:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so2667392qtm.13
        for <linux-arch@vger.kernel.org>; Thu, 07 Feb 2019 22:03:00 -0800 (PST)
Date: Fri, 8 Feb 2019 01:02:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] drm: tweak header name
Message-ID: <20190124142448.23243-4-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Message-ID: <20190208060258.FOBoXq3XwOnlmgzQgfpcwJIVsSA7DT6JHDMY0VCaE38@z>

Use linux/mman.h to make sure we get all mmap flags we need.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/drm/drmP.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index bdb0d5548f39..a3184416ddc5 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -57,8 +57,7 @@
 #include <linux/workqueue.h>
 #include <linux/dma-fence.h>
 #include <linux/module.h>
-
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 
-- 
MST
