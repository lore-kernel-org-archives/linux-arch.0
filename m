From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 5 Jul 2017 11:24:33 +0100
Message-ID: <20170705102433.GC6973@jhogan-linux.le.imgtec.org>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnqofTe3AZPmi90i"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:8243 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751699AbdGEKYg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 06:24:36 -0400
Content-Disposition: inline
In-Reply-To: <20170704195102.3974-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

--RnqofTe3AZPmi90i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jul 04, 2017 at 12:51:01PM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> new file mode 100644
> index 000000000000..2720d5e97354
> --- /dev/null
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -0,0 +1,138 @@

> +/* Put registers back to task. */
> +static void putregs(struct task_struct *child, struct pt_regs *uregs)
> +{
> +	struct pt_regs *regs = task_pt_regs(child);
> +	*regs = *uregs;
> +}
> +
> +static int riscv_gpr_get(struct task_struct *target,
> +			 const struct user_regset *regset,
> +			 unsigned int pos, unsigned int count,
> +			 void *kbuf, void __user *ubuf)
> +{
> +	struct pt_regs *regs;
> +
> +	regs = task_pt_regs(target);
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs, 0,
> +				   sizeof(*regs));

sizeof(struct pt_regs) > sizeof(struct user_regs_struct), which allows
supervisor registers to be copied too. I think you should be using
sizeof(struct user_regs_struct) instead.

> +}
> +
> +static int riscv_gpr_set(struct task_struct *target,
> +			 const struct user_regset *regset,
> +			 unsigned int pos, unsigned int count,
> +			 const void *kbuf, const void __user *ubuf)
> +{
> +	int ret;
> +	struct pt_regs regs;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0,
> +				 sizeof(regs));

same

> +	if (ret)
> +		return ret;
> +
> +	putregs(target, &regs);

you're still copying via the stack without initialising the non-written
fields. If userland does a short PTRACE_SETREGSET the remaining fields
will be copied from the uninitialised kernel stack and accessible to
userland via PTRACE_GETREGSET.

Even if the user does a full sizeof(struct user_regs_struct) (not
pt_regs) PTRACE_SETREGSET the supervisor registers will be overwritten
with uninitialised stack content.

> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> new file mode 100644
> index 000000000000..4419604ff46c
> --- /dev/null
> +++ b/arch/riscv/kernel/sys_riscv.c

> +SYSCALL_DEFINE3(sysriscv_cmpxchg32, u32 __user *, ptr, u32, new, u32, old)
> +{
> +	u32 prev;
> +	unsigned int err;
> +
> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)))
> +		return -EFAULT;
> +
> +#ifdef CONFIG_ISA_A
> +	err = 0;
> +	prev = cmpxchg32(ptr, old, new);

I think this needs a special version of cmpxchg (or for cmpxchg to be
modified) with fixup protection to return -EFAULT in case the page isn't
mapped or is paged out/read only.

> +#else
> +	preempt_disable();
> +	err = __get_user(prev, ptr);
> +	if (likely(!err && prev == old))
> +		err = __put_user(new, ptr);
> +	preempt_enable();
> +#endif
> +
> +	return unlikely(err) ? err : prev;
> +}
> +
> +SYSCALL_DEFINE3(sysriscv_cmpxchg64, u64 __user *, ptr, u64, new, u64, old)
> +{
> +#ifdef CONFIG_64BIT
> +	u64 prev;
> +	unsigned int err;
> +
> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(*ptr)))
> +		return -EFAULT;
> +
> +#ifdef CONFIG_ISA_A
> +	err = 0;
> +	prev = cmpxchg64(ptr, old, new);

Likewise

> +#else
> +	preempt_disable();
> +	err = __get_user(prev, ptr);
> +	if (likely(!err && prev == old))
> +		err = __put_user(new, ptr);
> +	preempt_enable();
> +#endif
> +	return unlikely(err) ? err : prev;
> +#else
> +	return -ENOTSUPP;

I think -ENOSYS is more standard for missing/unimplemented system calls.

A better way IMO would be to #ifdef the definitions in unistd.h, then
the __NR_* definitions could also be more accurately extracted from the
kernel headers, and you could just ifdef CONFIG_64BIT the whole syscall
implementation, i.e.:

> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..37a5429cc896
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/unistd.h
> @@ -0,0 +1,23 @@

> +/*
> + * These system calls add support for AMOs on RISC-V systems without support
> + * for the A extension.
> + */
> +#define __NR_sysriscv_cmpxchg32		(__NR_arch_specific_syscall + 0)
> +__SYSCALL(__NR_sysriscv_cmpxchg32, sys_sysriscv_cmpxchg32)

+ifdef WHATEVER_BUILTIN_GCC_DEFINES_FOR_64BIT_RISCV_ABI

In case its helpful the following should list builtin preprocessor
defines for given CFLAGS:
${CROSS_COMPILE}gcc ${CFLAGS} -dM -E -</dev/null

> +#define __NR_sysriscv_cmpxchg64		(__NR_arch_specific_syscall + 1)
> +__SYSCALL(__NR_sysriscv_cmpxchg64, sys_sysriscv_cmpxchg64)

+endif

Cheers
James

--RnqofTe3AZPmi90i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllcvlgACgkQbAtpk944
dnoxyQ//cYBO9fY1OynLI3WYXliJkLSsyUy34QRQnZ2dLHfPd44eEscx0Fwz4fDS
LMVkblV4bMxbKjkgmIFJN3zBoKb5hBPbSbOq6mZ9PMUdPCYF9IRSp0T4Z328T+QX
7gwQDHYF8OBDbnbUcVXmklD+cdI0T8faq1Dn23JQDEgm9zQhpUL/MluONSCDgfTT
gS6SYZMbuPVj4VzeK+3QAUIPd17hXzeHp6K1D1pBD0/1BHlhrRbYZd/ZAb8ML6zQ
3hAf+Cua2wZYsdMyhWxjBvmwy0ekd5ViwAWUlg5PDEGt45SBofVqXiFnXKbBcFu6
2t5GM+SFDMRp7a0vhmd+lKT2JCckYaePRDIOkZVV/bi6DNwZch4ijJAfyneK8XE4
q+pprvOmPjEWjZqGSQaJ8W8/uS2Xu7ulUGwdt2/V5x9e96eD6Ioq8kBrc56Q2cOr
Yj9aabS748y/dcaUiVBf8kDprAlPiEeDWwAARdOxPkz9DIsu4GJneGhYm715O1vc
UEK7ScerLVOdyESNbn0zEBSJtC+CyH1bGEBRPFGtocqrlQfwodKzZW8o1fBbsCl2
9rYE+F2zP6wUErhoLzJbS7rhtU7uN89seUmtS41Zb4eJCv47TxccI24jg1JI0tIX
O4ukU1jGkiXbKAYuhRfrKZm0tKakTPNgxMN+qEa6hiV7/ExcWuY=
=eX0z
-----END PGP SIGNATURE-----

--RnqofTe3AZPmi90i--
