Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44800 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbdJ0Rwy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2017 13:52:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id z55so6888079wrz.1
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2017 10:52:53 -0700 (PDT)
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com> <1509101470-7881-21-git-send-email-Dave.Martin@arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 20/28] arm64/sve: Add prctl controls for userspace vector length management
In-reply-to: <1509101470-7881-21-git-send-email-Dave.Martin@arm.com>
Date: Fri, 27 Oct 2017 18:52:50 +0100
Message-ID: <87r2toiikt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171027175250.o6zbkbjXNZGvMkYVlSnXyBTAIt8sO8snr5c2AVZ5Nlw@z>


Dave Martin <Dave.Martin@arm.com> writes:

> This patch adds two arm64-specific prctls, to permit userspace to
> control its vector length:
>
>  * PR_SVE_SET_VL: set the thread's SVE vector length and vector
>    length inheritance mode.
>
>  * PR_SVE_GET_VL: get the same information.
>
> Although these prctls resemble instruction set features in the SVE
> architecture, they provide additional control: the vector length
> inheritance mode is Linux-specific and nothing to do with the
> architecture, and the architecture does not permit EL0 to set its
> own vector length directly.  Both can be used in portable tools
> without requiring the use of SVE instructions.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>

FYI there is a minor conflict applying this on current master.

>
> ---
>
> **Dropped at v3** Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> due to non-trivial changes/fixes after v2.
>
> Changes since v3
> ----------------
>
> Requested by Catalin Marinas:
>
>  * Replace static __maybe_unused functions with static inlines.
>
>    (Retaining Catalin's Reviewed-by with his approval.)
> ---
>  arch/arm64/include/asm/fpsimd.h    | 14 +++++++++++
>  arch/arm64/include/asm/processor.h |  4 +++
>  arch/arm64/kernel/fpsimd.c         | 50 ++++++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/prctl.h         |  4 +++
>  kernel/sys.c                       | 12 +++++++++
>  5 files changed, 84 insertions(+)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fps=
imd.h
> index d754e5a..b868412 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -17,6 +17,7 @@
>  #define __ASM_FP_H
>
>  #include <asm/ptrace.h>
> +#include <asm/errno.h>
>
>  #ifndef __ASSEMBLY__
>
> @@ -98,6 +99,9 @@ extern void sve_sync_from_fpsimd_zeropad(struct task_st=
ruct *task);
>  extern int sve_set_vector_length(struct task_struct *task,
>  				 unsigned long vl, unsigned long flags);
>
> +extern int sve_set_current_vl(unsigned long arg);
> +extern int sve_get_current_vl(void);
> +
>  /*
>   * Probing and setup functions.
>   * Calls to these functions must be serialised with one another.
> @@ -114,6 +118,16 @@ static inline void fpsimd_release_task(struct task_s=
truct *task) { }
>  static inline void sve_sync_to_fpsimd(struct task_struct *task) { }
>  static inline void sve_sync_from_fpsimd_zeropad(struct task_struct *task=
) { }
>
> +static inline int sve_set_current_vl(unsigned long arg)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int sve_get_current_vl(void)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void sve_init_vq_map(void) { }
>  static inline void sve_update_vq_map(void) { }
>  static inline int sve_verify_vq_map(void) { return 0; }
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/=
processor.h
> index c6fddb0..023cacb 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -217,5 +217,9 @@ static inline void spin_lock_prefetch(const void *ptr)
>  int cpu_enable_pan(void *__unused);
>  int cpu_enable_cache_maint_trap(void *__unused);
>
> +/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
> +#define SVE_SET_VL(arg)	sve_set_current_vl(arg)
> +#define SVE_GET_VL()	sve_get_current_vl()
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_PROCESSOR_H */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index a47ce44..7465622 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -28,6 +28,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/init.h>
>  #include <linux/percpu.h>
> +#include <linux/prctl.h>
>  #include <linux/preempt.h>
>  #include <linux/prctl.h>
>  #include <linux/ptrace.h>
> @@ -557,6 +558,55 @@ int sve_set_vector_length(struct task_struct *task,
>  }
>
>  /*
> + * Encode the current vector length and flags for return.
> + * This is only required for prctl(): ptrace has separate fields
> + *
> + * flags are as for sve_set_vector_length().
> + */
> +static int sve_prctl_status(unsigned long flags)
> +{
> +	int ret;
> +
> +	if (flags & PR_SVE_SET_VL_ONEXEC)
> +		ret =3D current->thread.sve_vl_onexec;
> +	else
> +		ret =3D current->thread.sve_vl;
> +
> +	if (test_thread_flag(TIF_SVE_VL_INHERIT))
> +		ret |=3D PR_SVE_VL_INHERIT;
> +
> +	return ret;
> +}
> +
> +/* PR_SVE_SET_VL */
> +int sve_set_current_vl(unsigned long arg)
> +{
> +	unsigned long vl, flags;
> +	int ret;
> +
> +	vl =3D arg & PR_SVE_VL_LEN_MASK;
> +	flags =3D arg & ~vl;
> +
> +	if (!system_supports_sve())
> +		return -EINVAL;
> +
> +	ret =3D sve_set_vector_length(current, vl, flags);
> +	if (ret)
> +		return ret;
> +
> +	return sve_prctl_status(flags);
> +}
> +
> +/* PR_SVE_GET_VL */
> +int sve_get_current_vl(void)
> +{
> +	if (!system_supports_sve())
> +		return -EINVAL;
> +
> +	return sve_prctl_status(0);
> +}
> +
> +/*
>   * Bitmap for temporary storage of the per-CPU set of supported vector l=
engths
>   * during secondary boot.
>   */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 1b64901..1ef9370 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -198,7 +198,11 @@ struct prctl_mm_map {
>  # define PR_CAP_AMBIENT_CLEAR_ALL	4
>
>  /* arm64 Scalable Vector Extension controls */
> +/* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
> +#define PR_SVE_SET_VL			48	/* set task vector length */
>  # define PR_SVE_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
> +#define PR_SVE_GET_VL			49	/* get task vector length */
> +/* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
>  # define PR_SVE_VL_LEN_MASK		0xffff
>  # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 9aebc29..c541916 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -110,6 +110,12 @@
>  #ifndef SET_FP_MODE
>  # define SET_FP_MODE(a,b)	(-EINVAL)
>  #endif
> +#ifndef SVE_SET_VL
> +# define SVE_SET_VL(a)		(-EINVAL)
> +#endif
> +#ifndef SVE_GET_VL
> +# define SVE_GET_VL()		(-EINVAL)
> +#endif
>
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2385,6 +2391,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  	case PR_GET_FP_MODE:
>  		error =3D GET_FP_MODE(me);
>  		break;
> +	case PR_SVE_SET_VL:
> +		error =3D SVE_SET_VL(arg2);
> +		break;
> +	case PR_SVE_GET_VL:
> +		error =3D SVE_GET_VL();
> +		break;
>  	default:
>  		error =3D -EINVAL;
>  		break;


--
Alex Benn=C3=A9e
