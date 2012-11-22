From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 18/40] metag: System Calls
Date: Thu, 22 Nov 2012 12:01:15 +0000
Message-ID: <50AE140B.2080208@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-19-git-send-email-james.hogan@imgtec.com> <201211091420.19999.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56897 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965099Ab2KVTRA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Nov 2012 14:17:00 -0500
In-Reply-To: <201211091420.19999.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Hi Arnd,

On 09/11/12 14:20, Arnd Bergmann wrote:
> On Wednesday 31 October 2012, James Hogan wrote:
> 
>> +/* kernel/signal.c */
>> +asmlinkage int sys_sigaltstack(const stack_t __user *, stack_t __user *,
>> +			       unsigned long, unsigned long,
>> +			       unsigned long, unsigned long,
>> +			       struct pt_regs *);
>> +asmlinkage int sys_rt_sigreturn(unsigned long, unsigned long,
>> +				unsigned long, unsigned long,
>> +				unsigned long, unsigned long,
>> +				struct pt_regs *);
>> +asmlinkage long sys_rt_sigaction(int sig,
>> +				 const struct sigaction __user *act,
>> +				 struct sigaction __user *oact,
>> +				 size_t sigsetsize);
>> +asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset,
>> +				  size_t sigsetsize);
>> +asmlinkage long sys_rt_tgsigqueueinfo(pid_t, pid_t, int, siginfo_t __user *);
> 
> Can't you use the declarations from asm-generic/syscalls.h for these?

Thanks. I'll use that.

>>> +asmlinkage long sys32_truncate64(const char __user *, unsigned long,
>> +				 unsigned long);
>> +asmlinkage long sys32_ftruncate64(unsigned int, unsigned long,
>> +				  unsigned long);
>> +asmlinkage long sys32_fadvise64_64(int, unsigned long, unsigned long,
>> +				   unsigned long, unsigned long, int);
>> +asmlinkage long sys32_readahead(int, unsigned long, unsigned long, size_t);
>> +asmlinkage ssize_t sys32_pread64(unsigned long, char __user *, size_t,
>> +				 unsigned long, unsigned long);
>> +asmlinkage ssize_t sys32_pwrite64(unsigned long, char __user *, size_t,
>> +				  unsigned long, unsigned long);
>> +asmlinkage long sys32_sync_file_range(int, unsigned long, unsigned long,
>> +				      unsigned long, unsigned long,
>> +				      unsigned int);
> 
> These confused me a bit. The sys32_* notation is traditionally used for
> 32 bit compatibility functions on 64 bit architectures. Maybe it's better
> to name these sys_meta_* instead.

Okay, I'll probably go with sys_*64_metag to match c6x.

> 
>> +asmlinkage int sys_metag_spinlock(int __user *spinlock)
>> +{
>> +	int ret = 0, tmp;
>> +
>> +	local_irq_disable();
>> +	get_user(tmp, spinlock);
>> +	if (tmp)
>> +		ret = 1;
>> +	tmp = 1;
>> +	put_user(tmp, spinlock);
>> +	local_irq_enable();
>> +	return ret;
>> +}
> 
> This seems to be a specialization of a cmpxchg() function. How about
> implementing cmpxchg semantics instead? It should be more flexible
> for almost the same runtime cost.

This is a bit of a legacy syscall, and as of very recently it is no
longer used by up to date user software. The gateway page implements
cmpxchg semantics, so I'll drop this system call altogether.

Thanks for the comments
James
