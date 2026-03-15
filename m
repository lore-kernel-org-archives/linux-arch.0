Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0622579E
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547775; cv=none; b=G/WHEn/omUIqBVW++VK20utUCiG3qajCTzenhVBNSP8oH6lslFG7ZLwdL+Lkty97uzahjgtb/oaXRLPwRc06r5lh52eSy7WFMnvu7fS4eSuReUP0AIfBabjAnbQ+JYJL9+trCk/01krWuwW76VeLXHMrd74/NYkQ8y8CPeQulkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547775; c=relaxed/simple;
	bh=9AoXedWhdTJbvJI8xTQGUQqd0kav40UzqQRtdNSBzPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osn9Gj4chz0DLCW1cv6IUS555ez7HVQ1Wry+7g1geg2w/QrcYGu9fEccPkpSeuNERINMTvx7mbPH3SP9se+JQXQgwx3JtP+Ja2hTWhcGOI6WIfCnCQSgAcw/6NniJhHvWxAlxii7KIdhfcaxxRFA5QlKK7V8iGbFEY9zYgDxKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfb9QAOK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfb9QAOK"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829a27414a3so2023701b3a.3
        for <linux-arch@vger.kernel.org>; Sat, 14 Mar 2026 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773547772; x=1774152572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf0VF2vHYjYtYJbxl16wx5Z2RzFLyHEifM4cJwLvvBM=;
        b=Lfb9QAOK+g1/IyB04ikpFA2bc7U50WNpXqetXWIPlckC+VMYdL+LzyeyHxxmxQAXzT
         GUr8EG9mKVj4TU/TsNsKyrxVhvXKmMkKrlshldGPCBba6k9vkXFIclOLietyNdvRJeLI
         6j3b9gtxu0LawnQ9fnOyEpSPa4e14B5Nn94kkdhDq2bq0BX4QXMcWGKh/2P7Nn1G+GEk
         dNgmo8dCBuEl50F36Q8Pc9RiNFEMDhFMLQfYZef9PixJiAjR5cfGIAQfGTirRTZ7RoK1
         chxfgrguH0ColVLOJB4QYOvRaa5guXshkoxXF6hLCdbGfrdWgnNWd9diTklacPJcHVH6
         Q7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773547772; x=1774152572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rf0VF2vHYjYtYJbxl16wx5Z2RzFLyHEifM4cJwLvvBM=;
        b=GC55OGuGVdZFmUFf/dYK0hZnPVrZHTRP/rggNhFmwC4gzHTGCq7GitW3GdZ41W01U7
         dqaF4d8dhHRzdIwanXV0EV6SnpbUomrKMfZi1VQqB0VJopdedQgB4e9otVhp9PG7W7+r
         6KaX8vZ9mzhowvdHGaRNlIl1tJBrS5dgO+/AwFVkLQ1y24Rtjmgbx35HVZwcalgtIKUZ
         GteVHMrYqb7RJqbevHIj/BGdWOnqTCX8l3uK0eIOtCO5+SvfzmWj2TYGkk74+8r5XOHQ
         QvU8B8GtR9qUQdApLu2Olrz3MNI45RtMSIIoTT0uvQu+cO0BSo4OIiT2IxWMyuaz9Fzp
         JhWA==
X-Forwarded-Encrypted: i=1; AJvYcCXAO/fKvP//MNWiSZaWCMxbK08TY4YBQRGZzr2CoUylTCI1TCV97UvBJ/tbkPLn/s6wlwLEwEvd7Kt5@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTdn26NHR0o+2g847Ku5Fe7FzXHMou4hvvcaz3o2SG7RcFwZ6
	PPUNzABvB7pbT2KtfCjt1isc7U6yMjiB638v+3gNeFJdOUqWyG77zW6Y
X-Gm-Gg: ATEYQzwIyIJLsI7CtCe8ApNdtcmbE7Hr70MRrsA7jcWzJQC50MYPiFhIlnHgqVV8IVf
	dLZyIc8B5Rlf8CoMb1/iM7uOwHHjksyxM5pS0XvskQh4V/DyZ46DaK1dQTrgfWCjHz0l2HA2ZUG
	s6s3lEI3OiFpZk/4vcdPL14TJMqPo37s8Rv29VC7Dkd/tmXcUi2kgTolSPmlhNCHwI6l0j0N9NA
	Yz2cZASQA7JkkL6F2O0TiB5QcSquYdEz6d1qt0rWugqutJc2wnaI5aHd10rU3mFMoTkDu5ue31L
	1gsYkD96F+ikLS7wCvhWui90xZuZranuyfJ9usVZtoi3rCW0YLZQQ6ApGYvE0GYlEGw5gkurjCF
	Tn1CYxO1NBD6T1QX6FQBZIAwMxw0l7FBwg2XqTifMqWcNFYblSjxhSYaW//8FEPuQ3RLlHiNVld
	EVYC7smZyafEaxDYALRb8kl34rrh5OiI6Q3A==
X-Received: by 2002:a05:6a00:7703:b0:824:3cf6:3fb4 with SMTP id d2e1a72fcca58-82a1988f4eamr6145332b3a.32.1773547772057;
        Sat, 14 Mar 2026 21:09:32 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b50e:ee5b:78d:f26b:704b:c464])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm10192206b3a.13.2026.03.14.21.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 21:09:31 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v1 1/4] IPC: Added New system call do_mq_timedreceive2() for non-destructive peek on posix mqueue
Date: Sun, 15 Mar 2026 09:37:57 +0530
Message-ID: <20260315040827.156558-2-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315040827.156558-1-academic1mathura@gmail.com>
References: <20260315040827.156558-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 include/linux/compat.h            |   6 +-
 include/linux/syscalls.h          |   6 +
 include/uapi/asm-generic/unistd.h |   7 +-
 include/uapi/linux/mqueue.h       |  18 ++-
 ipc/mqueue.c                      | 186 ++++++++++++++++++++++++++++--
 ipc/msg.c                         |   2 +-
 ipc/msgutil.c                     |  48 ++++----
 ipc/util.h                        |   3 +-
 kernel/sys_ni.c                   |   1 +
 9 files changed, 235 insertions(+), 42 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c91..9f5ca26e76d8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -22,6 +22,7 @@
 #include <asm/compat.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
+#include <linux/mqueue.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /*
@@ -801,8 +802,9 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 		const struct iovec __user *vec,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
-
-
+asmlinkage long compat_sys_mq_timedreceive2(mqd_t mqdes, struct compat_mq_timedreceive2_args __user *uargs,
+											unsigned int flags, unsigned long index,
+											struct old_timespec32 __user *abs_timeout);
 /*
  * Deprecated system calls which are still defined in
  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb6278..993e570c90ab 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -79,6 +79,7 @@ struct mnt_id_req;
 struct ns_id_req;
 struct xattr_args;
 struct file_attr;
+struct mq_timedreceive2_args;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -93,6 +94,7 @@ struct file_attr;
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <trace/syscall.h>
+#include <linux/mqueue.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /*
@@ -746,6 +748,10 @@ asmlinkage long sys_mq_timedsend_time32(mqd_t mqdes,
 			const char __user *u_msg_ptr,
 			unsigned int msg_len, unsigned int msg_prio,
 			const struct old_timespec32 __user *u_abs_timeout);
+asmlinkage long
+sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
+		     unsigned int flags, unsigned long index,
+		     struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_msgget(key_t key, int msgflg);
 asmlinkage long sys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..200ee7fde5c4 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,9 +863,12 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
-#undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_mq_timedreceive2 472
+__SC_COMP(__NR_mq_timedreceive2, sys_mq_timedreceive2,
+		compat_sys_mq_timedreceive2)
 
+#undef __NR_syscalls
+#define __NR_syscalls 473
 /*
  * 32 bit systems traditionally used different
  * syscalls for off_t and loff_t arguments, while
diff --git a/include/uapi/linux/mqueue.h b/include/uapi/linux/mqueue.h
index b516b66840ad..9a4f5dfa7a68 100644
--- a/include/uapi/linux/mqueue.h
+++ b/include/uapi/linux/mqueue.h
@@ -18,7 +18,6 @@
 
 #ifndef _LINUX_MQUEUE_H
 #define _LINUX_MQUEUE_H
-
 #include <linux/types.h>
 
 #define MQ_PRIO_MAX 	32768
@@ -33,6 +32,23 @@ struct mq_attr {
 	__kernel_long_t	__reserved[4];	/* ignored for input, zeroed for output */
 };
 
+struct mq_timedreceive2_args {
+	size_t msg_len;
+	unsigned int  *msg_prio;
+	char  *msg_ptr;
+};
+
+#ifdef CONFIG_COMPAT
+#include <asm/compat.h>
+
+struct compat_mq_timedreceive2_args {
+	compat_size_t msg_len;
+	compat_uptr_t msg_prio;
+	compat_uptr_t msg_ptr;
+};
+
+#endif
+
 /*
  * SIGEV_THREAD implementation:
  * SIGEV_THREAD must be implemented in user space. If SIGEV_THREAD is passed
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4798b375972b..78dc414967a2 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -53,6 +53,7 @@ struct mqueue_fs_context {
 
 #define SEND		0
 #define RECV		1
+#define MQ_PEEK     2
 
 #define STATE_NONE	0
 #define STATE_READY	1
@@ -1230,6 +1231,115 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 	return ret;
 }
 
+static struct msg_msg *mq_peek_index(struct mqueue_inode_info *info, int index)
+{
+	struct rb_node *node;
+	struct posix_msg_tree_node *leaf;
+	struct msg_msg *msg;
+
+	int count = 0;
+
+	/* Start from highest priority */
+	node = rb_last(&info->msg_tree);
+	while (node) {
+		leaf = rb_entry(node, struct posix_msg_tree_node, rb_node);
+		list_for_each_entry(msg, &leaf->msg_list, m_list) {
+			if (count == index)
+				return msg;
+			count++;
+		}
+
+		node = rb_prev(node);
+	}
+
+	return NULL;
+}
+
+static int do_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args *args,
+			       unsigned int flags, unsigned long index,
+			       struct timespec64 *ts)
+{
+	ssize_t ret;
+	struct msg_msg *msg_ptr, *k_msg_buffer;
+	long k_m_type;
+	size_t k_m_ts;
+	struct inode *inode;
+	struct mqueue_inode_info *info;
+
+	if (!(flags & MQ_PEEK)) {
+		return do_mq_timedreceive(mqdes, args->msg_ptr, args->msg_len,
+					  args->msg_prio, ts);
+	}
+	audit_mq_sendrecv(mqdes, args->msg_len, 0, ts);
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f))
+		return -EBADF;
+
+	inode = file_inode(fd_file(f));
+	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
+		return -EBADF;
+	info = MQUEUE_I(inode);
+	audit_file(fd_file(f));
+
+	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ)))
+		return -EBADF;
+
+	if (unlikely(args->msg_len < info->attr.mq_msgsize))
+		return -EMSGSIZE;
+	if (index >= (unsigned long)info->attr.mq_maxmsg)
+		return -ENOENT;
+
+	spin_lock(&info->lock);
+	if (info->attr.mq_curmsgs == 0) {
+		spin_unlock(&info->lock);
+		return -EAGAIN;
+	}
+	msg_ptr = mq_peek_index(info, index);
+	if (!msg_ptr) {
+		spin_unlock(&info->lock);
+		return -ENOENT;
+	}
+	k_m_type = msg_ptr->m_type;
+	k_m_ts = msg_ptr->m_ts;
+	spin_unlock(&info->lock);
+
+	k_msg_buffer = alloc_msg(k_m_ts);
+	if (!k_msg_buffer)
+		return -ENOMEM;
+
+	/*
+	 * Two spin locks are necessary here. We are avoiding atomic memory
+	 * allocation and premature allocation before confirming that
+	 * a message actually exists to peek.
+	 */
+	spin_lock(&info->lock);
+	msg_ptr = mq_peek_index(info, index);
+	if (!msg_ptr || msg_ptr->m_type != k_m_type ||
+	    msg_ptr->m_ts != k_m_ts) {
+		spin_unlock(&info->lock);
+		free_msg(k_msg_buffer);
+		return -EAGAIN;
+	}
+	if (IS_ERR(copy_msg(msg_ptr, k_msg_buffer, k_m_ts))) {
+		spin_unlock(&info->lock);
+		free_msg(k_msg_buffer);
+		return -EINVAL;
+	}
+	spin_unlock(&info->lock);
+
+	ret = k_msg_buffer->m_ts;
+	if (args->msg_prio && put_user(k_m_type, args->msg_prio)) {
+		free_msg(k_msg_buffer);
+		return -EFAULT;
+	}
+	if (store_msg(args->msg_ptr, k_msg_buffer, k_m_ts)) {
+		free_msg(k_msg_buffer);
+		return -EFAULT;
+	}
+	free_msg(k_msg_buffer);
+	return ret;
+}
+
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
 		const struct __kernel_timespec __user *, u_abs_timeout)
@@ -1258,6 +1368,27 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
 
+SYSCALL_DEFINE5(mq_timedreceive2, mqd_t, mqdes,
+		struct mq_timedreceive2_args __user *, uargs, unsigned int,
+		flags, const unsigned long, index,
+		const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct mq_timedreceive2_args args;
+	struct timespec64 ts, *p = NULL;
+
+	if (copy_from_user(&args, uargs, sizeof(args)))
+		return -EFAULT;
+
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_timedreceive2(mqdes, &args, flags, index, p);
+}
+
 /*
  * Notes: the case when user wants us to deregister (with NULL as pointer)
  * and he isn't currently owner of notification, will be silently discarded.
@@ -1449,6 +1580,17 @@ SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
+static int compat_prepare_timeout(const struct old_timespec32 __user *p,
+								struct timespec64 *ts)
+{
+	if (get_old_timespec32(ts, p))
+		return -EFAULT;
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+	return 0;
+}
+
 #ifdef CONFIG_COMPAT
 
 struct compat_mq_attr {
@@ -1490,6 +1632,22 @@ static inline int put_compat_mq_attr(const struct mq_attr *attr,
 	return 0;
 }
 
+static inline int get_compat_mq_args(struct mq_timedreceive2_args *args,
+									struct compat_mq_timedreceive2_args __user *uargs)
+{
+	struct compat_mq_timedreceive2_args v;
+
+	if (copy_from_user(&v, uargs, sizeof(v)))
+		return -EFAULT;
+
+	memset(args, 0, sizeof(*args));
+	args->msg_len = (size_t)v.msg_len;
+	args->msg_prio = (unsigned int *)compat_ptr(v.msg_prio);
+	args->msg_ptr = (char *)compat_ptr(v.msg_ptr);
+
+	return 0;
+}
+
 COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 		       int, oflag, compat_mode_t, mode,
 		       struct compat_mq_attr __user *, u_attr)
@@ -1541,19 +1699,30 @@ COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
 		return -EFAULT;
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_COMPAT_32BIT_TIME
-static int compat_prepare_timeout(const struct old_timespec32 __user *p,
-				   struct timespec64 *ts)
+COMPAT_SYSCALL_DEFINE5(mq_timedreceive2, mqd_t, mqdes,
+		       struct compat_mq_timedreceive2_args __user *, uargs,
+		       unsigned int, flags, const unsigned long, index,
+		       const struct old_timespec32 __user *, u_abs_timeout)
 {
-	if (get_old_timespec32(ts, p))
+	struct mq_timedreceive2_args args;
+	struct timespec64 ts, *p = NULL;
+
+	if (get_compat_mq_args(&args, uargs))
 		return -EFAULT;
-	if (!timespec64_valid(ts))
-		return -EINVAL;
-	return 0;
+
+	if (u_abs_timeout) {
+		int res = compat_prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_timedreceive2(mqdes, &args, flags, index, p);
 }
 
+#endif
+
 SYSCALL_DEFINE5(mq_timedsend_time32, mqd_t, mqdes,
 		const char __user *, u_msg_ptr,
 		unsigned int, msg_len, unsigned int, msg_prio,
@@ -1583,6 +1752,7 @@ SYSCALL_DEFINE5(mq_timedreceive_time32, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
+
 #endif
 
 static const struct inode_operations mqueue_dir_inode_operations = {
diff --git a/ipc/msg.c b/ipc/msg.c
index 62996b97f0ac..6392b11dd7f7 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1156,7 +1156,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 			 * not update queue parameters.
 			 */
 			if (msgflg & MSG_COPY) {
-				msg = copy_msg(msg, copy);
+				msg = copy_msg(msg, copy, msg->m_ts);
 				goto out_unlock0;
 			}
 
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index e28f0cecb2ec..c5536ce47cc2 100644
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
@@ -122,39 +122,33 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
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
-
-	alen = min(len, DATALEN_MSG);
-	memcpy(dst + 1, src + 1, alen);
-
-	for (dst_pseg = dst->next, src_pseg = src->next;
-	     src_pseg != NULL;
-	     dst_pseg = dst_pseg->next, src_pseg = src_pseg->next) {
-
-		len -= alen;
-		alen = min(len, DATALEN_SEG);
-		memcpy(dst_pseg + 1, src_pseg + 1, alen);
+	chunk = min(len, DATALEN_MSG);
+	memcpy(dst + 1, src + 1, chunk);
+	remaining = len - chunk;
+	src_seg = src->next;
+	dst_seg = dst->next;
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
+	dst->m_ts   = src->m_ts;
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
index add3032da16f..658d6b8274b3 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -391,6 +391,7 @@ COND_SYSCALL(setuid16);
 /* restartable sequence */
 COND_SYSCALL(rseq);
 COND_SYSCALL(rseq_slice_yield);
+COND_SYSCALL(mq_timedreceive2);
 
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
-- 
2.43.0

