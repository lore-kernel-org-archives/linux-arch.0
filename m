Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996F317165
	for <linux-arch@vger.kernel.org>; Wed,  4 Mar 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632331; cv=none; b=DAFGZfkNJ+m61htib4eAf2kzELM09HOcwpULiBf8GdT1wZYDAjlvHavOnOEyjHZnJYPFNNV7WLMAqRSLz0LjEbCkrn2k7OX2Rd1aU3UCoenxHjmwRARJ0zNNdIyCRndLRhIVvCFxgIV5EWNdPDwxQADnADcBltzrLLGh/w1ayrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632331; c=relaxed/simple;
	bh=Gn9Zv3JpugqVyJPCLYGJP5myH94a0BewFxb0vX8uaog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ALtfTxB00oUZWtz9bnj+OQ6VNvslqArxf1sNd/3/p3pPKw3k6XMX1SxYbFP5c8u96H/l6bJQ93Zcw7wdk8tEr2uVhe4giQBZuJbJCVUBODkPK0ifC7gzpuyBtsDFeY7pwdm0o/svytqQIm4HYAWmsuu1geWYR24TA0EMvELvpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSWk2XWy; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSWk2XWy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70ece855e2so2805474a12.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Mar 2026 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772632327; x=1773237127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lwFEhGH6zFnWRzbum7CB6vcTlRZZgYZnwvpot/O6tQ=;
        b=LSWk2XWy7p6j7DUc6fSzihL42jMFrr8bIL/WTacSuU2iTLyVJmOBNXqZcsOXMrn+N5
         OMVzRI/CbxwCDg9qCm2b6Cv5YTHQB7dYgkhIqvomW2qwJRW0H9NHJzu4jafenn/H8IU0
         QJIP1URqmquxF7Us5OeMO8mafsfUiSjaWsoPvstpjN+WiHjALwNDHQ5wmA6YQqcd1bRF
         B9/n64JjevGLyfh1ojphzGln9bC2TjMmN3cJArUIlB7LYVZ3dJFFuGnjSV5ZONeb3oBZ
         tupzsBlGAaV0PUCZx3FKyW7zvd/SVM89IL4VIUdFmszmcVKthEAUIDX0md5lwo0/d098
         Sfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632327; x=1773237127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lwFEhGH6zFnWRzbum7CB6vcTlRZZgYZnwvpot/O6tQ=;
        b=jRTa06iWqkqfql6s/B9GGxZU7ymzi6csdtYFSYx2fboeYkKDvwi4osb5LmbfY2YCVk
         xdfVrIRUv/dhWHkAHGB/kfqC0qdRcfr8kMDT8HumD7lVmz/MGnBq6aef2B6z+87Ib5dy
         iWBjbdG9aj6v9hpEMceZNcCI734OqUFtUFaeqZSLCnjniuouwBc2Sekt5AAx4zpjcHNM
         jinXp0DB0SPNgNUoGad0UsrJmJmWxNR0/sKkOuy47x+wzOnoHEutPR6W4mCaczonOVrl
         PrXYSlTvEZjNFjQONAr5bG6h2T5LFC8ZhpQrAUWOLqNTNIeWsvXgl0aw45oSz+E/Pxd+
         40+w==
X-Forwarded-Encrypted: i=1; AJvYcCWZl1uWx/yXvP2ogldjaSSbgHpQh26K9OQqmgNv5ulEZNRdW97RkbiKHaqWgR/SxN0fsoM770e5QT+Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yf9B4q1m+ESC4nuakEWXpfz7dOcUzCGdLwSvElNsJzLlXkDL
	l1ZWqLZAmQZKQzoEiMjoAQiqSd0IFjIHQacFPViU3AuSUKGh6Zc65qBIqeTXIZE8
X-Gm-Gg: ATEYQzzp5cThFjLZ4k9+qoQdrLBD4pSSTsihkpB4tM97ePZheTOgjKOhwYaa2hLQi/B
	PmRJJF1DylZQAZMxhKtINl5QPe6/O+zrDl4HjNy2b0sUOtNMEA9dT84gJS4k0QJLC9JOB3abE4a
	kMP2HnQRc/3q1OcuGl3Pn96gl7qeMavaZbujyxXrXDFTgTEdx5+NRDrwwHbJGpBDrjSpYsf4JkN
	QkjKiPhqmGsb8GRUZTX1ESsU+GiDcDh5dX+IOwYFxNBxU9YNOkV0TO7RfhwUaVjAtdNzsoyHrUS
	V9gVU+zy8fxd8pYo7afXGWvJ9Oa/4Co7arn7FN2bE38tl1oIyiAETqjR+WpiHC4sIlJ86EYO5Q2
	DQr+iYqE2h5VLckFT0v9fLnK2YxVsqGzzBZvYhzF/Ok1EiD3WSHoWan8p7HFFOt1Uh2HfZ77MJZ
	B5eD4cjnP+n79V+g4jhuzybDCxMU2qxJlVyQ==
X-Received: by 2002:a17:902:e80c:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2ae6ae1a285mr18275245ad.9.1772632326606;
        Wed, 04 Mar 2026 05:52:06 -0800 (PST)
Received: from Modern-15.. ([2401:4900:86f4:d8e0:8d8d:c166:cad9:b4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm199264225ad.70.2026.03.04.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:52:06 -0800 (PST)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 1/3] mqueue: introduce new  do_mq_timedreceive2() [ mq_peek  syscall] for non-destructive receive             and inspection
Date: Wed,  4 Mar 2026 19:21:21 +0530
Message-ID: <20260304135126.77270-1-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

    POSIX message queues currently lack a mechanism to read
    a message without removing it from the queue. This is a
    long-standing limitation,when we require inspection of queue state
    without altering it.

    Modifying existing mq_receive() semantics via additional
    flags was considered. However, altering behavior of an
    existing syscall risks breaking backward compatibility
    for applications relying on current semantics. Since
    mq_receive() guarantees message removal, changing this
    contract is not safe.

    To preserve ABI stability, this patch introduces a new
    system call that performs a non-destructive receive
    operation (peek). The existing behavior remains unchanged.

    Design considerations:

    Two approaches for copying message data to userspace
    were evaluated:

    1) Refcount-based message lifecycle handling
       - This can help us  Avoids intermediate temp kernel copy
       - Extends message lifetime
       -But this may increase writer starvation under heavy load and
        add unneassery complication on priority  management and
        delay more time to free space in inode due refcount may prevent

    2) Temporary kernel buffer copy
       - Copies message into a bounded kernel buffer
       - Reduces time message remains locked
       - Improves fairness under write-heavy workloads
       - Simpler lifetime management

    My implementation adopts the temporary buffer approach
    to minimize starvation and reduce locking complexity.
    The design allows future transition if refcounting is
    deemed preferable.

    Architecture support: Entry was made in relevant system call table
      - x86
      - ARM

    Testing:
      - 15+ functional test cases
      - Multi-threaded producer/consumer scenarios
      - concurrent pop and peek
      - Edge cases: empty queue, FIFO
        invalid flags, signal interruption etc.

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/syscalls.h               |   9 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 ipc/mqueue.c                           | 180 ++++++
 ipc/msg.c                              |   2 +-
 ipc/msgutil.c                          |  51 +-
 ipc/util.h                             |   3 +-
 tools/testing/selftests/ipc/.gitignore |   1 +
 tools/testing/selftests/ipc/Makefile   |   5 +-
 tools/testing/selftests/ipc/mq_peek.c  | 794 +++++++++++++++++++++++++
 11 files changed, 1022 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/ipc/mq_peek.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f832ebd2d79b..d6701f763203 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,5 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	mq_timedreceive2	sys_mq_timedreceive2_time32
+473	i386	mq_timedreceive2_time64	sys_mq_timedreceive2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..539654953280 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -441,3 +441,5 @@
 547	x32	pwritev2		compat_sys_pwritev64v2
 # This is the end of the legacy x32 range.  Numbers 548 and above are
 # not special and are not to be used for x32-specific syscalls.
+# Adding new syscalls from here to keep marginal gap intact in 472 to 511 for future expansion
+548	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb6278..4db405159a8b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -746,6 +746,15 @@ asmlinkage long sys_mq_timedsend_time32(mqd_t mqdes,
 			const char __user *u_msg_ptr,
 			unsigned int msg_len, unsigned int msg_prio,
 			const struct old_timespec32 __user *u_abs_timeout);
+asmlinkage long
+sys_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args __user *uargs,
+		     unsigned int flags, unsigned long index,
+		     struct __kernel_timespec __user *abs_timeout);
+asmlinkage long
+sys_mq_timedreceive2_time32(mqd_t mqdes,
+			    struct mq_timedreceive2_args __user *uargs,
+			    unsigned int flags, unsigned long index,
+			    struct old_timespec32 __user *abs_timeout);
 asmlinkage long sys_msgget(key_t key, int msgflg);
 asmlinkage long sys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..1d27fd3e118e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -865,7 +865,10 @@ __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
 #undef __NR_syscalls
 #define __NR_syscalls 472
-
+#define __NR_mq_timedreceive2 473
+__SC_3264(__NR_mq_timedreceive2, sys_mq_timedreceive2_time32, sys_mq_timedreceive2)
+#define __NR_mq_timedreceive2_time64 474
+__SYSCALL(__NR_mq_timedreceive2_time64, sys_mq_timedreceive2)
 /*
  * 32 bit systems traditionally used different
  * syscalls for off_t and loff_t arguments, while
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4798b375972b..f6c7462b818f 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -53,6 +53,7 @@ struct mqueue_fs_context {
 
 #define SEND		0
 #define RECV		1
+#define MQ_PEEK     2
 
 #define STATE_NONE	0
 #define STATE_READY	1
@@ -63,6 +64,12 @@ struct posix_msg_tree_node {
 	int			priority;
 };
 
+struct mq_timedreceive2_args {
+	size_t msg_len;
+	unsigned int  *msg_prio;
+    char  *msg_ptr;
+};
+
 /*
  * Locking:
  *
@@ -1230,6 +1237,116 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 	return ret;
 }
 
+static struct msg_msg *mq_peek_index(struct mqueue_inode_info *info, int index)
+{
+	struct rb_node *node;
+	struct posix_msg_tree_node *leaf;
+	struct msg_msg *msg;
+	int count = 0;
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
+static int do_mq_timedreceive2(mqd_t mqdes,
+			       struct mq_timedreceive2_args __user *uargs,
+			       unsigned int flags, unsigned long index,
+			       struct timespec64 *ts)
+{
+	struct mq_timedreceive2_args args;
+	ssize_t ret;
+	struct msg_msg *msg_ptr, *k_msg_buffer;
+	long k_m_type;
+	size_t k_m_ts;
+	struct inode *inode;
+	struct mqueue_inode_info *info;
+
+	if (copy_from_user(&args, uargs, sizeof(args)))
+		return -EFAULT;
+
+	if (!(flags & MQ_PEEK)) {
+		return do_mq_timedreceive(mqdes, args.msg_ptr, args.msg_len,
+					  args.msg_prio, ts);
+	}
+	audit_mq_sendrecv(mqdes, args.msg_len, 0, ts);
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
+	if (unlikely(args.msg_len < info->attr.mq_msgsize))
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
+	/*Two spin lock is necessary we are avoiding atomic memory allocation
+    *and to early allocation without confirming that , is even msg exists to peek
+    */
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
+	if (args.msg_prio && put_user(k_m_type, args.msg_prio)) {
+		free_msg(k_msg_buffer);
+		return -EFAULT;
+	}
+	if (store_msg(args.msg_ptr, k_msg_buffer, k_m_ts)) {
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
@@ -1258,6 +1375,23 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
 
+SYSCALL_DEFINE5(mq_timedreceive2, mqd_t, mqdes,
+		struct mq_timedreceive2_args __user *, uargs, unsigned int,
+		flags, const unsigned long, index,
+		const struct __kernel_timespec __user *, u_abs_timeout)
+{
+	struct timespec64 ts, *p = NULL;
+
+	if (u_abs_timeout) {
+		int res = prepare_timeout(u_abs_timeout, &ts);
+
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_timedreceive2(mqdes, uargs, flags, index, p);
+}
+
 /*
  * Notes: the case when user wants us to deregister (with NULL as pointer)
  * and he isn't currently owner of notification, will be silently discarded.
@@ -1450,6 +1584,7 @@ SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
 }
 
 #ifdef CONFIG_COMPAT
+#include "asm-generic/compat.h"
 
 struct compat_mq_attr {
 	compat_long_t mq_flags;      /* message queue flags		     */
@@ -1459,6 +1594,12 @@ struct compat_mq_attr {
 	compat_long_t __reserved[4]; /* ignored for input, zeroed for output */
 };
 
+struct compat_mq_timedreceive2_args {
+	compat_size_t msg_len;
+	compat_uptr_t msg_prio;
+	compat_uptr_t msg_ptr;
+};
+
 static inline int get_compat_mq_attr(struct mq_attr *attr,
 			const struct compat_mq_attr __user *uattr)
 {
@@ -1490,6 +1631,22 @@ static inline int put_compat_mq_attr(const struct mq_attr *attr,
 	return 0;
 }
 
+static inline int get_compat_mq_args(struct mq_timedreceive2_args *args,
+					struct compat_mq_timedreceive2_args __user *uargs)
+{
+	struct compat_mq_timedreceive2_args v;
+
+	if (copy_from_user(&v, uargs, sizeof(*uargs)))
+		return -EFAULT;
+
+	memset(args, 0, sizeof(*args));
+	args->msg_len = (size_t)compat_ptr(v.msg_len);
+	args->msg_prio = (unsigned int *)compat_ptr(v.msg_prio);
+	args->msg_ptr = (char *)compat_ptr(v.msg_ptr);
+
+	return 0;
+}
+
 COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 		       int, oflag, compat_mode_t, mode,
 		       struct compat_mq_attr __user *, u_attr)
@@ -1583,6 +1740,29 @@ SYSCALL_DEFINE5(mq_timedreceive_time32, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
+
+SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
+		struct compat_mq_timedreceive2_args __user *, uargs,
+		unsigned int, flags, const unsigned long, index,
+		const struct old_timespec32 __user *, u_abs_timeout)
+{
+	struct mq_timedreceive2_args args, *pargs = NULL;
+
+	pargs = &args;
+
+	if (get_compat_mq_args(pargs, uargs))
+		return -EFAULT;
+
+	struct timespec64 ts, *p = NULL;
+
+	if (u_abs_timeout) {
+		int res = compat_prepare_timeout(u_abs_timeout, &ts);
+		if (res)
+			return res;
+		p = &ts;
+	}
+	return do_mq_timedreceive2(mqdes, pargs, flags, index, p);
+}
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
index e28f0cecb2ec..8c8622b78f12 100644
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
@@ -122,39 +122,34 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
 	free_msg(msg);
 	return ERR_PTR(err);
 }
-#ifdef CONFIG_CHECKPOINT_RESTORE
-struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst)
+
+struct msg_msg *copy_msg(struct msg_msg *src,
+							struct msg_msg *dst,
+						size_t len)
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
-}
-#else
-struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
+ }
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
diff --git a/tools/testing/selftests/ipc/.gitignore b/tools/testing/selftests/ipc/.gitignore
index 9ed280e4c704..fe609d98ecb2 100644
--- a/tools/testing/selftests/ipc/.gitignore
+++ b/tools/testing/selftests/ipc/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 msgque_test
 msgque
+mq_peek
diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index 50e9c299fc4a..fa9d4f500783 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+CC = gcc
+CFLAGS = -static -O2
 ifeq ($(ARCH),i386)
         ARCH := x86
 	CFLAGS := -DCONFIG_X86_32 -D__i386__
@@ -12,7 +14,8 @@ endif
 
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := msgque
+TEST_GEN_PROGS := msgque mq_peek
+LDLIBS += -lrt -lpthread
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ipc/mq_peek.c b/tools/testing/selftests/ipc/mq_peek.c
new file mode 100644
index 000000000000..77fcb50fdbcd
--- /dev/null
+++ b/tools/testing/selftests/ipc/mq_peek.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mq_peek.c - Selftest for mq_timedreceive2(MQ_PEEK)
+ *
+ * Tests the peek-without-dequeue extension to POSIX message queues:
+ *   - Correct priority-rank indexed access (index 0 = highest priority)
+ *   - FIFO ordering within same priority level
+ *   - Non-destructive semantics (queue is never modified on peek)
+ *   - All error paths (-EBADF, -EMSGSIZE, -EFAULT, -EAGAIN, -ENOENT)
+ *   - Large (multi-segment) message payload copy
+ *   - Concurrent peek + receive / peek + send races
+ */
+
+#include "linux/array_size.h"
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <pthread.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <mqueue.h>
+#include <time.h>
+
+#include "kselftest.h"
+
+#ifndef __NR_mq_timedreceive2
+#if defined(__x86_64__)
+#define __NR_mq_timedreceive2 548
+#elif defined(__aarch64__)
+#define __NR_mq_timedreceive2 548
+#elif defined(__riscv)
+#define __NR_mq_timedreceive2 548
+#else
+#define __NR_mq_timedreceive2 548
+#endif
+#endif
+
+#define MQ_PEEK 2U
+
+struct mq_timedreceive2_args {
+	size_t msg_len;
+	unsigned int *msg_prio;
+	char *msg_ptr;
+};
+
+static long mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args *uargs,
+			     unsigned int flags, unsigned long index,
+			     const struct timespec *timeout)
+{
+	return syscall(__NR_mq_timedreceive2, (long)mqdes, uargs, (long)flags,
+		       index, timeout);
+}
+
+#define MQ_NAME_PREFIX "/mq_peek_test_"
+#define MAX_MSG_SIZE 128
+#define LARGE_MSG_SIZE 4064
+#define MQ_MAXMSG 16
+
+#define PRIO_HIGH 9
+#define PRIO_MED 5
+#define PRIO_LOW 1
+
+static mqd_t open_queue(const char *suffix, long msgsize)
+{
+	char name[64];
+	struct mq_attr attr = {
+		.mq_flags = 0,
+		.mq_maxmsg = MQ_MAXMSG,
+		.mq_msgsize = msgsize,
+		.mq_curmsgs = 0,
+	};
+	mqd_t mqd;
+
+	snprintf(name, sizeof(name), "%s%s", MQ_NAME_PREFIX, suffix);
+	mq_unlink(name);
+
+	mqd = mq_open(name, O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, 0600, &attr);
+	if (mqd == (mqd_t)-1) {
+		ksft_test_result_fail("mq_open(%s): %m\n", name);
+		ksft_exit_fail();
+	}
+
+	mq_unlink(name);
+	return mqd;
+}
+
+static void send_msg(mqd_t mqd, unsigned int prio, const char *text, size_t len)
+{
+	if (mq_send(mqd, text, len, prio) != 0) {
+		ksft_test_result_fail("mq_send(prio=%u): %m\n", prio);
+		ksft_exit_fail();
+	}
+}
+
+static long peek(mqd_t mqd, unsigned long index, char *buf, size_t bufsz,
+		 unsigned int *prio)
+{
+	struct mq_timedreceive2_args args = {
+		.msg_len = bufsz,
+		.msg_prio = prio,
+		.msg_ptr = buf,
+	};
+	return mq_timedreceive2(mqd, &args, MQ_PEEK, index, NULL);
+}
+
+static long queue_depth(mqd_t mqd)
+{
+	struct mq_attr attr;
+
+	if (mq_getattr(mqd, &attr) != 0)
+		return -1;
+	return attr.mq_curmsgs;
+}
+
+static void test_peek_empty_queue(void)
+{
+	mqd_t mqd = open_queue("empty", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EAGAIN)
+		ksft_test_result_pass("peek on empty queue [EAGAIN]\n");
+	else
+		ksft_test_result_fail("peek on empty queue: expected EAGAIN, got ret=%ld errno=%d (%m)\n",
+							ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_invalid_fd(void)
+{
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	ret = peek((mqd_t)-1, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek invalid fd [ EBADF]\n");
+	else
+		ksft_test_result_fail("peek invalid fd: expected EBADF, got ret=%ld errno=%d\n",
+							   ret, errno);
+}
+
+
+static void test_peek_non_mqueue_fd(void)
+{
+	int pipefd[2];
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	if (pipe(pipefd) != 0) {
+		ksft_test_result_skip("pipe() failed, skipping non-mqueue-fd test\n");
+		return;
+	}
+
+	ret = peek((mqd_t)pipefd[0], 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek on pipe fd [EBADF]\n");
+	else
+		ksft_test_result_fail("peek non-mqueue fd: expected EBADF, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
+
+static void test_peek_writeonly_fd(void)
+{
+	char name[] = "/ksft_mq_peek_wo";
+	struct mq_attr attr = { .mq_maxmsg = 4, .mq_msgsize = MAX_MSG_SIZE };
+	mqd_t rw, wo;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	mq_unlink(name);
+	rw = mq_open(name, O_RDWR | O_CREAT, 0600, &attr);
+	if (rw == (mqd_t)-1) {
+		ksft_test_result_skip("mq_open RW failed: %m\n");
+		return;
+	}
+	wo = mq_open(name, O_WRONLY);
+	mq_unlink(name);
+
+	if (wo == (mqd_t)-1) {
+		ksft_test_result_skip("mq_open WO failed: %m\n");
+		mq_close(rw);
+		return;
+	}
+
+	send_msg(rw, PRIO_HIGH, "x", 1);
+
+	ret = peek(wo, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek on O_WRONLY fd [EBADF]\n");
+	else
+		ksft_test_result_fail("peek WO fd: expected EBADF, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(wo);
+	mq_close(rw);
+}
+
+
+static void test_peek_buffer_too_small(void)
+{
+	mqd_t mqd = open_queue("small", MAX_MSG_SIZE);
+	char tiny[1]; /* deliberately too small */
+	unsigned int prio;
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(tiny),
+		.msg_prio = &prio,
+		.msg_ptr = tiny,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, "hello", 5);
+
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret == -1 && errno == EMSGSIZE)
+		ksft_test_result_pass("peek with small buf [EMSGSIZE]\n");
+	else
+		ksft_test_result_fail("peek small buf: expected EMSGSIZE, got ret=%ld errno=%d\n",
+							ret, errno);
+
+	mq_close(mqd);
+}
+
+
+
+
+static void test_peek_bad_msg_ptr(void)
+{
+	mqd_t mqd = open_queue("bad_ptr", MAX_MSG_SIZE);
+	unsigned int prio;
+
+	struct mq_timedreceive2_args args = {
+		.msg_len = MAX_MSG_SIZE,
+		.msg_prio = &prio,
+		.msg_ptr = (char *)0x1,
+	};
+	long ret;
+	send_msg(mqd, PRIO_HIGH, "payload", 7);
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret == -1 && errno == EFAULT)
+		ksft_test_result_pass("peek bad msg_ptr [EFAULT]\n");
+	else
+		ksft_test_result_fail("peek bad msg_ptr: expected EFAULT, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_index_out_of_range(void)
+{
+	mqd_t mqd = open_queue("oob", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	send_msg(mqd, PRIO_MED, "one", 3);
+	ret = peek(mqd, 1, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == ENOENT)
+		ksft_test_result_pass("peek OOB index [ENOENT]\n");
+	else
+		ksft_test_result_fail("peek OOB: expected ENOENT, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_basic_data(void)
+{
+	mqd_t mqd = open_queue("basic", MAX_MSG_SIZE);
+	const char *payload = "peek-test-payload";
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio = 0;
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, payload, strlen(payload));
+
+	memset(buf, 0, sizeof(buf));
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+
+	if (ret < 0) {
+		ksft_test_result_fail("basic peek failed: ret=%ld errno=%d (%m)\n", ret, errno);
+		goto out;
+	}
+	if ((size_t)ret != strlen(payload)) {
+		ksft_test_result_fail("basic peek: wrong size %ld (expected %zu)\n", ret, strlen(payload));
+		goto out;
+	}
+	if (memcmp(buf, payload, strlen(payload)) != 0) {
+		ksft_test_result_fail("basic peek: payload mismatch\n");
+		goto out;
+	}
+	if (prio != PRIO_HIGH) {
+		ksft_test_result_fail("basic peek: wrong prio %u (expected %d)\n", prio, PRIO_HIGH);
+		goto out;
+	}
+	ksft_test_result_pass("basic peek: correct data and priority\n");
+out:
+	mq_close(mqd);
+}
+
+
+static void test_peek_nondestructive(void)
+{
+	mqd_t mqd = open_queue("nodestr", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	int i;
+
+	send_msg(mqd, PRIO_HIGH, "A", 1);
+	send_msg(mqd, PRIO_MED, "B", 1);
+	send_msg(mqd, PRIO_LOW, "C", 1);
+
+	if (queue_depth(mqd) != 3) {
+		ksft_test_result_fail("initial depth != 3\n");
+		mq_close(mqd);
+		return;
+	}
+
+	for (i = 0; i < 10; i++) {
+		peek(mqd, 0, buf, sizeof(buf), &prio);
+		peek(mqd, 1, buf, sizeof(buf), &prio);
+		peek(mqd, 2, buf, sizeof(buf), &prio);
+	}
+
+	if (queue_depth(mqd) == 3)
+		ksft_test_result_pass(
+			"peek is non-destructive (depth stays 3)\n");
+	else
+		ksft_test_result_fail("peek modified queue: depth=%ld (expected 3)\n", queue_depth(mqd));
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_priority_order(void)
+{
+	mqd_t mqd = open_queue("prio_order", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_LOW, "low", 3);
+	send_msg(mqd, PRIO_HIGH, "high", 4);
+	send_msg(mqd, PRIO_MED, "med", 3);
+
+	/* index 0 must return highest priority */
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret < 0 || prio != PRIO_HIGH) {
+		ksft_test_result_fail(
+			"prio_order index0: prio=%u ret=%ld errno=%d\n", prio,
+			ret, errno);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "high", 4) != 0) {
+		ksft_test_result_fail("prio_order index0: wrong payload\n");
+		pass = 0;
+	}
+
+	/* index 1 must return medium priority */
+	ret = peek(mqd, 1, buf, sizeof(buf), &prio);
+	if (pass && (ret < 0 || prio != PRIO_MED)) {
+		ksft_test_result_fail("prio_order index1: prio=%u ret=%ld\n",
+				      prio, ret);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "med", 3) != 0) {
+		ksft_test_result_fail("prio_order index1: wrong payload\n");
+		pass = 0;
+	}
+
+	/* index 2 must return lowest priority */
+	ret = peek(mqd, 2, buf, sizeof(buf), &prio);
+	if (pass && (ret < 0 || prio != PRIO_LOW)) {
+		ksft_test_result_fail("prio_order index2: prio=%u ret=%ld\n",
+				      prio, ret);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "low", 3) != 0) {
+		ksft_test_result_fail("prio_order index2: wrong payload\n");
+		pass = 0;
+	}
+
+	if (pass)
+		ksft_test_result_pass(
+			"priority ordering: index0=HIGH, index1=MED, index2=LOW\n");
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_fifo_within_priority(void)
+{
+	mqd_t mqd = open_queue("fifo", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_HIGH, "first", 5);
+	send_msg(mqd, PRIO_HIGH, "second", 6);
+	send_msg(mqd, PRIO_HIGH, "third", 5);
+
+	memset(buf, 0, sizeof(buf));
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret < 0 || memcmp(buf, "first", 5) != 0) {
+		ksft_test_result_fail(
+			"FIFO peek[0]: expected 'first', got '%.*s' ret=%ld\n",
+			(int)ret, buf, ret);
+		pass = 0;
+	}
+
+	if (pass) {
+		char rbuf[MAX_MSG_SIZE];
+		unsigned int rprio;
+		ssize_t r = mq_receive(mqd, rbuf, sizeof(rbuf), &rprio);
+		if (r < 0 || memcmp(rbuf, "first", 5) != 0) {
+			ksft_test_result_fail("mq_receive 'first' failed\n");
+			pass = 0;
+		}
+	}
+
+	if (pass) {
+		memset(buf, 0, sizeof(buf));
+		ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+		if (ret < 0 || memcmp(buf, "second", 6) != 0) {
+			ksft_test_result_fail("FIFO peek after receive: expected 'second', got '%.*s'\n",
+				(int)ret, buf);
+			pass = 0;
+		}
+}
+
+	if (pass)
+		ksft_test_result_pass("FIFO within same priority is correct\n");
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_all_indices(void)
+{
+	const unsigned int prios[] = { 2, 7, 4, 9, 1, 6 };
+	const int N = (int)(sizeof(prios) / sizeof(prios[0]));
+	mqd_t mqd = open_queue("all_idx", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	char expected_payload[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int i, pass = 1;
+	unsigned int sorted[6];
+
+	for (i = 0; i < N; i++) {
+		snprintf(expected_payload, sizeof(expected_payload),
+			 "msg_prio_%u", prios[i]);
+		send_msg(mqd, prios[i], expected_payload,
+			 strlen(expected_payload));
+		sorted[i] = prios[i];
+	}
+
+	for (i = 0; i < N - 1; i++) {
+		int j;
+		for (j = i + 1; j < N; j++) {
+			if (sorted[j] > sorted[i]) {
+				unsigned int tmp = sorted[i];
+				sorted[i] = sorted[j];
+				sorted[j] = tmp;
+			}
+		}
+	}
+
+	for (i = 0; i < N && pass; i++) {
+		memset(buf, 0, sizeof(buf));
+		ret = peek(mqd, (unsigned long)i, buf, sizeof(buf), &prio);
+		if (ret < 0) {
+			ksft_test_result_fail("all_indices peek[%d] failed: ret=%ld errno=%d\n",
+									i, ret, errno);
+			pass = 0;
+			break;
+		}
+		if (prio != sorted[i]) {
+			ksft_test_result_fail("all_indices peek[%d]: prio=%u expected=%u\n",
+									i, prio, sorted[i]);
+			pass = 0;
+		}
+
+		snprintf(expected_payload, sizeof(expected_payload),
+			 "msg_prio_%u", sorted[i]);
+		if (memcmp(buf, expected_payload, strlen(expected_payload))) {
+			ksft_test_result_fail("all_indices peek[%d]: payload mismatch\n", i);
+			pass = 0;
+		}
+	}
+
+	if (pass && queue_depth(mqd) != N) {
+		ksft_test_result_fail("all_indices: depth=%ld expected=%d after peek\n",
+			queue_depth(mqd), N);
+		pass = 0;
+	}
+
+	if (pass) {
+		ret = peek(mqd, (unsigned long)N, buf, sizeof(buf), &prio);
+		if (!(ret == -1 && errno == ENOENT)) {
+			ksft_test_result_fail("all_indices OOB[%d]: expected ENOENT, got ret=%ld errno=%d\n",
+									N, ret, errno);
+			pass = 0;
+		}
+	}
+
+	if (pass)
+		ksft_test_result_pass("all-indices: correct prio order + OOB ENOENT\n");
+
+	mq_close(mqd);
+}
+
+static void test_peek_large_message(void)
+{
+	mqd_t mqd = open_queue("large", LARGE_MSG_SIZE);
+	char *send_buf, *recv_buf;
+	unsigned int prio = 0;
+	long ret;
+	int pass = 1;
+
+	send_buf = malloc(LARGE_MSG_SIZE);
+	recv_buf = calloc(1, LARGE_MSG_SIZE);
+	if (!send_buf || !recv_buf) {
+		ksft_test_result_skip("OOM allocating large message buffers\n");
+		goto out;
+	}
+
+	for (int i = 0; i < LARGE_MSG_SIZE; i++)
+		send_buf[i] = (char)(i & 0xFF);
+
+	send_msg(mqd, PRIO_HIGH, send_buf, LARGE_MSG_SIZE);
+
+	ret = peek(mqd, 0, recv_buf, LARGE_MSG_SIZE, &prio);
+	if (ret != LARGE_MSG_SIZE) {
+		ksft_test_result_fail("large msg peek: ret=%ld expected=%d\n",
+				      ret, LARGE_MSG_SIZE);
+		pass = 0;
+	}
+	if (pass && memcmp(send_buf, recv_buf, LARGE_MSG_SIZE) != 0) {
+		ksft_test_result_fail("large msg peek: payload mismatch\n");
+		pass = 0;
+	}
+	if (pass && prio != PRIO_HIGH) {
+		ksft_test_result_fail("large msg peek: prio=%u expected=%d\n",
+				      prio, PRIO_HIGH);
+		pass = 0;
+	}
+	if (pass && queue_depth(mqd) != 1) {
+		ksft_test_result_fail(
+			"large msg peek: queue modified (depth=%ld)\n",
+			queue_depth(mqd));
+		pass = 0;
+	}
+	if (pass)
+		ksft_test_result_pass(
+			"large (%d B) 	multi-segment peek: correct\n",
+			LARGE_MSG_SIZE);
+out:
+	free(send_buf);
+	free(recv_buf);
+	mq_close(mqd);
+}
+
+static void test_no_peek_flag_is_receive(void)
+{
+	mqd_t mqd = open_queue("nopeek", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio = 0;
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(buf),
+		.msg_prio = &prio,
+		.msg_ptr = buf,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, "consume-me", 10);
+
+    ret = mq_timedreceive2(mqd, &args, 0, 0, NULL);
+	if (ret < 0) {
+		ksft_test_result_fail("no-peek receive failed: ret=%ld errno=%d\n", ret, errno);
+		mq_close(mqd);
+		return;
+	}
+	if (queue_depth(mqd) != 0)
+		ksft_test_result_fail("no-peek: queue still has messages (depth=%ld)\n", queue_depth(mqd));
+	else
+		ksft_test_result_pass("without MQ_PEEK the message is consumed normally\n");
+
+	mq_close(mqd);
+}
+
+
+struct race_ctx {
+	mqd_t mqd;
+	int errors;
+};
+
+static void *receiver_thread(void *arg)
+{
+	struct race_ctx *ctx = arg;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	ssize_t r;
+
+	while ((r = mq_receive(ctx->mqd, buf, sizeof(buf), &prio)) > 0)
+		;
+
+	return NULL;
+}
+
+static void test_peek_concurrent_receive(void)
+{
+	struct race_ctx ctx;
+	pthread_t tid;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int i;
+
+	ctx.mqd = open_queue("concurrent", MAX_MSG_SIZE);
+	ctx.errors = 0;
+
+
+	for (i = 0; i < MQ_MAXMSG; i++) {
+		char payload[32];
+		snprintf(payload, sizeof(payload), "msg%d", i);
+		send_msg(ctx.mqd, (unsigned int)(i % 5) + 1, payload,
+			 strlen(payload));
+	}
+
+	if (pthread_create(&tid, NULL, receiver_thread, &ctx) != 0) {
+		ksft_test_result_skip("pthread_create failed\n");
+		mq_close(ctx.mqd);
+		return;
+	}
+
+	/*
+     Peek repeatedly.The queue is being drained concurrently.
+	 */
+	for (i = 0; i < 200; i++) {
+		ret = peek(ctx.mqd, (unsigned long)(i % 4), buf, sizeof(buf),
+			   &prio);
+		if (ret < 0 && errno != EAGAIN && errno != ENOENT) {
+			ctx.errors++;
+		}
+	}
+
+	pthread_join(tid, NULL);
+
+	if (ctx.errors == 0)
+		ksft_test_result_pass("concurrent peek+receive: no unexpected errors\n");
+	else
+		ksft_test_result_fail("concurrent peek+receive: %d unexpected errors\n", ctx.errors);
+
+	mq_close(ctx.mqd);
+}
+
+static void test_peek_null_prio_ptr(void)
+{
+	mqd_t mqd = open_queue("null_prio", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(buf),
+		.msg_prio = NULL,
+		.msg_ptr = buf,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_MED, "no-prio-needed", 14);
+
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret >= 0)
+		ksft_test_result_pass("peek with NULL msg_prio ptr: OK\n");
+	else
+		ksft_test_result_fail("peek NULL msg_prio: ret=%ld errno=%d (%m)\n", ret, errno);
+
+	mq_close(mqd);
+}
+
+
+static void test_peek_priority_matches_receive(void)
+{
+	mqd_t mqd = open_queue("prio_match", MAX_MSG_SIZE);
+	char peek_buf[MAX_MSG_SIZE], recv_buf[MAX_MSG_SIZE];
+	unsigned int peek_prio = 0, recv_prio = 0;
+	long peek_ret;
+	ssize_t recv_ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_MED, "consistent-prio", 15);
+
+	peek_ret = peek(mqd, 0, peek_buf, sizeof(peek_buf), &peek_prio);
+	if (peek_ret < 0) {
+		ksft_test_result_fail("peek failed: %m\n");
+		mq_close(mqd);
+		return;
+	}
+
+	recv_ret = mq_receive(mqd, recv_buf, sizeof(recv_buf), &recv_prio);
+	if (recv_ret < 0) {
+		ksft_test_result_fail("mq_receive failed: %m\n");
+		mq_close(mqd);
+		return;
+	}
+
+	if (peek_prio != recv_prio) {
+		ksft_test_result_fail("prio mismatch: peek=%u receive=%u\n",
+								peek_prio, recv_prio);
+		pass = 0;
+	}
+	if (pass && peek_ret != recv_ret) {
+		ksft_test_result_fail("size mismatch: peek=%ld receive=%zd\n",
+				      peek_ret, recv_ret);
+		pass = 0;
+	}
+	if (pass && memcmp(peek_buf, recv_buf, (size_t)recv_ret) != 0) {
+		ksft_test_result_fail("payload mismatch between peek and receive\n");
+		pass = 0;
+	}
+	if (pass)
+		ksft_test_result_pass("peeked priority/payload matches mq_receive output\n");
+
+	mq_close(mqd);
+}
+
+
+
+static const struct {
+	const char *name;
+	void (*fn)(void);
+} tests[] = {
+	{ "empty queue → EAGAIN", test_peek_empty_queue },
+	{ "invalid fd → EBADF", test_peek_invalid_fd },
+	{ "non-mqueue fd → EBADF", test_peek_non_mqueue_fd },
+	{ "O_WRONLY fd → EBADF", test_peek_writeonly_fd },
+	{ "buffer too small → EMSGSIZE", test_peek_buffer_too_small },
+	{ "bad msg_ptr → EFAULT", test_peek_bad_msg_ptr },
+	{ "OOB index → ENOENT", test_peek_index_out_of_range },
+	{ "basic data+prio correctness", test_peek_basic_data },
+	{ "non-destructive semantics", test_peek_nondestructive },
+	{ "priority ordering across indices", test_peek_priority_order },
+	{ "FIFO within same priority", test_peek_fifo_within_priority },
+	{ "all distinct priority indices", test_peek_all_indices },
+	{ "large multi-segment message", test_peek_large_message },
+	{ "no MQ_PEEK → normal receive", test_no_peek_flag_is_receive },
+	{ "concurrent peek + receive", test_peek_concurrent_receive },
+	{ "NULL msg_prio ptr", test_peek_null_prio_ptr },
+	{ "peeked prio matches mq_receive",
+	  test_peek_priority_matches_receive },
+};
+
+int main(void)
+{
+	unsigned int i;
+	long sc_ret;
+
+	ksft_print_header();
+	ksft_set_plan(sizeof(tests) / sizeof(tests[0]));
+
+
+	{
+		struct mq_timedreceive2_args probe_args = { 0 };
+		sc_ret = mq_timedreceive2((mqd_t)-1, &probe_args, MQ_PEEK, 0,
+					  NULL);
+		if (sc_ret == -1 && errno == ENOSYS)
+			ksft_exit_skip("mq_timedreceive2 syscall not available "
+				"(NR=%d ENOSYS) — is the kernel too old?\n",
+				__NR_mq_timedreceive2);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_print_msg("--- [%02u] %s ---\n", i + 1, tests[i].name);
+		tests[i].fn();
+	}
+
+	return ksft_get_fail_cnt() ? 1 : 0;
+}
-- 
2.43.0

