From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH 5/6] reservation: add support for fences to enable
	cross-device synchronisation
Date: Mon, 24 Feb 2014 17:30:04 +0100
Message-ID: <20140224163001.20485.26677.stgit@patser>
References: <20140224162607.20485.70967.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140224162607.20485.70967.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---
 include/linux/reservation.h |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/reservation.h b/include/linux/reservation.h
index 813dae960ebd..f3f57460a205 100644
--- a/include/linux/reservation.h
+++ b/include/linux/reservation.h
@@ -6,7 +6,7 @@
  * Copyright (C) 2012 Texas Instruments
  *
  * Authors:
- * Rob Clark <rob.clark@linaro.org>
+ * Rob Clark <robdclark@gmail.com>
  * Maarten Lankhorst <maarten.lankhorst@canonical.com>
  * Thomas Hellstrom <thellstrom-at-vmware-dot-com>
  *
@@ -40,22 +40,40 @@
 #define _LINUX_RESERVATION_H
 
 #include <linux/ww_mutex.h>
+#include <linux/fence.h>
+#include <linux/slab.h>
 
 extern struct ww_class reservation_ww_class;
 
 struct reservation_object {
 	struct ww_mutex lock;
+
+	struct fence *fence_excl;
+	struct fence **fence_shared;
+	u32 fence_shared_count, fence_shared_max;
 };
 
 static inline void
 reservation_object_init(struct reservation_object *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
+
+	obj->fence_shared_count = obj->fence_shared_max = 0;
+	obj->fence_shared = NULL;
+	obj->fence_excl = NULL;
 }
 
 static inline void
 reservation_object_fini(struct reservation_object *obj)
 {
+	int i;
+
+	if (obj->fence_excl)
+		fence_put(obj->fence_excl);
+	for (i = 0; i < obj->fence_shared_count; ++i)
+		fence_put(obj->fence_shared[i]);
+	kfree(obj->fence_shared);
+
 	ww_mutex_destroy(&obj->lock);
 }
