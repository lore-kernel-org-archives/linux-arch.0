Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:27790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262455AbUCRJRi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 04:17:38 -0500
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id i2I9HbE15622
	for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2004 01:17:37 -0800
Date: Thu, 18 Mar 2004 01:17:43 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: compat_sys_sched_setaffinity()
Message-Id: <20040318011743.475153bf.akpm@osdl.org>
In-Reply-To: <20040318010531.1af5b0a9.akpm@osdl.org>
References: <20040318010531.1af5b0a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton <akpm@osdl.org> wrote:
>
> 
> This is broken for NR_CPUS > 64, is it not?
> 
> asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid, 
> 					     unsigned int len,
> 					     compat_ulong_t *user_mask_ptr)
> {
> 	unsigned long kernel_mask;
> 	mm_segment_t old_fs;
> 	int ret;
> 
> 	if (get_user(kernel_mask, user_mask_ptr))
> 		return -EFAULT;
> 
> 	old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> 	ret = sys_sched_setaffinity(pid,
> 				    sizeof(kernel_mask),
> 				    &kernel_mask);
> 	set_fs(old_fs);
> 
> 	return ret;
> }
> 

It also seems to be broken with NR_CPUS > 32.  The syscall API says
(implies?) that CPU 0 is the LSB of *user_mask_ptr.  On a big-endian 32-bit
app, an attempt to bind to CPU #0 will end up binding to CPU #33, methinks.


And it's potentially trying to copy more than `len' bytes from userspace so
it might incorrectly return -EFAULT.


And it's failing to check that len >= sizeof(cpumask_t).  If the user
passes in len==1, he gets bound to garbage CPUs.


Needs work.
