Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57814 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932113AbWJ1XJV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 19:09:21 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9SN9BtA030799
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 19:09:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9SN9BoY527296
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 17:09:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9SN9B7Z030434
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 17:09:11 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Date: Sun, 29 Oct 2006 01:09:08 +0200
References: <20061028223730.GC3243@athena.road.mcmartin.ca>
In-Reply-To: <20061028223730.GC3243@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610290109.08844.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 29 October 2006 00:37, Kyle McMartin wrote:
> +asmlinkage long compat_sys_rt_sigqueueinfo(int pid, int sig,
> +       struct compat_siginfo __user *uinfo)
> +{
> +       mm_segment_t old_fs = get_fs();
> +       siginfo_t info;
> +       int ret;
> +
> +       if (copy_siginfo_from_user32(&info, uinfo))
> +               return -EFAULT;
> +
> +       set_fs(KERNEL_DS);
> +       ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *)&info);
> +       set_fs(old_fs);
> +
> +       return ret;
> +}

Since sys_rt_sigqueueinfo() is so simple, I think it would be much
better to define the common version as 

asmlinkage long
sys_rt_sigqueueinfo(int pid, int sig, siginfo_t __user *uinfo)
{
	siginfo_t info;

	if (compat_copy_siginfo_from_user(&info, uinfo))
		return -EFAULT;

	/* Not even root can pretend to send signals from the kernel.
	   Nor can they impersonate a kill(), which adds source info.  */
	if (info.si_code >= 0)
		return -EPERM;
	info.si_signo = sig;

	/* POSIX.1b doesn't mention process groups.  */
	return kill_proc_info(sig, &info, pid);
}

	Arnd <><
