Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:12423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262109AbUCRJF0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 04:05:26 -0500
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id i2I95PE14072
	for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2004 01:05:25 -0800
Date: Thu, 18 Mar 2004 01:05:31 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: compat_sys_sched_setaffinity()
Message-Id: <20040318010531.1af5b0a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


This is broken for NR_CPUS > 64, is it not?

asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid, 
					     unsigned int len,
					     compat_ulong_t *user_mask_ptr)
{
	unsigned long kernel_mask;
	mm_segment_t old_fs;
	int ret;

	if (get_user(kernel_mask, user_mask_ptr))
		return -EFAULT;

	old_fs = get_fs();
	set_fs(KERNEL_DS);
	ret = sys_sched_setaffinity(pid,
				    sizeof(kernel_mask),
				    &kernel_mask);
	set_fs(old_fs);

	return ret;
}
