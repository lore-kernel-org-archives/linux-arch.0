Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2C4A3D31
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264169; cv=none; b=q369h55cuRDGTj56eL35Rp/16sA+mKea1/3tpsCO+oldPPk+T1OH0QKgK7z6xirE2UgqgmOZbVaHZ1f1SZi+F6HJsXwXl7RPyZzqmt97U2krWYA4UGuuvGB2L8llXYGRWOCFqma/NzMMlCoRE2tmym/ToLJEJG+6rioicMghBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264169; c=relaxed/simple;
	bh=O3p8O66zNawib+kEcrfy2voNhXu1BnNMeL5iJxlvJXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP1H7GgE5SK9o5UPS23Uo+ga4Djpvt7NlQc0taMG8ylM3EGIrDADNJx5wNipVQVmsugXXzWdk4+L+oAs5YF8R3iB5FpGtfsfhA6/CUJDtXiy9b0/xEexLnQWNz3QHMSA2uwC/DLKEM9QwyU1oy00VBlmA1v0MEbsh5vEDqMDlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NblsGtOO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NblsGtOO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so10052a91.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264165; x=1790868965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6hvOh5vfy8ZHxo2HAOxJjHMcR4RDNwu2+NepBGWOt4=;
        b=NblsGtOOVbxVBWujGWah/3z6gavRUyO2jv8ZOulcVpUYE2RLVDUkv2k6vhIyNyrzGy
         W1Dgl8la/POgPmyOumgxCSNEBLhLMESpkQNnFdPPFErt7L239zBvoIOoHoCuxrgUd4g7
         htr2apKsju1AeOQPMj0sNXcx9tnf5yGWjSyBbLOb5FuBPbBrFlCGoMfd/76TJeWfZjnC
         uTjZ+KmW7kX0+dC8++2Gan8+hmCSnziSTQ9oMZzoU21E7aVXLePAP0a210D99YBOG4lo
         1a1zC2ZqLzk4+WJZqSpI4ILs00L3+FetB24/tOEz4IaTaxGFwJkzPYLKkb7hBp9IXIKc
         SIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264165; x=1790868965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6hvOh5vfy8ZHxo2HAOxJjHMcR4RDNwu2+NepBGWOt4=;
        b=De2vbLsORN8oApCtzrVyz6syGB2u0xShUuk3Nqp0Crtjd9qUG5xzy2sapt+kki5ZGd
         pix42iUQDpS8BbeV2OThRf8DiRK4mVOJZLgP34VFeNgZPqZRC8Mjp9USv673oRMS0sXb
         +T7DAn02/07Q6NYRc/PBPWR51g3jadCtZSwBacjcF+3pljJvkkb8R4AXwBqJdUMih+tT
         LX9lUYO4gPWgGvLpMzdKOpoKhUGS6TmUhI+ZchFVLhYPH6w0YDDuVPGcM0rpxwO95rLH
         gElliTCvpVXfYjn6Q3BTg+CNBEteVGUA2CKBVRYLnm5ITYGIjhUDNT2LA8WocwfuoqyU
         XkAA==
X-Forwarded-Encrypted: i=1; AKwUvBy9cRUekqjzgDvp6FUALij54/+SK3hexwJrxIMt8bY/S+LAGEs1a6ihTHZDu5KvAlNq8WMqT4wrLBQG@vger.kernel.org
X-Gm-Message-State: AFuF++ly59aA6usQICYbRAoj9Ne3+AFONfi1z8X59L7ONhBJo6jbjAgg
	Hdu41wad7heGlmkikLti2+XIk8+JSpPzgKtP0e5RFuIAYHaE+d1Kf0JZ
X-Gm-Gg: AYBFou05yqUFGRcA9TFDLt1MaRVyjUygUXSdn3CxqKtRMQVRmxN9s/3GBXHUPTK36/G
	LL15NqFePXAcCRvriiXeORK1ADTlpDIUnhiq/rsjet1Nler8ZrabNEj6zBt0v0fvnBzFUhqLqQ+
	iozYNSy1eY20uPREngAAp6LILEOvkyrRr2Kq1BjQsAoPP1GBr6IOBPNYH0f6+X6a/x3K2Ef33mO
	yBpVK/TyIYybQ9XfOwEG6O7pmOTHT94J7V8Wk0e/Fzn7ws6Tme4O4G/Bw3a3joxCkGlaah2gy22
	91ji+NbjUPGuBMshlfbSlJMfUT0hGYIyJ1aCic9ulXpdkf//GWEornFiXyHttwObco1ZE1sx2Co
	BjFHHDgVyTS2dvlRTbQ1xIGuUGv0CmnSycsNh9J4HJgvHe3w0/0xl3yTJYhc65Sg6rLlhOl1vmg
	G0Kod+EvaNTXLYUErBzS7XVLj6vx1lM4m6ZdJi3VFoNEVFUMCRmVMZ0Wqsd3U4CIJC9ZLV83qU5
	89QAFOLuF4CWBCC/iud
X-Received: by 2002:a17:90b:384d:b0:39d:fcbe:fe04 with SMTP id 98e67ed59e1d1-3a0986eb55amr2611118a91.2.1790264165233;
        Thu, 24 Sep 2026 08:36:05 -0700 (PDT)
Received: from Modern-15.. ([223.225.63.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b11d4sm5979066a91.4.2026.09.24.08.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:36:04 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v4 1/4] IPC: Added two new system call mq_recvmmsg() and  mq_sendmmsg()
Date: Thu, 24 Sep 2026 21:04:59 +0530
Message-ID: <20260924153505.620772-2-mathura.kumar.tech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924153505.620772-1-mathura.kumar.tech@gmail.com>
References: <20260924153505.620772-1-mathura.kumar.tech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement two new POSIX message queue system calls,
mq_sendmmsg() and mq_recvmmsg(), analogous to the
existing sendmmsg()/recvmmsg() socket system calls.
These allow sending and receiving or peek multiple messages in a
single syscall,reducing the overhead of repeated context switches
per discrete message.

It contains the core implementation of both system calls as
part of a larger patchset.

  long  mq_sendmmsg(mqd_t mqdes, struct mq_mmsg_attrs *attrs,
		   unsigned int attrs_len, unsigned long start_idx,
		   const struct __kernel_timespec *u_abs_timeout);

  long mq_recvmmsg(mqd_t mqdes, struct mq_mmsg_attrs *attrs,
		  unsigned int attrs_len, unsigned int flags,
		  unsigned long start_idx,
		  const struct __kernel_timespec *u_abs_timeout);

Implementation complete details available under
mq_recvmmsg.rst and mq_sendmmsg.rst

Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
---
 include/linux/compat.h            |  12 +-
 include/linux/syscalls.h          |   9 +
 include/uapi/asm-generic/unistd.h |   9 +-
 include/uapi/linux/mqueue.h       |  27 +-
 ipc/mqueue.c                      | 595 ++++++++++++++++++++++++++++--
 ipc/msg.c                         |   2 +-
 ipc/msgutil.c                     |  45 ++-
 ipc/util.h                        |   3 +-
 kernel/sys_ni.c                   |   6 +
 9 files changed, 645 insertions(+), 63 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8da0a15c95f4..cb6cda4aebdd 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -18,7 +18,6 @@
 #include <linux/aio_abi.h>	/* for aio_context_t */
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
-
 #include <asm/compat.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
@@ -428,6 +427,8 @@ struct compat_sysctl_args;
 struct compat_kexec_segment;
 struct compat_mq_attr;
 struct compat_msgbuf;
+struct compat_msg_attrs;
+struct compat_mq_mmsg_attrs;
 
 void copy_siginfo_to_external32(struct compat_siginfo *to,
 		const struct kernel_siginfo *from);
@@ -805,8 +806,13 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
-
-
+asmlinkage long compat_sys_mq_sendmmsg(mqd_t mqdes, struct compat_mq_mmsg_attrs __user *attrs,
+				      unsigned int attrs_len, unsigned long start_index,
+				      const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long compat_sys_mq_recvmmsg(mqd_t mqdes, struct compat_mq_mmsg_attrs __user *attrs,
+				      unsigned int attrs_len, unsigned int flags,
+				      unsigned long start_index,
+				      const struct __kernel_timespec __user *abs_timeout);
 /*
  * Deprecated system calls which are still defined in
  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 874d9067a43b..0abf938e86da 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -79,6 +79,8 @@ struct mnt_id_req;
 struct ns_id_req;
 struct xattr_args;
 struct file_attr;
+struct mq_msg_attrs;
+struct mq_mmsg_attrs;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -739,7 +741,14 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info);
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
 asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_sendmmsg(mqd_t mqdes, struct mq_mmsg_attrs __user *attrs,
+				unsigned int attrs_len, unsigned long start_index,
+				const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_recvmmsg(mqd_t mqdes, struct mq_mmsg_attrs __user *attrs,
+				unsigned int attrs_len, unsigned int flags,
+				unsigned long start_index,
+				const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
 asmlinkage long sys_mq_timedreceive_time32(mqd_t mqdes,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..1d06486d3aa5 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,14 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
-#undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_mq_recvmmsg 472
+__SC_COMP(__NR_mq_recvmmsg, sys_mq_recvmmsg, compat_sys_mq_recvmmsg)
+
+#define __NR_mq_sendmmsg 473
+__SC_COMP(__NR_mq_sendmmsg, sys_mq_sendmmsg, compat_sys_mq_sendmmsg)
 
+#undef __NR_syscalls
+#define __NR_syscalls 474
 /*
  * 32 bit systems traditionally used different
  * syscalls for off_t and loff_t arguments, while
diff --git a/include/uapi/linux/mqueue.h b/include/uapi/linux/mqueue.h
index b516b66840ad..6ce21e41eb18 100644
--- a/include/uapi/linux/mqueue.h
+++ b/include/uapi/linux/mqueue.h
@@ -18,8 +18,9 @@
 
 #ifndef _LINUX_MQUEUE_H
 #define _LINUX_MQUEUE_H
-
+#include <linux/uio.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 
 #define MQ_PRIO_MAX 	32768
 /* per-uid limit of kernel memory used by mqueue, in bytes */
@@ -33,6 +34,30 @@ struct mq_attr {
 	__kernel_long_t	__reserved[4];	/* ignored for input, zeroed for output */
 };
 
+struct mq_msg_attrs {
+	__kernel_size_t msg_len;
+	unsigned int __user *msg_prio;
+	void __user *msg_ptr;
+};
+
+struct mq_mmsg_attrs {
+	struct iovec __user *msg_attrs_vec;
+	__kernel_size_t vlen;
+	int __user  *ret;
+};
+
+struct compat_msg_attrs {
+	compat_size_t msg_len;
+	compat_uptr_t __user msg_prio;
+	compat_uptr_t __user msg_ptr;
+};
+
+struct compat_mq_mmsg_attrs {
+	compat_uptr_t __user msg_attrs_vec;
+	compat_size_t vlen;
+	compat_uptr_t __user ret;
+};
+
 /*
  * SIGEV_THREAD implementation:
  * SIGEV_THREAD must be implemented in user space. If SIGEV_THREAD is passed
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4798b375972b..a19e24f7b3aa 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -11,7 +11,8 @@
  *
  * Audit:                   George Wilson           (ltcgcw@us.ibm.com)
  */
-
+#include "linux/build_bug.h"
+#include "linux/printk.h"
 #include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -39,7 +40,10 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/user.h>
 
+#include <linux/uio.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
+#include <linux/rbtree_augmented.h>
 #include "util.h"
 
 struct mqueue_fs_context {
@@ -54,6 +58,16 @@ struct mqueue_fs_context {
 #define SEND		0
 #define RECV		1
 
+#define MQ_PEEK     0x02
+#define MQ_RECV     0x04
+#define MQ_VALID_FLAGS (MQ_PEEK | MQ_RECV)
+
+/* List of all mq_mmsg_attrs "versions". */
+#define MQ_MMSG_ATTRS_SIZE_VER0	24
+#define MQ_MMSG_ATTRS_SIZE_LATEST MQ_MMSG_ATTRS_SIZE_VER0
+#define COMPAT_MQ_MMSG_ATTRS_SIZE_VER0	12
+#define COMPAT_MQ_MMSG_ATTRS_SIZE_LATEST COMPAT_MQ_MMSG_ATTRS_SIZE_VER0
+
 #define STATE_NONE	0
 #define STATE_READY	1
 
@@ -61,6 +75,8 @@ struct posix_msg_tree_node {
 	struct rb_node		rb_node;
 	struct list_head	msg_list;
 	int			priority;
+	unsigned int msg_count; /* Total messages at exactly this priority */
+	unsigned int subtree_msg_count; /* sum of messages in this node and all descendants */
 };
 
 /*
@@ -186,7 +202,53 @@ static struct ipc_namespace *get_ns_from_inode(struct inode *inode)
 	return ns;
 }
 
-/* Auxiliary functions to manipulate messages' list */
+static inline unsigned int get_subtree_count(struct rb_node *node)
+{
+	if (!node)
+		return 0;
+	return rb_entry(node, struct posix_msg_tree_node, rb_node)->subtree_msg_count;
+}
+
+static void msg_tree_propagate_subtree_msg_count(struct rb_node *node, struct rb_node *stop)
+{
+	while (node != stop) {
+		struct posix_msg_tree_node *leaf = rb_entry(node, struct posix_msg_tree_node,
+							    rb_node);
+		unsigned int new_count = leaf->msg_count +
+					 get_subtree_count(node->rb_left) +
+					 get_subtree_count(node->rb_right);
+		if (leaf->subtree_msg_count == new_count)
+			break;
+		leaf->subtree_msg_count = new_count;
+		node = rb_parent(node);
+	}
+}
+
+static void msg_tree_copy_subtree_msg_count(struct rb_node *old, struct rb_node *new)
+{
+	struct posix_msg_tree_node *old_leaf = rb_entry(old, struct posix_msg_tree_node, rb_node);
+	struct posix_msg_tree_node *new_leaf = rb_entry(new, struct posix_msg_tree_node, rb_node);
+
+	new_leaf->subtree_msg_count = old_leaf->subtree_msg_count;
+}
+
+static void msg_tree_rotate_subtree_msg_count(struct rb_node *old, struct rb_node *new)
+{
+	struct posix_msg_tree_node *old_leaf = rb_entry(old, struct posix_msg_tree_node, rb_node);
+	struct posix_msg_tree_node *new_leaf = rb_entry(new, struct posix_msg_tree_node, rb_node);
+
+	new_leaf->subtree_msg_count = old_leaf->subtree_msg_count;
+	old_leaf->subtree_msg_count = old_leaf->msg_count +
+				 get_subtree_count(old->rb_left) +
+				 get_subtree_count(old->rb_right);
+}
+
+static const struct rb_augment_callbacks msg_tree_callbacks = {
+	.propagate = msg_tree_propagate_subtree_msg_count,
+	.copy = msg_tree_copy_subtree_msg_count,
+	.rotate = msg_tree_rotate_subtree_msg_count
+};
+
 static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 {
 	struct rb_node **p, *parent = NULL;
@@ -216,13 +278,20 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 		INIT_LIST_HEAD(&leaf->msg_list);
 	}
 	leaf->priority = msg->m_type;
+	leaf->msg_count = 1;
+	leaf->subtree_msg_count = 1;
 
 	if (rightmost)
 		info->msg_tree_rightmost = &leaf->rb_node;
 
 	rb_link_node(&leaf->rb_node, parent, p);
-	rb_insert_color(&leaf->rb_node, &info->msg_tree);
+	msg_tree_propagate_subtree_msg_count(parent, NULL);
+	rb_insert_augmented(&leaf->rb_node, &info->msg_tree, &msg_tree_callbacks);
+	goto common_insert;
 insert_msg:
+	leaf->msg_count++;
+	msg_tree_propagate_subtree_msg_count(&leaf->rb_node, NULL);
+common_insert:
 	info->attr.mq_curmsgs++;
 	info->qsize += msg->m_ts;
 	list_add_tail(&msg->m_list, &leaf->msg_list);
@@ -236,8 +305,7 @@ static inline void msg_tree_erase(struct posix_msg_tree_node *leaf,
 
 	if (info->msg_tree_rightmost == node)
 		info->msg_tree_rightmost = rb_prev(node);
-
-	rb_erase(node, &info->msg_tree);
+	rb_erase_augmented(node, &info->msg_tree, &msg_tree_callbacks);
 	if (info->node_cache)
 		kfree(leaf);
 	else
@@ -277,8 +345,11 @@ static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
 		msg = list_first_entry(&leaf->msg_list,
 				       struct msg_msg, m_list);
 		list_del(&msg->m_list);
+		leaf->msg_count--;
 		if (list_empty(&leaf->msg_list)) {
 			msg_tree_erase(leaf, info);
+		} else {
+			msg_tree_propagate_subtree_msg_count(&leaf->rb_node, NULL);
 		}
 	}
 	info->attr.mq_curmsgs--;
@@ -765,7 +836,6 @@ static struct ext_wait_queue *wq_get_first_waiter(
 	return list_entry(ptr, struct ext_wait_queue, list);
 }
 
-
 static inline void set_cookie(struct sk_buff *skb, char code)
 {
 	((char *)skb->data)[NOTIFY_COOKIE_LEN-1] = code;
@@ -1034,29 +1104,27 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
 	__pipelined_op(wake_q, info, sender);
 }
 
-static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
-		size_t msg_len, unsigned int msg_prio,
-		struct timespec64 *ts)
+static ssize_t do_mq_sendmsg(mqd_t mqdes, const char __user *u_msg_ptr, size_t msg_len,
+			     unsigned int msg_prio, ktime_t *timeout)
 {
+	ssize_t ret = 0;
 	struct inode *inode;
 	struct ext_wait_queue wait;
 	struct ext_wait_queue *receiver;
 	struct msg_msg *msg_ptr;
 	struct mqueue_inode_info *info;
-	ktime_t expires, *timeout = NULL;
 	struct posix_msg_tree_node *new_leaf = NULL;
-	int ret = 0;
-	DEFINE_WAKE_Q(wake_q);
+	struct timespec64 ts, *abs_timeout = NULL;
 
+	DEFINE_WAKE_Q(wake_q);
 	if (unlikely(msg_prio >= (unsigned long) MQ_PRIO_MAX))
 		return -EINVAL;
 
-	if (ts) {
-		expires = timespec64_to_ktime(*ts);
-		timeout = &expires;
+	if (timeout) {
+		ts = ktime_to_timespec64(*timeout);
+		abs_timeout = &ts;
 	}
-
-	audit_mq_sendrecv(mqdes, msg_len, msg_prio, ts);
+	audit_mq_sendrecv(mqdes, msg_len, msg_prio, abs_timeout);
 
 	CLASS(fd, f)(mqdes);
 	if (fd_empty(f))
@@ -1139,24 +1207,37 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 	return ret;
 }
 
-static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
-		size_t msg_len, unsigned int __user *u_msg_prio,
-		struct timespec64 *ts)
+static ssize_t do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
+			       size_t msg_len, unsigned int msg_prio,
+			       struct timespec64 *ts)
+{
+	ktime_t expires, *timeout = NULL;
+
+	if (ts) {
+		expires = timespec64_to_ktime(*ts);
+		timeout = &expires;
+	}
+
+	return do_mq_sendmsg(mqdes, u_msg_ptr, msg_len, msg_prio, timeout);
+}
+
+static ssize_t do_mq_recvmsg(mqd_t mqdes, char __user *u_msg_ptr, size_t msg_len,
+			     unsigned int __user *u_msg_prio, ktime_t *timeout)
 {
 	ssize_t ret;
 	struct msg_msg *msg_ptr;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
 	struct ext_wait_queue wait;
-	ktime_t expires, *timeout = NULL;
 	struct posix_msg_tree_node *new_leaf = NULL;
+	struct timespec64 ts, *abs_timeout = NULL;
 
-	if (ts) {
-		expires = timespec64_to_ktime(*ts);
-		timeout = &expires;
+	if (timeout) {
+		ts = ktime_to_timespec64(*timeout);
+		abs_timeout = &ts;
 	}
 
-	audit_mq_sendrecv(mqdes, msg_len, 0, ts);
+	audit_mq_sendrecv(mqdes, msg_len, 0, abs_timeout);
 
 	CLASS(fd, f)(mqdes);
 	if (fd_empty(f))
@@ -1222,7 +1303,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 		ret = msg_ptr->m_ts;
 
 		if ((u_msg_prio && put_user(msg_ptr->m_type, u_msg_prio)) ||
-			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
+		     store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
 			ret = -EFAULT;
 		}
 		free_msg(msg_ptr);
@@ -1230,6 +1311,366 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 	return ret;
 }
 
+static ssize_t do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr, size_t msg_len,
+				  unsigned int __user *u_msg_prio, struct timespec64 *ts)
+{
+	ktime_t expires, *timeout = NULL;
+
+	if (ts) {
+		expires = timespec64_to_ktime(*ts);
+		timeout = &expires;
+	}
+
+	return do_mq_recvmsg(mqdes, u_msg_ptr, msg_len, u_msg_prio, timeout);
+}
+
+static struct msg_msg *mq_peek_index(struct mqueue_inode_info *info, unsigned long index)
+{
+	struct rb_node *node;
+	struct posix_msg_tree_node *leaf;
+	struct msg_msg *msg;
+	unsigned int right_count;
+	unsigned int offset;
+	unsigned int i = 0;
+
+	node = info->msg_tree.rb_node;
+	while (node) {
+		leaf = rb_entry(node, struct posix_msg_tree_node, rb_node);
+		right_count = get_subtree_count(node->rb_right);
+
+		if (index < right_count) {
+			node = node->rb_right;
+		} else if (index < (right_count + leaf->msg_count)) {
+			/* Target is at this priority level */
+			offset = index - right_count;
+			list_for_each_entry(msg, &leaf->msg_list, m_list) {
+				if (i == offset)
+					return msg;
+				i++;
+			}
+			WARN_ON_ONCE(i != offset);
+			break;
+		} else {
+			index -= (right_count + leaf->msg_count);
+			node = node->rb_left;
+		}
+	}
+
+	return NULL;
+}
+
+static ssize_t do_mq_recvmsg2(mqd_t mqdes, struct mq_msg_attrs *args, unsigned int flags,
+			      unsigned long index, ktime_t *timeout)
+{
+	ssize_t ret;
+	struct msg_msg *msg_ptr, *k_msg_buffer;
+	long k_m_type;
+	size_t k_m_ts;
+	struct inode *inode;
+	struct mqueue_inode_info *info;
+	struct timespec64 ts, *abs_timeout = NULL;
+
+	if (timeout) {
+		ts = ktime_to_timespec64(*timeout);
+		abs_timeout = &ts;
+	}
+	if (flags & MQ_PEEK) {
+		audit_mq_sendrecv(mqdes, args->msg_len, 0, abs_timeout);
+		CLASS(fd, f)(mqdes);
+		if (fd_empty(f))
+			return -EBADF;
+
+		inode = file_inode(fd_file(f));
+		if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
+			return -EBADF;
+
+		info = MQUEUE_I(inode);
+		audit_file(fd_file(f));
+		if (unlikely(!(fd_file(f)->f_mode & FMODE_READ)))
+			return -EBADF;
+
+		if (unlikely(args->msg_len < info->attr.mq_msgsize))
+			return -EMSGSIZE;
+
+		if (index >= (unsigned long)info->attr.mq_maxmsg)
+			return -EINVAL;
+
+		spin_lock(&info->lock);
+
+		if (info->attr.mq_curmsgs == 0) {
+			spin_unlock(&info->lock);
+			return -EAGAIN;
+		}
+		msg_ptr = mq_peek_index(info, index);
+		if (!msg_ptr) {
+			spin_unlock(&info->lock);
+			return -ENODATA;
+		}
+		k_m_type = msg_ptr->m_type;
+		k_m_ts = msg_ptr->m_ts;
+
+		spin_unlock(&info->lock);
+
+		k_msg_buffer = alloc_msg(k_m_ts);
+
+		if (!k_msg_buffer)
+			return -ENOMEM;
+		ret = security_msg_msg_alloc(k_msg_buffer);
+		if (ret) {
+			free_msg(k_msg_buffer);
+			return ret;
+		}
+
+	/*
+	 * Two spin locks are necessary here. We are avoiding atomic memory
+	 * allocation and premature allocation before confirming
+	 * a message actually exists to peek and retrieving required buffer size
+	 * when first lock was taken.
+	 */
+		spin_lock(&info->lock);
+
+		msg_ptr = mq_peek_index(info, index);
+		if (!msg_ptr || msg_ptr->m_type != k_m_type ||
+		     msg_ptr->m_ts != k_m_ts) {
+			spin_unlock(&info->lock);
+			free_msg(k_msg_buffer);
+			return -EAGAIN;
+		}
+		msg_ptr = copy_msg(msg_ptr, k_msg_buffer, k_m_ts);
+		if (IS_ERR(msg_ptr)) {
+			spin_unlock(&info->lock);
+			free_msg(k_msg_buffer);
+			return PTR_ERR(msg_ptr);
+		}
+		spin_unlock(&info->lock);
+
+		ret = k_msg_buffer->m_ts;
+		if (args->msg_prio && put_user(k_m_type, args->msg_prio)) {
+			free_msg(k_msg_buffer);
+			return -EFAULT;
+		}
+		if (store_msg((char *)args->msg_ptr, k_msg_buffer, k_m_ts)) {
+			free_msg(k_msg_buffer);
+			return -EFAULT;
+		}
+		free_msg(k_msg_buffer);
+			return ret;
+	}
+	if (flags & MQ_RECV) {
+		return do_mq_recvmsg(mqdes, (char *)args->msg_ptr, args->msg_len,
+				args->msg_prio, timeout);
+	}
+
+	return -EINVAL;
+}
+
+static int mq_mmsg_copy_attrs_from_user(struct mq_mmsg_attrs *attrs,
+					const struct mq_mmsg_attrs __user *uattrs,
+					unsigned int attrs_len)
+{
+	BUILD_BUG_ON(sizeof(*attrs) < MQ_MMSG_ATTRS_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(*attrs) != MQ_MMSG_ATTRS_SIZE_LATEST);
+
+	if (unlikely(attrs_len < MQ_MMSG_ATTRS_SIZE_VER0))
+		return -EINVAL;
+	if (unlikely(attrs_len > PAGE_SIZE))
+		return -E2BIG;
+	return copy_struct_from_user(attrs, sizeof(*attrs), uattrs, attrs_len);
+}
+
+#ifdef CONFIG_COMPAT
+static int mq_mmsg_copy_compat_attrs(struct mq_mmsg_attrs *attrs,
+				     const struct compat_mq_mmsg_attrs __user *uattrs,
+				     unsigned int attrs_len)
+{
+	struct compat_mq_mmsg_attrs v = {};
+	int err;
+
+	BUILD_BUG_ON(sizeof(*attrs) < MQ_MMSG_ATTRS_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(*attrs) != MQ_MMSG_ATTRS_SIZE_LATEST);
+	BUILD_BUG_ON(sizeof(v) != COMPAT_MQ_MMSG_ATTRS_SIZE_VER0);
+
+	if (unlikely(attrs_len < COMPAT_MQ_MMSG_ATTRS_SIZE_VER0))
+		return -EINVAL;
+	if (unlikely(attrs_len > PAGE_SIZE))
+		return -E2BIG;
+	err = copy_struct_from_user(&v, sizeof(v), uattrs, attrs_len);
+
+	if (err)
+		return err;
+	attrs->msg_attrs_vec = (struct iovec __user *)compat_ptr((unsigned long)v.msg_attrs_vec);
+	attrs->ret = (int *)compat_ptr(v.ret);
+	attrs->vlen = v.vlen;
+	return 0;
+}
+
+static int mq_mmsg_copy_compat_msg_attr(struct mq_msg_attrs *attr,
+					const struct iovec *desc_iov)
+{
+		struct compat_msg_attrs v = {};
+
+		if (desc_iov->iov_len != sizeof(v))
+			return -EINVAL;
+		if (copy_from_user(&v, desc_iov->iov_base, sizeof(v)))
+			return -EFAULT;
+
+		attr->msg_len = v.msg_len;
+		attr->msg_prio = (unsigned int *)compat_ptr(v.msg_prio);
+		attr->msg_ptr = compat_ptr(v.msg_ptr);
+		return 0;
+	}
+
+#endif
+
+static int mq_mmsg_copy_msg_attr(struct mq_msg_attrs *attr,
+				 const struct iovec *desc_iov, bool compat)
+{
+	if (compat)
+		return mq_mmsg_copy_compat_msg_attr(attr, desc_iov);
+	if (desc_iov->iov_len != sizeof(*attr))
+		return -EINVAL;
+	if (copy_from_user(attr, desc_iov->iov_base, sizeof(*attr)))
+		return -EFAULT;
+	return 0;
+}
+
+static inline long mq_mmsg_done_or_error(unsigned int done, int ret)
+{
+	if (ret < 0 && done)
+		return done;
+	return ret;
+}
+
+static ssize_t do_mq_recvmmsg(mqd_t mqdes, const struct mq_mmsg_attrs *attrs,
+			      unsigned int flags, unsigned long start_idx,
+			      struct timespec64 *ts, bool compat)
+{
+	struct iov_iter iter;
+	struct iovec outer_iovstack[UIO_FASTIOV], *free_iov = outer_iovstack;
+	const struct iovec *msg_iov;
+	ktime_t batch_deadline, *timeout = NULL;
+	ssize_t ret = 0;
+	ssize_t batch_success = 0;
+	unsigned long index;
+	unsigned int i;
+
+	if (flags & ~MQ_VALID_FLAGS)
+		return -EINVAL;
+	if ((flags & MQ_RECV) && (flags & MQ_PEEK))
+		return -EINVAL;
+	if (start_idx > attrs->vlen)
+		return -EINVAL;
+	if (!attrs->vlen || attrs->vlen > UIO_MAXIOV)
+		return -EINVAL;
+
+	ret = __import_iovec(ITER_DEST,
+			     attrs->msg_attrs_vec, attrs->vlen,
+			     ARRAY_SIZE(outer_iovstack), &free_iov, &iter,
+			     compat);
+	if (ret < 0)
+		return ret;
+	msg_iov = iter_iov(&iter);
+
+	/* One absolute deadline for the whole batch. */
+	if (ts) {
+		batch_deadline = timespec64_to_ktime(*ts);
+		timeout = &batch_deadline;
+	}
+	for (i = start_idx; i < attrs->vlen; i++) {
+		struct mq_msg_attrs desc = {};
+
+		ret = mq_mmsg_copy_msg_attr(&desc, &msg_iov[i], compat);
+		if (ret < 0)
+			break;
+
+		index = (flags & MQ_PEEK) ? i : 0;
+		ret = do_mq_recvmsg2(mqdes, &desc, flags, index, timeout);
+
+		if (ret < 0) {
+			if (attrs->ret && put_user(ret, attrs->ret)) {
+				kfree(free_iov);
+				return -EFAULT;
+			}
+			break;
+		}
+		batch_success++;
+	}
+
+	if (!(batch_success != attrs->vlen)) {
+		if (attrs->ret && put_user(0, attrs->ret)) {
+			kfree(free_iov);
+			return -EFAULT;
+			}
+	}
+	kfree(free_iov);
+	return mq_mmsg_done_or_error(batch_success, ret < 0 ? ret : batch_success);
+}
+
+static ssize_t do_mq_sendmmsg(mqd_t mqdes, const struct mq_mmsg_attrs *attrs,
+			      unsigned long start_idx, struct timespec64 *ts,
+			      bool compat)
+{
+	struct iov_iter iter;
+	struct iovec outer_iovstack[UIO_FASTIOV], *free_iov = outer_iovstack;
+	const struct iovec *msg_iov;
+	ktime_t batch_deadline, *timeout = NULL;
+	ssize_t ret = 0;
+	ssize_t batch_success = 0;
+	unsigned int i;
+
+	if (!attrs->vlen || attrs->vlen > UIO_MAXIOV || start_idx > attrs->vlen)
+		return -EINVAL;
+
+	ret = __import_iovec(ITER_SOURCE,
+			     attrs->msg_attrs_vec, attrs->vlen,
+			     ARRAY_SIZE(outer_iovstack), &free_iov, &iter,
+			     compat);
+	if (ret < 0)
+		return ret;
+	msg_iov = iter_iov(&iter);
+
+	if (ts) {
+		batch_deadline = timespec64_to_ktime(*ts);
+		timeout = &batch_deadline;
+	}
+	for (i = start_idx; i < attrs->vlen; i++) {
+		struct mq_msg_attrs desc = {};
+		unsigned int msg_prio = 0;
+
+		ret = mq_mmsg_copy_msg_attr(&desc, &msg_iov[i], compat);
+		if (ret < 0)
+			break;
+		if (!desc.msg_prio) {
+			ret = -EINVAL;
+			break;
+		}
+		if (get_user(msg_prio, desc.msg_prio)) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = do_mq_sendmsg(mqdes, desc.msg_ptr, desc.msg_len,
+				    msg_prio, timeout);
+
+		if (ret < 0) {
+			if (attrs->ret && put_user(ret, attrs->ret)) {
+				kfree(free_iov);
+				return -EFAULT;
+			}
+		break;
+		}
+		batch_success++;
+	}
+
+	if (!(batch_success != attrs->vlen)) {
+		if (attrs->ret && put_user(0, attrs->ret)) {
+			kfree(free_iov);
+			return -EFAULT;
+			}
+	}
+	kfree(free_iov);
+	return mq_mmsg_done_or_error(batch_success, ret < 0 ? ret : batch_success);
+}
+
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
 		const struct __kernel_timespec __user *, u_abs_timeout)
@@ -1244,6 +1685,27 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 	return do_mq_timedsend(mqdes, u_msg_ptr, msg_len, msg_prio, p);
 }
 
+SYSCALL_DEFINE5(mq_sendmmsg, mqd_t, mqdes, struct mq_mmsg_attrs __user *, attrs,
+		unsigned int, attrs_len, unsigned long, start_idx,
+		const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct mq_mmsg_attrs kattrs = {};
+	struct timespec64 ts, *p = NULL;
+	int ret;
+
+	ret = mq_mmsg_copy_attrs_from_user(&kattrs, attrs, attrs_len);
+	if (ret)
+		return ret;
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_sendmmsg(mqdes, &kattrs, start_idx, p, false);
+}
+
 SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
 		const struct __kernel_timespec __user *, u_abs_timeout)
@@ -1258,6 +1720,27 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
 
+SYSCALL_DEFINE6(mq_recvmmsg, mqd_t, mqdes, struct mq_mmsg_attrs __user *, attrs,
+		unsigned int, attrs_len, unsigned int, flags, unsigned long, start_idx,
+		const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct mq_mmsg_attrs kattrs = {};
+	struct timespec64 ts, *p = NULL;
+	int ret;
+
+	ret = mq_mmsg_copy_attrs_from_user(&kattrs, attrs, attrs_len);
+	if (ret)
+		return ret;
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_recvmmsg(mqdes, &kattrs, flags, start_idx, p, false);
+}
+
 /*
  * Notes: the case when user wants us to deregister (with NULL as pointer)
  * and he isn't currently owner of notification, will be silently discarded.
@@ -1460,7 +1943,7 @@ struct compat_mq_attr {
 };
 
 static inline int get_compat_mq_attr(struct mq_attr *attr,
-			const struct compat_mq_attr __user *uattr)
+				     const struct compat_mq_attr __user *uattr)
 {
 	struct compat_mq_attr v;
 
@@ -1476,7 +1959,7 @@ static inline int get_compat_mq_attr(struct mq_attr *attr,
 }
 
 static inline int put_compat_mq_attr(const struct mq_attr *attr,
-			struct compat_mq_attr __user *uattr)
+				     struct compat_mq_attr __user *uattr)
 {
 	struct compat_mq_attr v;
 
@@ -1491,8 +1974,8 @@ static inline int put_compat_mq_attr(const struct mq_attr *attr,
 }
 
 COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
-		       int, oflag, compat_mode_t, mode,
-		       struct compat_mq_attr __user *, u_attr)
+		      int, oflag, compat_mode_t, mode,
+		      struct compat_mq_attr __user *, u_attr)
 {
 	struct mq_attr attr, *p = NULL;
 	if (u_attr && oflag & O_CREAT) {
@@ -1504,7 +1987,7 @@ COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 }
 
 COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
-		       const struct compat_sigevent __user *, u_notification)
+		      const struct compat_sigevent __user *, u_notification)
 {
 	struct sigevent n, *p = NULL;
 	if (u_notification) {
@@ -1541,6 +2024,56 @@ COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
 		return -EFAULT;
 	return 0;
 }
+
+COMPAT_SYSCALL_DEFINE5(mq_sendmmsg, mqd_t, mqdes, struct compat_mq_mmsg_attrs __user *, attrs,
+		       unsigned int, attrs_len, unsigned long, start_idx,
+		       const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct mq_mmsg_attrs kattrs = {};
+	struct timespec64 ts, *p = NULL;
+	struct iovec msg_atrrs_vec = {};
+	int ret;
+
+	kattrs.msg_attrs_vec = &msg_atrrs_vec;
+	ret = mq_mmsg_copy_compat_attrs(&kattrs, attrs, attrs_len);
+	if (ret)
+		return ret;
+
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+
+	return do_mq_sendmmsg(mqdes, &kattrs, start_idx, p, true);
+}
+
+COMPAT_SYSCALL_DEFINE6(mq_recvmmsg, mqd_t, mqdes, struct compat_mq_mmsg_attrs __user *, attrs,
+		       unsigned int, attrs_len, unsigned int, flags, unsigned long, start_idx,
+		       const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct mq_mmsg_attrs kattrs = {};
+	struct timespec64 ts, *p = NULL;
+	struct iovec msg_atrrs_vec = {};
+	int ret;
+
+	kattrs.msg_attrs_vec = &msg_atrrs_vec;
+	ret = mq_mmsg_copy_compat_attrs(&kattrs, attrs, attrs_len);
+	if (ret)
+		return ret;
+
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+
+	return do_mq_recvmmsg(mqdes, &kattrs, flags, start_idx, p, true);
+}
 #endif
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
diff --git a/ipc/msg.c b/ipc/msg.c
index 62996b97f0ac..53c1632dc22a 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1156,7 +1156,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 			 * not update queue parameters.
 			 */
 			if (msgflg & MSG_COPY) {
-				msg = copy_msg(msg, copy);
+				msg = copy_msg(msg, copy, min_t(size_t, bufsz, ns->msg_ctlmax));
 				goto out_unlock0;
 			}
 
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index e28f0cecb2ec..a022fd36a356 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -51,7 +51,7 @@ static int __init init_msg_buckets(void)
 }
 subsys_initcall(init_msg_buckets);
 
-static struct msg_msg *alloc_msg(size_t len)
+struct msg_msg *alloc_msg(size_t len)
 {
 	struct msg_msg *msg;
 	struct msg_msgseg **pseg;
@@ -122,39 +122,36 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
 	free_msg(msg);
 	return ERR_PTR(err);
 }
-#ifdef CONFIG_CHECKPOINT_RESTORE
-struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst)
+
+struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst, size_t len)
 {
-	struct msg_msgseg *dst_pseg, *src_pseg;
-	size_t len = src->m_ts;
-	size_t alen;
+	struct msg_msgseg *src_seg, *dst_seg;
+	size_t remaining, chunk;
 
-	if (src->m_ts > dst->m_ts)
+	if (len > src->m_ts)
 		return ERR_PTR(-EINVAL);
 
-	alen = min(len, DATALEN_MSG);
-	memcpy(dst + 1, src + 1, alen);
+	chunk = min(len, DATALEN_MSG);
 
-	for (dst_pseg = dst->next, src_pseg = src->next;
-	     src_pseg != NULL;
-	     dst_pseg = dst_pseg->next, src_pseg = src_pseg->next) {
+	memcpy(dst + 1, src + 1, chunk);
+	remaining = len - chunk;
+	src_seg = src->next;
+	dst_seg = dst->next;
 
-		len -= alen;
-		alen = min(len, DATALEN_SEG);
-		memcpy(dst_pseg + 1, src_pseg + 1, alen);
+	while (remaining > 0 && src_seg && dst_seg) {
+		chunk = min(remaining, DATALEN_SEG);
+		memcpy(dst_seg + 1, src_seg + 1, chunk);
+		remaining -= chunk;
+		src_seg = src_seg->next;
+		dst_seg = dst_seg->next;
 	}
-
+	if (remaining != 0)
+		return ERR_PTR(-EINVAL);
 	dst->m_type = src->m_type;
-	dst->m_ts = src->m_ts;
-
+	dst->m_ts = len;
 	return dst;
 }
-#else
-struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
+
 int store_msg(void __user *dest, struct msg_msg *msg, size_t len)
 {
 	size_t alen;
diff --git a/ipc/util.h b/ipc/util.h
index a55d6cebe6d3..374abeee79b3 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -197,8 +197,9 @@ int ipc_parse_version(int *cmd);
 
 extern void free_msg(struct msg_msg *msg);
 extern struct msg_msg *load_msg(const void __user *src, size_t len);
-extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst);
+extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst, size_t len);
 extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
+extern struct msg_msg *alloc_msg(size_t len);
 
 static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int id)
 {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index add3032da16f..8219d76c72a0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -392,5 +392,11 @@ COND_SYSCALL(setuid16);
 COND_SYSCALL(rseq);
 COND_SYSCALL(rseq_slice_yield);
 
+/* ipc */
+COND_SYSCALL(mq_recvmmsg);
+COND_SYSCALL_COMPAT(mq_recvmmsg);
+COND_SYSCALL(mq_sendmmsg);
+COND_SYSCALL_COMPAT(mq_sendmmsg);
+
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
-- 
2.43.0

