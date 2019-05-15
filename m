Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEOOj1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 May 2019 10:39:27 -0400
Date: Wed, 15 May 2019 16:38:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515143857.GB18892@redhat.com>
References: <20190515100400.3450-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515100400.3450-1-christian@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: jannh@google.com, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org, cyphar@cyphar.com, ebiederm@xmission.com, elena.reshetova@intel.com, keescook@chromium.org, luto@amacapital.net, luto@kernel.org, tglx@linutronix.de, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <20190515143858.GqLJVahfB4Ahn2A2501DBrYlTOJuKyZZhfVto4QabkQ@z>

On 05/15, Christian Brauner wrote:
>
> +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> +{
> +	int fd, ret;
> +	struct pid *p;
> +	struct task_struct *tsk;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (pid <= 0)
> +		return -EINVAL;
> +
> +	p = find_get_pid(pid);
> +	if (!p)
> +		return -ESRCH;
> +
> +	rcu_read_lock();
> +	tsk = pid_task(p, PIDTYPE_PID);

You do not need find_get_pid() before rcu_lock and put_pid() at the end.
You can just do find_vpid() under rcu_read_lock().

> +	if (!tsk)
> +		ret = -ESRCH;
> +	else if (unlikely(!thread_group_leader(tsk)))
> +		ret = -EINVAL;

it seems that you can do a single check

	tsk = pid_task(p, PIDTYPE_TGID);
	if (!tsk)
		ret = -ESRCH;

this even looks more correct if we race with exec changing the leader.

Oleg.
