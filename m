From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Thu, 29 Jun 2017 14:42:38 -0700 (PDT)
Message-ID: <mhng-21eaeea1-4cd1-43b1-9b2b-b664cea12d43@palmer-si-x1c4>
References: <20170628224237.GO6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36796 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdF2Vmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 17:42:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so14593661pfk.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 14:42:40 -0700 (PDT)
In-Reply-To: <20170628224237.GO6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 15:42:37 PDT (-0700), james.hogan@imgtec.com wrote:
> Hi Palmer,
>
> On Wed, Jun 28, 2017 at 11:55:37AM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/riscv/include/asm/syscalls.h b/arch/riscv/include/asm/syscalls.h
>> new file mode 100644
>> index 000000000000..d85267c4f7ea
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/syscalls.h
>> @@ -0,0 +1,25 @@
> ...
>> +/* kernel/sys_riscv.c */
>> +asmlinkage long sys_sysriscv(unsigned long, unsigned long,
>> +	unsigned long, unsigned long);
>
> You suggested in the cover letter this wasn't muxed any longer, maybe
> you should have a prototype for each of the cmpxchg syscalls instead?

Sorry, I just missed that.  I'll fix it for the v4

  diff --git a/arch/riscv/include/asm/syscalls.h b/arch/riscv/include/asm/syscalls.h
  index d85267c4f7ea..6490274fbb76 100644
  --- a/arch/riscv/include/asm/syscalls.h
  +++ b/arch/riscv/include/asm/syscalls.h
  @@ -19,7 +19,7 @@
   #include <asm-generic/syscalls.h>

   /* kernel/sys_riscv.c */
  -asmlinkage long sys_sysriscv(unsigned long, unsigned long,
  -       unsigned long, unsigned long);
  +asmlinkage long sys_sysriscv_cmpxchg32(u32 __user * ptr, u32 new, u32 old);
  +asmlinkage long sys_sysriscv_cmpxchg64(u64 __user * ptr, u64 new, u64 old);

   #endif /* _ASM_RISCV_SYSCALLS_H */

>> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
>> new file mode 100644
>> index 000000000000..01aee1654eae
>> --- /dev/null
>> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> ...
>> +struct __riscv_f_ext_state {
>> +	__u32 f[32];
>> +	__u32 fcsr;
>> +};
>> +
>> +struct __riscv_d_ext_state {
>> +	__u64 f[32];
>> +	__u32 fcsr;
>> +};
>> +
>> +struct __riscv_q_ext_state {
>> +	__u64 f[64] __attribute__((aligned(16)));
>> +	__u32 fcsr;
>> +	/* Reserved for expansion of sigcontext structure.  Currently zeroed
>> +	 * upon signal, and must be zero upon sigreturn.  */
>> +	__u32 reserved[3];
>> +};
>> +
>> +union __riscv_fp_state {
>> +	struct __riscv_f_ext_state f;
>> +	struct __riscv_d_ext_state d;
>> +	struct __riscv_q_ext_state q;
>> +};
>
> Out of interest, how does one tell which fp format is in use?

We might need another tag here -- I'll talk to Andrew (who did the glibc side
of this) and make sure we can handle something like running F user code on a D
kernel.

>> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
>> new file mode 100644
>> index 000000000000..52eff9febcfd
>> --- /dev/null
>> +++ b/arch/riscv/include/uapi/asm/ucontext.h
> ...
>> +struct ucontext {
>> +	unsigned long	  uc_flags;
>> +	struct ucontext	 *uc_link;
>> +	stack_t		  uc_stack;
>> +	sigset_t	  uc_sigmask;
>> +	/* glibc uses a 1024-bit sigset_t */
>> +	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
>> +	/* last for future expansion */
>> +	struct sigcontext uc_mcontext;
>> +};
>
> Any particular reason not to use the asm-generic ucontext?

In the generic ucontext, 'uc_sigmask' is at the end of the structure so it can
be expanded.  Since we want our mcontext to be expandable as well, we
pre-allocate some expandable space for sigmask and then put mcontext at the
end.

We stole this idea from arm64.

>> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
>> new file mode 100644
>> index 000000000000..7e3909ac3c18
>> --- /dev/null
>> +++ b/arch/riscv/include/uapi/asm/unistd.h
> ...
>> +/* FIXME: This exists for now in order to maintain compatibility with our
>> + * pre-upstream glibc, and will be removed for our real Linux submission.
>> + */
>> +#define __ARCH_WANT_RENAMEAT
>> +
>
> Don't forget ;-)
>
> Have you seen the patches floating around for dropping
> getrlimit/setrlimit (in favour of prlimit64) and fstatat64/fstat64 (in
> favour of statx)? I guess its no big deal.

Yes, but we're trying to make this glibc release so we decided to hold off on
them.  If we can't make it then we might reconsider, but they seem like fairly
small issues.

>> +#include <asm-generic/unistd.h>
>> +
>> +/*
>> + * These system calls add support for AMOs on RISC-V systems without support
>> + * for the A extension.
>> + */
>> +#define __NR_sysriscv_cmpxchg32		(__NR_arch_specific_syscall + 0)
>> +#define __NR_sysriscv_cmpxchg64		(__NR_arch_specific_syscall + 1)
>
> I think you need the magic __SYSCALL invocations here like in
> include/uapi/asm/unistd.h, otherwise they won't get included in your
> syscall table.

OK, I've added those.

  diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
  index 7e3909ac3c18..3cdb32912ac7 100644
  --- a/arch/riscv/include/uapi/asm/unistd.h
  +++ b/arch/riscv/include/uapi/asm/unistd.h
  @@ -23,4 +23,6 @@
    * for the A extension.
    */
   #define __NR_sysriscv_cmpxchg32                (__NR_arch_specific_syscall + 0)
  +__SYSCALL(__NR_sysriscv_cmpxchg32, sys_sysriscv_cmpxchg32)
   #define __NR_sysriscv_cmpxchg64                (__NR_arch_specific_syscall + 1)
  +__SYSCALL(__NR_sysriscv_cmpxchg64, sys_sysriscv_cmpxchg64)

>> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>> new file mode 100644
>> index 000000000000..69b3b2d10664
>> --- /dev/null
>> +++ b/arch/riscv/kernel/ptrace.c
> ...
>> +enum riscv_regset {
>> +	REGSET_X,
>> +};
>> +
>> +/*
>> + * Get registers from task and ready the result for userspace.
>> + */
>> +static char *getregs(struct task_struct *child, struct pt_regs *uregs)
>> +{
>> +	*uregs = *task_pt_regs(child);
>> +	return (char *)uregs;
>> +}
>> +
>> +/* Put registers back to task. */
>> +static void putregs(struct task_struct *child, struct pt_regs *uregs)
>> +{
>> +	struct pt_regs *regs = task_pt_regs(child);
>> +	*regs = *uregs;
>> +}
>> +
>> +static int riscv_gpr_get(struct task_struct *target,
>> +			 const struct user_regset *regset,
>> +			 unsigned int pos, unsigned int count,
>> +			 void *kbuf, void __user *ubuf)
>> +{
>> +	struct pt_regs regs;
>> +
>> +	getregs(target, &regs);
>> +
>> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &regs, 0,
>> +				   sizeof(regs));
>
> Shouldn't this be limited to sizeof(struct user_regs_struct)?
>
> Why not copy straight out of task_pt_regs(target) instead of bouncing
> via the stack?

IIRC this code used to be more complicated as it supported the two different
ptrace register APIs.  There's no reason to have this function now, so I've
just pulled into the only caller.

>> +}
>> +
>> +static int riscv_gpr_set(struct task_struct *target,
>> +			 const struct user_regset *regset,
>> +			 unsigned int pos, unsigned int count,
>> +			 const void *kbuf, const void __user *ubuf)
>> +{
>> +	int ret;
>> +	struct pt_regs regs;
>> +
>> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0,
>> +				 sizeof(regs));
>
> likewise.
>
> In fact if userland supplies insufficient data then this looks
> vulnerable to a kernel stack data leak, since regs will remain partially
> uninitialised and then get written to the target regs where it can be
> read back again.
>
> If you're going to bounce via the stack I think you need to fully
> initialise before using user_regset_copyin, or you could just copy
> directly into task_pt_regs(target) for now since, at least for the
> current internal struct pt_regs, the begining of pt_regs appears to
> match user_regs_struct.
>
>> +	if (ret)
>> +		return ret;
>> +
>> +	putregs(target, &regs);
>
> Similarly this needs to be careful not to overwrite the supervisor
> registers with whatever was on kernel stack (assuming only partially
> copied as suggested above)?
>
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static const struct user_regset riscv_user_regset[] = {
>> +	[REGSET_X] = {
>> +		.core_note_type = NT_PRSTATUS,
>> +		.n = ELF_NGREG,
>> +		.size = sizeof(elf_greg_t),
>> +		.align = sizeof(elf_greg_t),
>> +		.get = &riscv_gpr_get,
>> +		.set = &riscv_gpr_set,
>> +	},
>
> Will the FP registers get exposed at some point as well?
>
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> new file mode 100644
>> index 000000000000..ab699efe636e
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sys_riscv.c
> ...
>> +SYSCALL_DEFINE3(sysriscv_cmpxchg32, unsigned long, arg1, unsigned long, arg2,
>> +		unsigned long, arg3)
>> +{
>> +	unsigned long flags;
>> +	unsigned long prev;
>
> should that be unsigned int? Else on 64-bit half of it could be left
> uninitialised.
>
>> +	unsigned int *ptr;
>
> should that be tagged with __user?
>
>> +	unsigned int err;
>> +
>> +	ptr = (unsigned int *)arg1;
>
> I presume you'll need to cast to __user __force to keep sparse happy
> here.

This should be fixed, I was just lazy when converting from the multiplexed
syscall version.

>
>> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
>> +		return -EFAULT;
>> +
>> +	preempt_disable();
>> +	raw_local_irq_save(flags);
>> +	err = __get_user(prev, ptr);
>> +	if (likely(!err && prev == arg2))
>> +		err = __put_user(arg3, ptr);
>> +	raw_local_irq_restore(flags);
>> +	preempt_enable();
>
> Are user accesses safe from atomic context? What if it needs paging in?
>
> You could disable page faults but then I think you'd have to handle the
> EFAULT again outside of atomic context to try getting it paged in, and
> then retry in atomic context. Or perhaps there's a cleaner way that
> doesn't come to mind late at night.
>
> I'm not sure OTOH whether copy on write (i.e. affecting the __put_user()
> but not the __get_user() would be problematic. I suppose as long as it
> can safely allocate a page it should be fine... Should be possible to
> test using madvise(MADV_DONTNEED) (which I think makes pages use the
> zero page with copy-on-write).
>
> Also if this is going to be included on SMP kernels (where I gather
> proper atomics are available), does it need an SMP safe version too
> which uses proper atomics?

On 64-bit machines with the A extension (which is required for SMP) then that's
the right thing to do -- we're actually doing it in the VDSO right now, but
there's no reason not to do it in the syscall as well.

On 32-bit machines, I think it's still not safe as we don't have a 64-bit CAS
even with the A extension.  I think the best thing to do is actually to
disallow the 64-bit CAS on 32-bit machines -- we could disallow this on just
SMP machines, but I think it's saner do disallow it everywhere so we don't end
up with binaries that won't run on SMP kernels.

I'll try to figure out if userspace can work without it, but I think it should
be OK as we don't have double-word CAS on 64-bit.

>> +
>> +	return unlikely(err) ? err : prev;
>> +}
>> +
>> +SYSCALL_DEFINE3(sysriscv_cmpxchg64, unsigned long, arg1, unsigned long, arg2,
>> +		unsigned long, arg3)
>> +{
>> +	unsigned long flags;
>> +	unsigned long prev;
>> +	unsigned int *ptr;
>
> should that be unsigned long __user *?
>
>> +	unsigned int err;
>> +
>> +	ptr = (unsigned int *)arg1;
>> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
>> +		return -EFAULT;
>> +
>> +	preempt_disable();
>> +	raw_local_irq_save(flags);
>> +	err = __get_user(prev, ptr);
>> +	if (likely(!err && prev == arg2))
>> +		err = __put_user(arg3, ptr);
>> +	raw_local_irq_restore(flags);
>> +	preempt_enable();
>
> Likewise to other comments above.
>
> This doesn't look much different to sysriscv_cmpxchg32 on 32-bit. Is it
> meant to be excluded from 32-bit kernels? If so definition of the __NR_
> constant and the __SYSCALL magic in uapi/asm/unistd.h should I presume
> be conditional on the ABI.

Sorry, that was just a copy-and-paste error.  This is intended to actually be a
64-bit CAS on 32-bit machines -- though maybe that was a bad idea.
