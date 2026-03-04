Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE43A6F10;
	Wed,  4 Mar 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648672; cv=none; b=h8JfeoWuRjRBimXMKwHyOAy4WF+AcYmc3v+uWBSlk8LSIR3NWbxe0R9FHYZjFdaaaG+7uXyMbYtznbwMrqKqbm8/dk791Jm1xcXRlaFb8KrWcvdwo1BqlCjlzBMvftt9eeyeVAAPb9HEoCCwxKgTuPMTvu8qKzW93V7qJ0rk+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648672; c=relaxed/simple;
	bh=X52ZPHFTiw4btiN2qBylA7cPx0ZJ7HvIeBfsmkj9cgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndodpte0FXBuUG9XiOlUt+EWf7TuAQTojFCpeUQhnjsiw7X/la9Ms/Ucnha1/vGs3ZyBSzzTLrF/NkFV5+OoRQX9xB3BJ1cbV1/oDZ49DQuubismuGo4gEWsI0z9sGL6BiZXx51IsdiOsSl1Y9i81FGUgLe2BIu8QO5jabEooTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o+FSQ0nv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o+FSQ0nv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HNpNhJIEQG7t1I+9WhldJ27xwkKDMYuJd+C3Vhkaw7Q=; b=o+FSQ0nv9+WkxqLgL98ghuoYOc
	FdbUSTBSmDn1wed3whiqPVI1KM8TZfehNgwXmEuTSffSYkMrYDXp+4K2erkycw9e+QEs672QrgLX7
	k3kaMwr5in+x6/vnzwg2OxKu1TUXdlxI6++oKQkSTeE9r57IUovkQxnqueDojHJxIW/q60NJHzbTM
	DphQ4O1GGFkkcm30/XqlJ9dZURwB9wnRhVI4kXJ3vk7O79hDP9/+QeKEuLReu0v+oirbkz1Ay74VA
	P/fVevAgQTMytZ2Rf3DYJJ6eIP+/HBBuSyMPCrLgj8TVg8Geb131SY+XkeQPZlDTImB2tB4HvGy0S
	2JT8l8Iw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxqtW-00000000Kdl-0KwW;
	Wed, 04 Mar 2026 18:24:26 +0000
Message-ID: <7811f15d-98f3-4af7-b9a4-b83d6be8ac1f@infradead.org>
Date: Wed, 4 Mar 2026 10:24:24 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mqueue: introduce new do_mq_timedreceive2() [ mq_peek
 syscall] for non-destructive receive and inspection
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <20260304135126.77270-1-academic1mathura@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260304135126.77270-1-academic1mathura@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/4/26 5:51 AM, Mathura_Kumar wrote:
>     POSIX message queues currently lack a mechanism to read
>     a message without removing it from the queue. This is a
>     long-standing limitation,when we require inspection of queue state
>     without altering it.
> 
>     Modifying existing mq_receive() semantics via additional
>     flags was considered. However, altering behavior of an
>     existing syscall risks breaking backward compatibility
>     for applications relying on current semantics. Since
>     mq_receive() guarantees message removal, changing this
>     contract is not safe.
> 
>     To preserve ABI stability, this patch introduces a new
>     system call that performs a non-destructive receive
>     operation (peek). The existing behavior remains unchanged.
> 
>     Design considerations:
> 
>     Two approaches for copying message data to userspace
>     were evaluated:
> 
>     1) Refcount-based message lifecycle handling
>        - This can help us  Avoids intermediate temp kernel copy
>        - Extends message lifetime
>        -But this may increase writer starvation under heavy load and
>         add unneassery complication on priority  management and
>         delay more time to free space in inode due refcount may prevent
> 
>     2) Temporary kernel buffer copy
>        - Copies message into a bounded kernel buffer
>        - Reduces time message remains locked
>        - Improves fairness under write-heavy workloads
>        - Simpler lifetime management
> 
>     My implementation adopts the temporary buffer approach
>     to minimize starvation and reduce locking complexity.
>     The design allows future transition if refcounting is
>     deemed preferable.
> 
>     Architecture support: Entry was made in relevant system call table
>       - x86
>       - ARM

I don't see any ARM changes in this patch.

>     Testing:
>       - 15+ functional test cases
>       - Multi-threaded producer/consumer scenarios
>       - concurrent pop and peek
>       - Edge cases: empty queue, FIFO
>         invalid flags, signal interruption etc.
> 
> Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  include/linux/syscalls.h               |   9 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  ipc/mqueue.c                           | 180 ++++++
>  ipc/msg.c                              |   2 +-
>  ipc/msgutil.c                          |  51 +-
>  ipc/util.h                             |   3 +-
>  tools/testing/selftests/ipc/.gitignore |   1 +
>  tools/testing/selftests/ipc/Makefile   |   5 +-
>  tools/testing/selftests/ipc/mq_peek.c  | 794 +++++++++++++++++++++++++
>  11 files changed, 1022 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/ipc/mq_peek.c
> 



> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 4798b375972b..f6c7462b818f 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -53,6 +53,7 @@ struct mqueue_fs_context {
>  
>  #define SEND		0
>  #define RECV		1
> +#define MQ_PEEK     2
>  
>  #define STATE_NONE	0
>  #define STATE_READY	1
> @@ -63,6 +64,12 @@ struct posix_msg_tree_node {
>  	int			priority;
>  };
>  
> +struct mq_timedreceive2_args {
> +	size_t msg_len;
> +	unsigned int  *msg_prio;
> +    char  *msg_ptr;

Indent above with tab, not spaces.

> +};
> +
>  /*
>   * Locking:
>   *
> @@ -1230,6 +1237,116 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  	return ret;
>  }
>  
> +static struct msg_msg *mq_peek_index(struct mqueue_inode_info *info, int index)
> +{
> +	struct rb_node *node;
> +	struct posix_msg_tree_node *leaf;
> +	struct msg_msg *msg;
> +	int count = 0;

Insert a blank line between data and code.

> +	/* Start from highest priority */
> +	node = rb_last(&info->msg_tree);
> +	while (node) {
> +		leaf = rb_entry(node, struct posix_msg_tree_node, rb_node);
> +		list_for_each_entry(msg, &leaf->msg_list, m_list) {
> +			if (count == index)
> +				return msg;
> +			count++;
> +		}
> +
> +		node = rb_prev(node);
> +	}
> +
> +	return NULL;
> +}
> +
> +static int do_mq_timedreceive2(mqd_t mqdes,
> +			       struct mq_timedreceive2_args __user *uargs,
> +			       unsigned int flags, unsigned long index,
> +			       struct timespec64 *ts)
> +{
> +	struct mq_timedreceive2_args args;
> +	ssize_t ret;
> +	struct msg_msg *msg_ptr, *k_msg_buffer;
> +	long k_m_type;
> +	size_t k_m_ts;
> +	struct inode *inode;
> +	struct mqueue_inode_info *info;
> +
> +	if (copy_from_user(&args, uargs, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (!(flags & MQ_PEEK)) {
> +		return do_mq_timedreceive(mqdes, args.msg_ptr, args.msg_len,
> +					  args.msg_prio, ts);
> +	}
> +	audit_mq_sendrecv(mqdes, args.msg_len, 0, ts);
> +	CLASS(fd, f)(mqdes);
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	inode = file_inode(fd_file(f));
> +	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations))
> +		return -EBADF;
> +	info = MQUEUE_I(inode);
> +	audit_file(fd_file(f));
> +
> +	if (unlikely(!(fd_file(f)->f_mode & FMODE_READ)))
> +		return -EBADF;
> +
> +	if (unlikely(args.msg_len < info->attr.mq_msgsize))
> +		return -EMSGSIZE;
> +	if (index >= (unsigned long)info->attr.mq_maxmsg)
> +		return -ENOENT;
> +
> +	spin_lock(&info->lock);
> +	if (info->attr.mq_curmsgs == 0) {
> +		spin_unlock(&info->lock);
> +		return -EAGAIN;
> +	}
> +	msg_ptr = mq_peek_index(info, index);
> +	if (!msg_ptr) {
> +		spin_unlock(&info->lock);
> +		return -ENOENT;
> +	}
> +	k_m_type = msg_ptr->m_type;
> +	k_m_ts = msg_ptr->m_ts;
> +	spin_unlock(&info->lock);
> +
> +	k_msg_buffer = alloc_msg(k_m_ts);
> +	if (!k_msg_buffer)
> +		return -ENOMEM;
> +
> +	/*Two spin lock is necessary we are avoiding atomic memory allocation
> +    *and to early allocation without confirming that , is even msg exists to peek
> +    */

Bad comment format and indentation.

> +	spin_lock(&info->lock);
> +	msg_ptr = mq_peek_index(info, index);
> +	if (!msg_ptr || msg_ptr->m_type != k_m_type ||
> +	    msg_ptr->m_ts != k_m_ts) {
> +		spin_unlock(&info->lock);
> +		free_msg(k_msg_buffer);
> +		return -EAGAIN;
> +	}
> +	if (IS_ERR(copy_msg(msg_ptr, k_msg_buffer, k_m_ts))) {
> +		spin_unlock(&info->lock);
> +		free_msg(k_msg_buffer);
> +		return -EINVAL;
> +	}
> +	spin_unlock(&info->lock);
> +
> +	ret = k_msg_buffer->m_ts;
> +	if (args.msg_prio && put_user(k_m_type, args.msg_prio)) {
> +		free_msg(k_msg_buffer);
> +		return -EFAULT;
> +	}
> +	if (store_msg(args.msg_ptr, k_msg_buffer, k_m_ts)) {
> +		free_msg(k_msg_buffer);
> +		return -EFAULT;
> +	}
> +	free_msg(k_msg_buffer);
> +	return ret;
> +}
> +
>  SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
>  		size_t, msg_len, unsigned int, msg_prio,
>  		const struct __kernel_timespec __user *, u_abs_timeout)
> @@ -1258,6 +1375,23 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
>  	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
>  }
>  

Please add kernel-doc comments to describe the function and its arguments.
Or if not kernel-doc comments, then some kind of API documentation.

> +SYSCALL_DEFINE5(mq_timedreceive2, mqd_t, mqdes,
> +		struct mq_timedreceive2_args __user *, uargs, unsigned int,
> +		flags, const unsigned long, index,
> +		const struct __kernel_timespec __user *, u_abs_timeout)
> +{
> +	struct timespec64 ts, *p = NULL;
> +
> +	if (u_abs_timeout) {
> +		int res = prepare_timeout(u_abs_timeout, &ts);
> +
> +		if (res)
> +			return res;
> +		p = &ts;
> +	}
> +	return do_mq_timedreceive2(mqdes, uargs, flags, index, p);
> +}
> +
>  /*
>   * Notes: the case when user wants us to deregister (with NULL as pointer)
>   * and he isn't currently owner of notification, will be silently discarded.
> @@ -1450,6 +1584,7 @@ SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
>  }
>  
>  #ifdef CONFIG_COMPAT
> +#include "asm-generic/compat.h"
>  
>  struct compat_mq_attr {
>  	compat_long_t mq_flags;      /* message queue flags		     */
> @@ -1459,6 +1594,12 @@ struct compat_mq_attr {
>  	compat_long_t __reserved[4]; /* ignored for input, zeroed for output */
>  };
>  
> +struct compat_mq_timedreceive2_args {
> +	compat_size_t msg_len;
> +	compat_uptr_t msg_prio;
> +	compat_uptr_t msg_ptr;
> +};
> +
>  static inline int get_compat_mq_attr(struct mq_attr *attr,
>  			const struct compat_mq_attr __user *uattr)
>  {
> @@ -1490,6 +1631,22 @@ static inline int put_compat_mq_attr(const struct mq_attr *attr,
>  	return 0;
>  }
>  
> +static inline int get_compat_mq_args(struct mq_timedreceive2_args *args,
> +					struct compat_mq_timedreceive2_args __user *uargs)
> +{
> +	struct compat_mq_timedreceive2_args v;
> +
> +	if (copy_from_user(&v, uargs, sizeof(*uargs)))
> +		return -EFAULT;
> +
> +	memset(args, 0, sizeof(*args));
> +	args->msg_len = (size_t)compat_ptr(v.msg_len);
> +	args->msg_prio = (unsigned int *)compat_ptr(v.msg_prio);
> +	args->msg_ptr = (char *)compat_ptr(v.msg_ptr);
> +
> +	return 0;
> +}
> +
>  COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
>  		       int, oflag, compat_mode_t, mode,
>  		       struct compat_mq_attr __user *, u_attr)
> @@ -1583,6 +1740,29 @@ SYSCALL_DEFINE5(mq_timedreceive_time32, mqd_t, mqdes,
>  	}
>  	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
>  }
> +

Add kernel-doc comments here also.

> +SYSCALL_DEFINE5(mq_timedreceive2_time32, mqd_t, mqdes,
> +		struct compat_mq_timedreceive2_args __user *, uargs,
> +		unsigned int, flags, const unsigned long, index,
> +		const struct old_timespec32 __user *, u_abs_timeout)
> +{


> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index e28f0cecb2ec..8c8622b78f12 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -51,7 +51,7 @@ static int __init init_msg_buckets(void)
>  }
>  subsys_initcall(init_msg_buckets);
>  
> -static struct msg_msg *alloc_msg(size_t len)
> +struct msg_msg *alloc_msg(size_t len)
>  {
>  	struct msg_msg *msg;
>  	struct msg_msgseg **pseg;
> @@ -122,39 +122,34 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
>  	free_msg(msg);
>  	return ERR_PTR(err);
>  }
> -#ifdef CONFIG_CHECKPOINT_RESTORE
> -struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst)
> +
> +struct msg_msg *copy_msg(struct msg_msg *src,
> +							struct msg_msg *dst,
> +						size_t len)

Strange indentation.

>  {

-- 
~Randy

