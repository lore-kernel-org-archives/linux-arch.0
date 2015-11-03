From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 18/28] lkl tools: host lib: virtio devices
Date: Tue,  3 Nov 2015 22:20:49 +0200
Message-ID: <1446582059-17355-19-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Add helpers for implementing host virtio devices. It uses the memory
mapped I/O helpers to interact with the Linux MMIO virtio transport
driver and offers support to setup and add a new virtio device,
dispatch requests from the incoming queues as well as support for
completing requests.

All added virtio devices are stored in lkl_virtio_devs as strings, per
the Linux MMIO virtio transport driver command line specification.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 tools/lkl/include/lkl_host.h |   7 +
 tools/lkl/lib/virtio.c       | 365 +++++++++++++++++++++++++++++++++++++++++++
 tools/lkl/lib/virtio.h       |  86 ++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 tools/lkl/lib/virtio.c
 create mode 100644 tools/lkl/lib/virtio.h

diff --git a/tools/lkl/include/lkl_host.h b/tools/lkl/include/lkl_host.h
index 9f1c270..26d3e43 100644
--- a/tools/lkl/include/lkl_host.h
+++ b/tools/lkl/include/lkl_host.h
@@ -13,4 +13,11 @@ extern struct lkl_host_operations lkl_host_ops;
  */
 int lkl_printf(const char *fmt, ...);
 
+char lkl_virtio_devs[256];
+
+struct lkl_dev_buf {
+	void *addr;
+	unsigned int len;
+};
+
 #endif
diff --git a/tools/lkl/lib/virtio.c b/tools/lkl/lib/virtio.c
new file mode 100644
index 0000000..034152e
--- /dev/null
+++ b/tools/lkl/lib/virtio.c
@@ -0,0 +1,365 @@
+#include <string.h>
+#include <stdio.h>
+#include <lkl_host.h>
+#include "iomem.h"
+#include "virtio.h"
+
+#define VIRTIO_DEV_MAGIC		0x74726976
+#define VIRTIO_DEV_VERSION		2
+
+#define VIRTIO_MMIO_MAGIC_VALUE		0x000
+#define VIRTIO_MMIO_VERSION		0x004
+#define VIRTIO_MMIO_DEVICE_ID		0x008
+#define VIRTIO_MMIO_VENDOR_ID		0x00c
+#define VIRTIO_MMIO_DEVICE_FEATURES	0x010
+#define VIRTIO_MMIO_DEVICE_FEATURES_SEL 0x014
+#define VIRTIO_MMIO_DRIVER_FEATURES	0x020
+#define VIRTIO_MMIO_DRIVER_FEATURES_SEL 0x024
+#define VIRTIO_MMIO_QUEUE_SEL		0x030
+#define VIRTIO_MMIO_QUEUE_NUM_MAX	0x034
+#define VIRTIO_MMIO_QUEUE_NUM		0x038
+#define VIRTIO_MMIO_QUEUE_READY		0x044
+#define VIRTIO_MMIO_QUEUE_NOTIFY	0x050
+#define VIRTIO_MMIO_INTERRUPT_STATUS	0x060
+#define VIRTIO_MMIO_INTERRUPT_ACK	0x064
+#define VIRTIO_MMIO_STATUS		0x070
+#define VIRTIO_MMIO_QUEUE_DESC_LOW	0x080
+#define VIRTIO_MMIO_QUEUE_DESC_HIGH	0x084
+#define VIRTIO_MMIO_QUEUE_AVAIL_LOW	0x090
+#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH	0x094
+#define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
+#define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
+#define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
+#define VIRTIO_MMIO_CONFIG		0x100
+#define VIRTIO_MMIO_INT_VRING		0x01
+#define VIRTIO_MMIO_INT_CONFIG		0x02
+
+#define VIRTIO_DEV_STATUS_ACK		0x01
+#define VIRTIO_DEV_STATUS_DRV		0x02
+#define VIRTIO_DEV_STATUS_FEATURES_OK	0x08
+#define VIRTIO_DEV_STATUS_DRV_OK	0x04
+#define VIRTIO_DEV_STATUS_FAILED	0x80
+
+#define VIRTIO_F_VERSION_1		(1ULL << 32)
+#define VIRTIO_RING_F_EVENT_IDX		(1ULL << 29)
+#define VIRTIO_DESC_F_NEXT		1
+
+static inline uint16_t virtio_get_used_event(struct virtio_queue *q)
+{
+	return q->avail->ring[q->num];
+}
+
+static inline void virtio_set_avail_event(struct virtio_queue *q, uint16_t val)
+{
+	*((uint16_t *)&q->used->ring[q->num]) = val;
+}
+
+#define ring_entry(q, r, idx) \
+	q->r->ring[idx & (q->num - 1)]
+
+static inline void virtio_deliver_irq(struct virtio_dev *dev)
+{
+	dev->int_status |= VIRTIO_MMIO_INT_VRING;
+	lkl_trigger_irq(dev->irq, NULL);
+}
+
+void virtio_dev_complete(struct virtio_dev_req *req, uint32_t len)
+{
+	struct virtio_queue *q = req->q;
+	struct virtio_dev *dev = req->dev;
+	uint16_t idx = le16toh(q->used->idx) & (q->num - 1);
+	int send_irq = 0;
+
+	q->used->ring[idx].id = htole16(req->desc_idx);
+	q->used->ring[idx].len = htole16(len);
+	if (virtio_get_used_event(q) == q->used->idx)
+		send_irq = 1;
+	q->used->idx = htole16(le16toh(q->used->idx) + 1);
+
+	if (send_irq)
+		virtio_deliver_irq(dev);
+
+	lkl_host_ops.mem_free(req);
+}
+
+static void virtio_process_avail_one(struct virtio_dev *dev,
+				     struct virtio_queue *q,
+				     int avail_idx)
+{
+	int j;
+	uint16_t desc_idx;
+	struct virtio_desc *i;
+	struct virtio_dev_req *req = NULL;
+
+	avail_idx = avail_idx & (q->num - 1);
+	desc_idx = le16toh(q->avail->ring[avail_idx]) & (q->num - 1);
+
+	i = &q->desc[desc_idx];
+	j = 1;
+	while (le16toh(i->flags) & VIRTIO_DESC_F_NEXT) {
+		desc_idx = le16toh(i->next) & (q->num - 1);
+		i = &q->desc[desc_idx];
+		j++;
+	}
+
+	req = lkl_host_ops.mem_alloc((uintptr_t)&req->buf[j]);
+	if (!req)
+		return;
+
+	req->dev = dev;
+	req->q = q;
+	req->desc_idx = q->avail->ring[avail_idx];
+	req->buf_count = j;
+
+	desc_idx = le16toh(q->avail->ring[avail_idx]) & (q->num - 1);
+	i = &q->desc[desc_idx];
+	j = 0;
+	req->buf[j].addr = (void *)(uintptr_t)le64toh(i->addr);
+	req->buf[j].len = le32toh(i->len);
+	while (le16toh(i->flags) & VIRTIO_DESC_F_NEXT) {
+		desc_idx = le16toh(i->next) & (q->num - 1);
+		i = &q->desc[desc_idx];
+		j++;
+		req->buf[j].addr = (void *)(uintptr_t)le64toh(i->addr);
+		req->buf[j].len = le32toh(i->len);
+	}
+
+	dev->ops->queue(dev, req);
+}
+
+static void virtio_process_avail(struct virtio_dev *dev, uint32_t qidx)
+{
+	struct virtio_queue *q = &dev->queue[qidx];
+
+	virtio_set_avail_event(q, q->avail->idx);
+
+	while (q->last_avail_idx != le16toh(q->avail->idx)) {
+		virtio_process_avail_one(dev, q, q->last_avail_idx);
+		q->last_avail_idx++;
+	}
+}
+
+static inline uint32_t virtio_read_device_features(struct virtio_dev *dev)
+{
+	if (dev->device_features_sel)
+		return (uint32_t)(dev->device_features >> 32);
+
+	return (uint32_t)dev->device_features;
+}
+
+static inline void virtio_write_driver_features(struct virtio_dev *dev,
+						uint32_t val)
+{
+	uint64_t tmp;
+
+	if (dev->driver_features_sel) {
+		tmp = dev->driver_features & 0xFFFFFFFF;
+		dev->driver_features = tmp | (uint64_t)val << 32;
+	} else {
+		tmp = dev->driver_features & 0xFFFFFFFF00000000;
+		dev->driver_features = tmp | val;
+	}
+}
+
+static int virtio_read(void *data, int offset, void *res, int size)
+{
+	uint32_t val;
+	struct virtio_dev *dev = (struct virtio_dev *)data;
+	int ret = 0;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+		if (offset + size > dev->config_len)
+			return -LKL_EINVAL;
+		memcpy(res, dev->config_data + offset, size);
+		return 0;
+	}
+
+	if (size != sizeof(uint32_t))
+		return -LKL_EINVAL;
+
+	switch (offset) {
+	case VIRTIO_MMIO_MAGIC_VALUE:
+		val = VIRTIO_DEV_MAGIC;
+		break;
+	case VIRTIO_MMIO_VERSION:
+		val = VIRTIO_DEV_VERSION;
+		break;
+	case VIRTIO_MMIO_DEVICE_ID:
+		val = dev->device_id;
+		break;
+	case VIRTIO_MMIO_VENDOR_ID:
+		val = dev->vendor_id;
+		break;
+	case VIRTIO_MMIO_DEVICE_FEATURES:
+		val = virtio_read_device_features(dev);
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM_MAX:
+		val = dev->queue[dev->queue_sel].num_max;
+		break;
+	case VIRTIO_MMIO_QUEUE_READY:
+		val = dev->queue[dev->queue_sel].ready;
+		break;
+	case VIRTIO_MMIO_INTERRUPT_STATUS:
+		val = dev->int_status;
+		break;
+	case VIRTIO_MMIO_STATUS:
+		val = dev->status;
+		break;
+	case VIRTIO_MMIO_CONFIG_GENERATION:
+		val = dev->config_gen;
+		break;
+	default:
+		ret = -1;
+	}
+
+	*(uint32_t *)res = htole32(val);
+
+	return ret;
+}
+
+static inline void set_ptr_low(void **ptr, uint32_t val)
+{
+	uint64_t tmp = (uintptr_t)*ptr;
+
+	tmp = (tmp & 0xFFFFFFFF00000000) | val;
+	*ptr = (void *)(long)tmp;
+}
+
+static inline void set_ptr_high(void **ptr, uint32_t val)
+{
+	uint64_t tmp = (uintptr_t)*ptr;
+
+	tmp = (tmp & 0x00000000FFFFFFFF) | ((uint64_t)val << 32);
+	*ptr = (void *)(long)tmp;
+}
+
+static int virtio_write(void *data, int offset, void *res, int size)
+{
+	struct virtio_dev *dev = (struct virtio_dev *)data;
+	struct virtio_queue *q = &dev->queue[dev->queue_sel];
+	uint32_t val;
+	int ret = 0;
+
+	if (offset >= VIRTIO_MMIO_CONFIG) {
+		offset -= VIRTIO_MMIO_CONFIG;
+
+		if (offset + size >= dev->config_len)
+			return -LKL_EINVAL;
+		memcpy(dev->config_data + offset, res, size);
+		return 0;
+	}
+
+	if (size != sizeof(uint32_t))
+		return -LKL_EINVAL;
+
+	val = le32toh(*(uint32_t *)res);
+
+	switch (offset) {
+	case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
+		if (val > 1)
+			return -LKL_EINVAL;
+		dev->device_features_sel = val;
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
+		if (val > 1)
+			return -LKL_EINVAL;
+		dev->driver_features_sel = val;
+		break;
+	case VIRTIO_MMIO_DRIVER_FEATURES:
+		virtio_write_driver_features(dev, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_SEL:
+		dev->queue_sel = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_NUM:
+		dev->queue[dev->queue_sel].num = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_READY:
+		dev->queue[dev->queue_sel].ready = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_NOTIFY:
+		virtio_process_avail(dev, val);
+		break;
+	case VIRTIO_MMIO_INTERRUPT_ACK:
+		dev->int_status = 0;
+		break;
+	case VIRTIO_MMIO_STATUS:
+		if (val & VIRTIO_DEV_STATUS_FEATURES_OK &&
+		    (!(dev->driver_features & VIRTIO_F_VERSION_1) ||
+		     !(dev->driver_features & VIRTIO_RING_F_EVENT_IDX) ||
+		     dev->ops->check_features(dev->driver_features & 0xFFFFFF)))
+			val &= ~VIRTIO_DEV_STATUS_FEATURES_OK;
+		dev->status = val;
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_LOW:
+		set_ptr_low((void **)&q->desc, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+		set_ptr_high((void **)&q->desc, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+		set_ptr_low((void **)&q->avail, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+		set_ptr_high((void **)&q->avail, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_LOW:
+		set_ptr_low((void **)&q->used, val);
+		break;
+	case VIRTIO_MMIO_QUEUE_USED_HIGH:
+		set_ptr_high((void **)&q->used, val);
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static const struct lkl_iomem_ops virtio_ops = {
+	.read = virtio_read,
+	.write = virtio_write,
+};
+
+char lkl_virtio_devs[256];
+static char *devs = lkl_virtio_devs;
+
+int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max)
+{
+	int qsize = queues * sizeof(*dev->queue);
+	int ret, avail, mmio_size;
+	int i;
+
+	dev->irq = lkl_get_free_irq("virtio");
+	if (dev->irq < 0)
+		return dev->irq;
+
+	dev->device_features |= VIRTIO_F_VERSION_1 | VIRTIO_RING_F_EVENT_IDX;
+	dev->queue = lkl_host_ops.mem_alloc(qsize);
+	if (!dev->queue)
+		return -LKL_ENOMEM;
+
+	memset(dev->queue, 0, qsize);
+	for (i = 0; i < queues; i++)
+		dev->queue[i].num_max = num_max;
+
+	mmio_size = VIRTIO_MMIO_CONFIG + dev->config_len;
+	ret = register_iomem(dev, mmio_size, &virtio_ops);
+	if (ret)
+		lkl_host_ops.mem_free(dev->queue);
+
+	avail = sizeof(lkl_virtio_devs) - (devs - lkl_virtio_devs);
+	devs += snprintf(devs, avail, " virtio_mmio.device=%d@%p:%d",
+			 mmio_size, dev, dev->irq);
+
+	return ret;
+}
+
+void virtio_dev_cleanup(struct virtio_dev *dev)
+{
+	lkl_put_irq(dev->irq, "virtio");
+	unregister_iomem(dev);
+	lkl_host_ops.mem_free(dev->queue);
+}
+
diff --git a/tools/lkl/lib/virtio.h b/tools/lkl/lib/virtio.h
new file mode 100644
index 0000000..1bacbe6
--- /dev/null
+++ b/tools/lkl/lib/virtio.h
@@ -0,0 +1,86 @@
+#ifndef _LKL_LIB_VIRTIO_H
+#define _LKL_LIB_VIRTIO_H
+
+#include <stdint.h>
+#include <lkl_host.h>
+
+struct virtio_desc {
+	uint64_t addr;
+	uint32_t len;
+	uint16_t flags;
+	uint16_t next;
+};
+
+struct virtio_avail {
+	uint16_t flags;
+	uint16_t idx;
+	uint16_t ring[];
+};
+
+struct virtio_used_elem {
+	uint32_t id;
+	uint32_t len;
+};
+
+struct virtio_used {
+	uint16_t flags;
+	uint16_t idx;
+	struct virtio_used_elem ring[];
+};
+
+struct virtio_queue {
+	uint32_t num_max;
+	uint32_t num;
+	uint32_t ready;
+
+	struct virtio_desc *desc;
+	struct virtio_avail *avail;
+	struct virtio_used *used;
+	uint16_t last_avail_idx;
+	void *config_data;
+	int config_len;
+};
+
+struct virtio_dev_req {
+	struct virtio_dev *dev;
+	struct virtio_queue *q;
+	uint16_t desc_idx;
+	uint16_t buf_count;
+	struct lkl_dev_buf buf[];
+};
+
+struct virtio_dev_ops {
+	int (*check_features)(uint32_t features);
+	void (*queue)(struct virtio_dev *dev, struct virtio_dev_req *req);
+};
+
+struct virtio_dev {
+	uint32_t device_id;
+	uint32_t vendor_id;
+	uint64_t device_features;
+	uint32_t device_features_sel;
+	uint64_t driver_features;
+	uint32_t driver_features_sel;
+	uint32_t queue_sel;
+	struct virtio_queue *queue;
+	uint32_t queue_notify;
+	uint32_t int_status;
+	uint32_t status;
+	uint32_t config_gen;
+
+	struct virtio_dev_ops *ops;
+	int irq;
+	void *config_data;
+	int config_len;
+};
+
+int virtio_dev_setup(struct virtio_dev *dev, int queues, int num_max);
+void virtio_dev_cleanup(struct virtio_dev *dev);
+void virtio_dev_complete(struct virtio_dev_req *req, uint32_t len);
+
+#define container_of(ptr, type, member) \
+	(type *)((char *)(ptr) - __builtin_offsetof(type, member))
+
+#include <endian.h>
+
+#endif /* _LKL_LIB_VIRTIO_H */
-- 
2.1.0
