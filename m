From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 28 Jun 2017 23:42:37 +0100
Message-ID: <20170628224237.GO6973@jhogan-linux.le.imgtec.org>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v525F/vnNBtUxgKg"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:44344 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751629AbdF1Wmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 18:42:40 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Wed, Jun 28, 2017 at 11:55:37AM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/include/asm/syscalls.h b/arch/riscv/include/asm/s=
yscalls.h
> new file mode 100644
> index 000000000000..d85267c4f7ea
> --- /dev/null
> +++ b/arch/riscv/include/asm/syscalls.h
> @@ -0,0 +1,25 @@
=2E..
> +/* kernel/sys_riscv.c */
> +asmlinkage long sys_sysriscv(unsigned long, unsigned long,
> +	unsigned long, unsigned long);

You suggested in the cover letter this wasn't muxed any longer, maybe
you should have a prototype for each of the cmpxchg syscalls instead?

> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/ua=
pi/asm/ptrace.h
> new file mode 100644
> index 000000000000..01aee1654eae
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
=2E..
> +struct __riscv_f_ext_state {
> +	__u32 f[32];
> +	__u32 fcsr;
> +};
> +
> +struct __riscv_d_ext_state {
> +	__u64 f[32];
> +	__u32 fcsr;
> +};
> +
> +struct __riscv_q_ext_state {
> +	__u64 f[64] __attribute__((aligned(16)));
> +	__u32 fcsr;
> +	/* Reserved for expansion of sigcontext structure.  Currently zeroed
> +	 * upon signal, and must be zero upon sigreturn.  */
> +	__u32 reserved[3];
> +};
> +
> +union __riscv_fp_state {
> +	struct __riscv_f_ext_state f;
> +	struct __riscv_d_ext_state d;
> +	struct __riscv_q_ext_state q;
> +};

Out of interest, how does one tell which fp format is in use?

> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/=
uapi/asm/ucontext.h
> new file mode 100644
> index 000000000000..52eff9febcfd
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/ucontext.h
=2E..
> +struct ucontext {
> +	unsigned long	  uc_flags;
> +	struct ucontext	 *uc_link;
> +	stack_t		  uc_stack;
> +	sigset_t	  uc_sigmask;
> +	/* glibc uses a 1024-bit sigset_t */
> +	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> +	/* last for future expansion */
> +	struct sigcontext uc_mcontext;
> +};

Any particular reason not to use the asm-generic ucontext?

> diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/ua=
pi/asm/unistd.h
> new file mode 100644
> index 000000000000..7e3909ac3c18
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/unistd.h
=2E..
> +/* FIXME: This exists for now in order to maintain compatibility with our
> + * pre-upstream glibc, and will be removed for our real Linux submission.
> + */
> +#define __ARCH_WANT_RENAMEAT
> +

Don't forget ;-)

Have you seen the patches floating around for dropping
getrlimit/setrlimit (in favour of prlimit64) and fstatat64/fstat64 (in
favour of statx)? I guess its no big deal.

> +#include <asm-generic/unistd.h>
> +
> +/*
> + * These system calls add support for AMOs on RISC-V systems without sup=
port
> + * for the A extension.
> + */
> +#define __NR_sysriscv_cmpxchg32		(__NR_arch_specific_syscall + 0)
> +#define __NR_sysriscv_cmpxchg64		(__NR_arch_specific_syscall + 1)

I think you need the magic __SYSCALL invocations here like in
include/uapi/asm/unistd.h, otherwise they won't get included in your
syscall table.

> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> new file mode 100644
> index 000000000000..69b3b2d10664
> --- /dev/null
> +++ b/arch/riscv/kernel/ptrace.c
=2E..
> +enum riscv_regset {
> +	REGSET_X,
> +};
> +
> +/*
> + * Get registers from task and ready the result for userspace.
> + */
> +static char *getregs(struct task_struct *child, struct pt_regs *uregs)
> +{
> +	*uregs =3D *task_pt_regs(child);
> +	return (char *)uregs;
> +}
> +
> +/* Put registers back to task. */
> +static void putregs(struct task_struct *child, struct pt_regs *uregs)
> +{
> +	struct pt_regs *regs =3D task_pt_regs(child);
> +	*regs =3D *uregs;
> +}
> +
> +static int riscv_gpr_get(struct task_struct *target,
> +			 const struct user_regset *regset,
> +			 unsigned int pos, unsigned int count,
> +			 void *kbuf, void __user *ubuf)
> +{
> +	struct pt_regs regs;
> +
> +	getregs(target, &regs);
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &regs, 0,
> +				   sizeof(regs));

Shouldn't this be limited to sizeof(struct user_regs_struct)?

Why not copy straight out of task_pt_regs(target) instead of bouncing
via the stack?

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
> +	ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0,
> +				 sizeof(regs));

likewise.

In fact if userland supplies insufficient data then this looks
vulnerable to a kernel stack data leak, since regs will remain partially
uninitialised and then get written to the target regs where it can be
read back again.

If you're going to bounce via the stack I think you need to fully
initialise before using user_regset_copyin, or you could just copy
directly into task_pt_regs(target) for now since, at least for the
current internal struct pt_regs, the begining of pt_regs appears to
match user_regs_struct.

> +	if (ret)
> +		return ret;
> +
> +	putregs(target, &regs);

Similarly this needs to be careful not to overwrite the supervisor
registers with whatever was on kernel stack (assuming only partially
copied as suggested above)?

> +
> +	return 0;
> +}
> +
> +
> +static const struct user_regset riscv_user_regset[] =3D {
> +	[REGSET_X] =3D {
> +		.core_note_type =3D NT_PRSTATUS,
> +		.n =3D ELF_NGREG,
> +		.size =3D sizeof(elf_greg_t),
> +		.align =3D sizeof(elf_greg_t),
> +		.get =3D &riscv_gpr_get,
> +		.set =3D &riscv_gpr_set,
> +	},

Will the FP registers get exposed at some point as well?

> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> new file mode 100644
> index 000000000000..ab699efe636e
> --- /dev/null
> +++ b/arch/riscv/kernel/sys_riscv.c
=2E..
> +SYSCALL_DEFINE3(sysriscv_cmpxchg32, unsigned long, arg1, unsigned long, =
arg2,
> +		unsigned long, arg3)
> +{
> +	unsigned long flags;
> +	unsigned long prev;

should that be unsigned int? Else on 64-bit half of it could be left
uninitialised.

> +	unsigned int *ptr;

should that be tagged with __user?

> +	unsigned int err;
> +
> +	ptr =3D (unsigned int *)arg1;

I presume you'll need to cast to __user __force to keep sparse happy
here.

> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
> +		return -EFAULT;
> +
> +	preempt_disable();
> +	raw_local_irq_save(flags);
> +	err =3D __get_user(prev, ptr);
> +	if (likely(!err && prev =3D=3D arg2))
> +		err =3D __put_user(arg3, ptr);
> +	raw_local_irq_restore(flags);
> +	preempt_enable();

Are user accesses safe from atomic context? What if it needs paging in?=20

You could disable page faults but then I think you'd have to handle the
EFAULT again outside of atomic context to try getting it paged in, and
then retry in atomic context. Or perhaps there's a cleaner way that
doesn't come to mind late at night.

I'm not sure OTOH whether copy on write (i.e. affecting the __put_user()
but not the __get_user() would be problematic. I suppose as long as it
can safely allocate a page it should be fine... Should be possible to
test using madvise(MADV_DONTNEED) (which I think makes pages use the
zero page with copy-on-write).

Also if this is going to be included on SMP kernels (where I gather
proper atomics are available), does it need an SMP safe version too
which uses proper atomics?

> +
> +	return unlikely(err) ? err : prev;
> +}
> +
> +SYSCALL_DEFINE3(sysriscv_cmpxchg64, unsigned long, arg1, unsigned long, =
arg2,
> +		unsigned long, arg3)
> +{
> +	unsigned long flags;
> +	unsigned long prev;
> +	unsigned int *ptr;

should that be unsigned long __user *?

> +	unsigned int err;
> +
> +	ptr =3D (unsigned int *)arg1;
> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
> +		return -EFAULT;
> +
> +	preempt_disable();
> +	raw_local_irq_save(flags);
> +	err =3D __get_user(prev, ptr);
> +	if (likely(!err && prev =3D=3D arg2))
> +		err =3D __put_user(arg3, ptr);
> +	raw_local_irq_restore(flags);
> +	preempt_enable();

Likewise to other comments above.

This doesn't look much different to sysriscv_cmpxchg32 on 32-bit. Is it
meant to be excluded from 32-bit kernels? If so definition of the __NR_
constant and the __SYSCALL magic in uapi/asm/unistd.h should I presume
be conditional on the ABI.

> +
> +	return unlikely(err) ? err : prev;
> +}

Cheers
James

--v525F/vnNBtUxgKg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllUMNUACgkQbAtpk944
dno6MhAAj46wBJiTFH3N61+azzTUyFdxLR+gu9OjlOD4cLoBT+hqlEppCvXQfiza
3EivfFPX+h010qEmidTbz7SIMHd3vlqeaGYaSy4yr9YrmZan6395+ad5cPHDLqTj
ajBHF/C/2VfDcCVeqZ1/gIEv30XOb75VaSZemF6LtrqUsawEHlmywvkqsyOD+Q9d
1uVtDCsjen0JwDZDqBc3VvJGj6JAlaYM02R6rMvf5nptJdeiUvISFAURjS9H3cH7
pXWfo340DkKIlR2QqbfErs0xQx0fLP+2nJ9SDv8veXilt1Y4sw1B9FUKBD57e48B
N9Ki111vtYCGDi+CSMIbqULWQ/V6e64rpirnkm0+Q+sZXQWzvWOiPaRMq3cjgR76
snmnloD428sf8ZwtNOPH8IACDJqmQ+Bow/GGqOokv4AbJbc2on0W7R8o0CFyCaqR
HzI8qr0Y8f9Y0wJDARWm+zCfTz0HCc7/hp12TQGcyFtiG5ploPKsFncBt1ODGc//
vhviyW7jHByC2F8ziC8J7rOnDBLqnH8FHkDdoCgxMd8ZaIFO6eUmxo1JfODaaPSA
1gmLJOa9YzJS7m6NHIdmQFotWJpsdeEwWiC9QMNYrQ3CHgWsYmJ25cE48zXr3dai
Mn3EHndZFw/rypz4V7IqmoYk+RL8kjdiXPQPJ9pOIS9oT/SpSfo=
=qotB
-----END PGP SIGNATURE-----

--v525F/vnNBtUxgKg--
