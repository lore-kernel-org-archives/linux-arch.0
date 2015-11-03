From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 19/28] lkl tools: host lib: virtio block device
Date: Tue,  3 Nov 2015 22:20:50 +0200
Message-ID: <1446582059-17355-20-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Host independent implementation for virtio block devices. The host
dependent part of the host library must provide an implementation for
lkl_dev_block_ops.

Disks can be added to the LKL configuration via lkl_disk_add(), a new
LKL application API.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/include/lkl.h      |  20 ++++++++
 tools/lkl/include/lkl_host.h |  21 ++++++++
 tools/lkl/lib/virtio_blk.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 tools/lkl/lib/virtio_blk.c

diff --git a/tools/lkl/include/lkl.h b/tools/lkl/include/lkl.h
index 958614d..0c30b23 100644
--- a/tools/lkl/include/lkl.h
+++ b/tools/lkl/include/lkl.h
@@ -20,4 +20,24 @@ static inline long lkl_sys_lseek(unsigned int fd, __lkl__kernel_loff_t off,
  */
 const char *lkl_strerror(int err);
 
+/**
+ * lkl_disk_backstore - host dependend disk backstore
+ *
+ * @fd - an open file descriptor that can be used by preadv/pwritev; used by
+ * POSIX hosts
+ */
+union lkl_disk_backstore {
+	int fd;
+};
+
+/**
+ * lkl_disk_add - add a new disk
+ *
+ * Must be called before calling lkl_start_kernel.
+ *
+ * @backstore - the disk backstore
+ * @returns a disk id (0 is valid) or a strictly negative value in case of error
+ */
+int lkl_disk_add(union lkl_disk_backstore backstore);
+
 #endif
diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 26d3e43..2dafaa8 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -20,4 +20,25 @@ struct lkl_dev_buf {
 	unsigned int len;
 };
 
+extern struct lkl_dev_blk_ops lkl_dev_blk_ops;
+
+#define LKL_DEV_BLK_TYPE_READ		0
+#define LKL_DEV_BLK_TYPE_WRITE		1
+#define LKL_DEV_BLK_TYPE_FLUSH		4
+#define LKL_DEV_BLK_TYPE_FLUSH_OUT	5
+
+struct lkl_dev_blk_ops {
+	int (*get_capacity)(union lkl_disk_backstore bs,
+			    unsigned long long *res);
+	void (*request)(union lkl_disk_backstore bs, unsigned int type,
+			unsigned int prio, unsigned long long sector,
+			struct lkl_dev_buf *bufs, int count);
+};
+
+#define LKL_DEV_BLK_STATUS_OK		0
+#define LKL_DEV_BLK_STATUS_IOERR	1
+#define LKL_DEV_BLK_STATUS_UNSUP	2
+
+void lkl_dev_blk_complete(struct lkl_dev_buf *bufs, unsigned char status,
+			  int len);
 #endif
diff --git a/tools/lkl/lib/virtio_blk.c b/tools/lkl/lib/virtio_blk.c
new file mode 100644
index 0000000..3262f42
--- /dev/null
+++ b/tools/lkl/lib/virtio_blk.c
@@ -0,0 +1,116 @@
+#include <lkl_host.h>
+#include "virtio.h"
+
+struct virtio_blk_dev {
+	struct virtio_dev dev;
+	struct {
+		uint64_t capacity;
+	} config;
+	struct lkl_dev_blk_ops *ops;
+	union lkl_disk_backstore backstore;
+};
+
+struct virtio_blk_req_header {
+	uint32_t type;
+	uint32_t prio;
+	uint64_t sector;
+};
+
+struct virtio_blk_req_trailer {
+	uint8_t status;
+};
+
+static int blk_check_features(uint32_t features)
+{
+	if (!features)
+		return 0;
+
+	return -LKL_EINVAL;
+}
+
+void lkl_dev_blk_complete(struct lkl_dev_buf *bufs, unsigned char status,
+			  int len)
+{
+	struct virtio_dev_req *req;
+	struct virtio_blk_req_trailer *f;
+
+	req = container_of(bufs - 1, struct virtio_dev_req, buf);
+
+	if (req->buf_count < 2) {
+		lkl_printf("virtio_blk: no status buf\n");
+		return;
+	}
+
+	if (req->buf[req->buf_count - 1].len != sizeof(*f)) {
+		lkl_printf("virtio_blk: bad status buf\n");
+	} else {
+		f = req->buf[req->buf_count - 1].addr;
+		f->status = status;
+	}
+
+	virtio_dev_complete(req, len);
+}
+
+static void blk_queue(struct virtio_dev *dev, struct virtio_dev_req *req)
+{
+	struct virtio_blk_req_header *h;
+	struct virtio_blk_dev *blk_dev;
+
+	if (req->buf[0].len != sizeof(struct virtio_blk_req_header)) {
+		lkl_printf("virtio_blk: bad header buf\n");
+		lkl_dev_blk_complete(&req->buf[1], LKL_DEV_BLK_STATUS_UNSUP, 0);
+		return;
+	}
+
+	h = req->buf[0].addr;
+	blk_dev = container_of(dev, struct virtio_blk_dev, dev);
+
+	blk_dev->ops->request(blk_dev->backstore, le32toh(h->type),
+			      le32toh(h->prio), le32toh(h->sector),
+			      &req->buf[1], req->buf_count - 2);
+}
+
+static struct virtio_dev_ops blk_ops = {
+	.check_features = blk_check_features,
+	.queue = blk_queue,
+};
+
+int lkl_disk_add(union lkl_disk_backstore backstore)
+{
+	struct virtio_blk_dev *dev;
+	unsigned long long capacity;
+	int ret;
+	static int count;
+
+	dev = lkl_host_ops.mem_alloc(sizeof(*dev));
+	if (!dev)
+		return -LKL_ENOMEM;
+
+	dev->dev.device_id = 2;
+	dev->dev.vendor_id = 0;
+	dev->dev.device_features = 0;
+	dev->dev.config_gen = 0;
+	dev->dev.config_data = &dev->config;
+	dev->dev.config_len = sizeof(dev->config);
+	dev->dev.ops = &blk_ops;
+	dev->ops = &lkl_dev_blk_ops;
+	dev->backstore = backstore;
+
+	ret = dev->ops->get_capacity(backstore, &capacity);
+	if (ret) {
+		ret = -LKL_ENOMEM;
+		goto out_free;
+	}
+	dev->config.capacity = capacity;
+
+	ret = virtio_dev_setup(&dev->dev, 1, 65536);
+	if (ret)
+		goto out_free;
+
+	return count++;
+
+out_free:
+	lkl_host_ops.mem_free(dev);
+
+	return ret;
+}
-- 
2.1.0
