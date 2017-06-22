From: Dave Martin <Dave.Martin@arm.com>
Subject: [REVERT] arm64: signal: Allow expansion of the signal frame
Date: Thu, 22 Jun 2017 17:46:53 +0100
Message-ID: <20170622164653.GI3453@e103592.cambridge.arm.com>
References: <1497979419-28758-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:12512
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752152AbdFVQrC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jun 2017 12:47:02 -0400
Content-Disposition: inline
In-Reply-To: <1497979419-28758-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Jun 20, 2017 at 06:23:39PM +0100, Dave Martin wrote:
> This patch defines an extra_context signal frame record that can be
> used to describe an expanded signal frame, and modifies the context
> block allocator and signal frame setup and parsing code to create,
> populate, parse and decode this block as necessary.
>
> To avoid abuse by userspace, parse_user_sigframe() attempts to
> ensure that:
>
>  * no more than one extra_context is accepted;
>  * the extra context data is a sensible size, and properly placed
>    and aligned.
>
> The extra_context data is required to start at the first 16-byte
> aligned address immediately after the dummy terminator record
> following extra_context in rt_sigframe.__reserved[] (as ensured
> during signal delivery).  This serves as a sanity-check that the
> signal frame has not been moved or copied without taking the extra
> data into account.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Apologies, I now realise that this patch is broken :(

The breakage is impossible to trigger at present, and the patches
currently applied introduce no LTP regressions -- so I think we have
the option to keep the patch and apply a fix on top later (explanation
below).

Otherwise, can you drop or revert it please?

This breakage also renders questionable the first patch in the series
("arm64: signal: split frame link record from sigcontext structure").
The arguments for why that patch is acceptable are unchanged, but there
is no need for it any more and so it may be better to drop it (or at
least discuss it again).

Rebasing that first patch out won't be trivial, so if dropping/reverting
that I recommend dropping/reverting the whole series.


Detail:

The patch currently assumes that we can splat data across the and of
struct sigcontext, since __reserved[] is the last thing in there.

Unfortunately, struct sigcontext is not the last thing in the
signal frame: it is embedded in a struct ucontext, where it is
followed by uc_sigmask (ironically to allow uc_sigmask to expand).

struct ucontext {
        unsigned long     uc_flags;
        struct ucontext  *uc_link;
        stack_t           uc_stack;
        struct sigcontext uc_mcontext;
        sigset_t          uc_sigmask;   /* mask last for extensibility */
};

Thus allocating more than sizeof(__reserved) bytes via sigframe_alloc()
will cause us to overwrite uc_sigmask (or uc_sigmask will overwrite
our data).

The total size of allocations done by the kernel is always smaller than
this today, so the bug should never be observed in practice.

I will need to resurrect the older version of the patch that skips to
the end of struct rt_sigframe when an overflowing allocation is made --
which also means that moving the {fp,lr} frame record is no longer
necessary and can be backed out too.  Skipping to the end unfortunately
wastes some stack space, but I can't see a way to avoid that now.

Cheers
---Dave

> ---
>
> Retaining Catalin's Reviewed-by, since the change (conversion of
> extra_context.data to a u64) to a pointer was discussed with him and is
> minor).
>
>  arch/arm64/include/uapi/asm/sigcontext.h |  38 +++++-
>  arch/arm64/kernel/signal.c               | 195 +++++++++++++++++++++++++=
+++---
>  2 files changed, 214 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/includ=
e/uapi/asm/sigcontext.h
> index 1328a2c..f0a76b9 100644
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -41,9 +41,10 @@ struct sigcontext {
>   *
>   *   0x210           fpsimd_context
>   *    0x10           esr_context
> + *    0x20           extra_context (optional)
>   *    0x10           terminator (null _aarch64_ctx)
>   *
> - *   0xdd0           (reserved for future allocation)
> + *   0xdb0           (reserved for future allocation)
>   *
>   * New records that can exceed this space need to be opt-in for userspac=
e, so
>   * that an expanded signal frame is not generated unexpectedly.  The mec=
hanism
> @@ -80,4 +81,39 @@ struct esr_context {
>       __u64 esr;
>  };
>
> +/*
> + * extra_context: describes extra space in the signal frame for
> + * additional structures that don't fit in sigcontext.__reserved[].
> + *
> + * Note:
> + *
> + * 1) fpsimd_context, esr_context and extra_context must be placed in
> + * sigcontext.__reserved[] if present.  They cannot be placed in the
> + * extra space.  Any other record can be placed either in the extra
> + * space or in sigcontext.__reserved[], unless otherwise specified in
> + * this file.
> + *
> + * 2) There must not be more than one extra_context.
> + *
> + * 3) If extra_context is present, it must be followed immediately in
> + * sigcontext.__reserved[] by the terminating null _aarch64_ctx.
> + *
> + * 4) The extra space to which datap points must start at the first
> + * 16-byte aligned address immediately after the terminating null
> + * _aarch64_ctx that follows the extra_context structure in
> + * __reserved[].  The extra space may overrun the end of __reserved[],
> + * as indicated by a sufficiently large value for the size field.
> + *
> + * 5) The extra space must itself be terminated with a null
> + * _aarch64_ctx.
> + */
> +#define EXTRA_MAGIC  0x45585401
> +
> +struct extra_context {
> +     struct _aarch64_ctx head;
> +     __u64 datap; /* 16-byte aligned pointer to extra space cast to __u6=
4 */
> +     __u32 size; /* size in bytes of the extra space */
> +     __u32 __reserved[3];
> +};
> +
>  #endif /* _UAPI__ASM_SIGCONTEXT_H */
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index fa787e6..6934e65 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -25,6 +25,7 @@
>  #include <linux/freezer.h>
>  #include <linux/stddef.h>
>  #include <linux/uaccess.h>
> +#include <linux/sizes.h>
>  #include <linux/string.h>
>  #include <linux/tracehook.h>
>  #include <linux/ratelimit.h>
> @@ -60,18 +61,27 @@ struct rt_sigframe_user_layout {
>
>       unsigned long fpsimd_offset;
>       unsigned long esr_offset;
> +     unsigned long extra_offset;
>       unsigned long end_offset;
>  };
>
> +#define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
> +#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
> +#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
> +
>  static void init_user_layout(struct rt_sigframe_user_layout *user)
>  {
> +     const size_t reserved_size =3D
> +             sizeof(user->sigframe->uc.uc_mcontext.__reserved);
> +
>       memset(user, 0, sizeof(*user));
>       user->size =3D offsetof(struct rt_sigframe, uc.uc_mcontext.__reserv=
ed);
>
> -     user->limit =3D user->size +
> -             sizeof(user->sigframe->uc.uc_mcontext.__reserved) -
> -             round_up(sizeof(struct _aarch64_ctx), 16);
> -             /* ^ reserve space for terminator */
> +     user->limit =3D user->size + reserved_size;
> +
> +     user->limit -=3D TERMINATOR_SIZE;
> +     user->limit -=3D EXTRA_CONTEXT_SIZE;
> +     /* Reserve space for extension and terminator ^ */
>  }
>
>  static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
> @@ -80,6 +90,52 @@ static size_t sigframe_size(struct rt_sigframe_user_la=
yout const *user)
>  }
>
>  /*
> + * Sanity limit on the approximate maximum size of signal frame we'll
> + * try to generate.  Stack alignment padding and the frame record are
> + * not taken into account.  This limit is not a guarantee and is
> + * NOT ABI.
> + */
> +#define SIGFRAME_MAXSZ SZ_64K
> +
> +static int __sigframe_alloc(struct rt_sigframe_user_layout *user,
> +                         unsigned long *offset, size_t size, bool extend=
)
> +{
> +     size_t padded_size =3D round_up(size, 16);
> +
> +     if (padded_size > user->limit - user->size &&
> +         !user->extra_offset &&
> +         extend) {
> +             int ret;
> +
> +             user->limit +=3D EXTRA_CONTEXT_SIZE;
> +             ret =3D __sigframe_alloc(user, &user->extra_offset,
> +                                    sizeof(struct extra_context), false)=
;
> +             if (ret) {
> +                     user->limit -=3D EXTRA_CONTEXT_SIZE;
> +                     return ret;
> +             }
> +
> +             /* Reserve space for the __reserved[] terminator */
> +             user->size +=3D TERMINATOR_SIZE;
> +
> +             /*
> +              * Allow expansion up to SIGFRAME_MAXSZ, ensuring space for
> +              * the terminator:
> +              */
> +             user->limit =3D SIGFRAME_MAXSZ - TERMINATOR_SIZE;
> +     }
> +
> +     /* Still not enough space?  Bad luck! */
> +     if (padded_size > user->limit - user->size)
> +             return -ENOMEM;
> +
> +     *offset =3D user->size;
> +     user->size +=3D padded_size;
> +
> +     return 0;
> +}
> +
> +/*
>   * Allocate space for an optional record of <size> bytes in the user
>   * signal frame.  The offset from the signal frame base address to the
>   * allocated block is assigned to *offset.
> @@ -87,11 +143,24 @@ static size_t sigframe_size(struct rt_sigframe_user_=
layout const *user)
>  static int sigframe_alloc(struct rt_sigframe_user_layout *user,
>                         unsigned long *offset, size_t size)
>  {
> -     size_t padded_size =3D round_up(size, 16);
> +     return __sigframe_alloc(user, offset, size, true);
> +}
>
> -     *offset =3D user->size;
> -     user->size +=3D padded_size;
> +/* Allocate the null terminator record and prevent further allocations *=
/
> +static int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
> +{
> +     int ret;
> +
> +     /* Un-reserve the space reserved for the terminator: */
> +     user->limit +=3D TERMINATOR_SIZE;
>
> +     ret =3D sigframe_alloc(user, &user->end_offset,
> +                          sizeof(struct _aarch64_ctx));
> +     if (ret)
> +             return ret;
> +
> +     /* Prevent further allocation: */
> +     user->limit =3D user->size;
>       return 0;
>  }
>
> @@ -162,6 +231,8 @@ static int parse_user_sigframe(struct user_ctxs *user=
,
>       char __user *base =3D (char __user *)&sc->__reserved;
>       size_t offset =3D 0;
>       size_t limit =3D sizeof(sc->__reserved);
> +     bool have_extra_context =3D false;
> +     char const __user *const sfp =3D (char const __user *)sf;
>
>       user->fpsimd =3D NULL;
>
> @@ -171,6 +242,12 @@ static int parse_user_sigframe(struct user_ctxs *use=
r,
>       while (1) {
>               int err =3D 0;
>               u32 magic, size;
> +             char const __user *userp;
> +             struct extra_context const __user *extra;
> +             u64 extra_datap;
> +             u32 extra_size;
> +             struct _aarch64_ctx const __user *end;
> +             u32 end_magic, end_size;
>
>               if (limit - offset < sizeof(*head))
>                       goto invalid;
> @@ -208,6 +285,64 @@ static int parse_user_sigframe(struct user_ctxs *use=
r,
>                       /* ignore */
>                       break;
>
> +             case EXTRA_MAGIC:
> +                     if (have_extra_context)
> +                             goto invalid;
> +
> +                     if (size < sizeof(*extra))
> +                             goto invalid;
> +
> +                     userp =3D (char const __user *)head;
> +
> +                     extra =3D (struct extra_context const __user *)user=
p;
> +                     userp +=3D size;
> +
> +                     __get_user_error(extra_datap, &extra->datap, err);
> +                     __get_user_error(extra_size, &extra->size, err);
> +                     if (err)
> +                             return err;
> +
> +                     /* Check for the dummy terminator in __reserved[]: =
*/
> +
> +                     if (limit - offset - size < TERMINATOR_SIZE)
> +                             goto invalid;
> +
> +                     end =3D (struct _aarch64_ctx const __user *)userp;
> +                     userp +=3D TERMINATOR_SIZE;
> +
> +                     __get_user_error(end_magic, &end->magic, err);
> +                     __get_user_error(end_size, &end->size, err);
> +                     if (err)
> +                             return err;
> +
> +                     if (end_magic || end_size)
> +                             goto invalid;
> +
> +                     /* Prevent looping/repeated parsing of extra_contex=
t */
> +                     have_extra_context =3D true;
> +
> +                     base =3D (void __user *)extra_datap;
> +                     if (!IS_ALIGNED((unsigned long)base, 16))
> +                             goto invalid;
> +
> +                     if (!IS_ALIGNED(extra_size, 16))
> +                             goto invalid;
> +
> +                     if (base !=3D userp)
> +                             goto invalid;
> +
> +                     /* Reject "unreasonably large" frames: */
> +                     if (extra_size > sfp + SIGFRAME_MAXSZ - userp)
> +                             goto invalid;
> +
> +                     /*
> +                      * Ignore trailing terminator in __reserved[]
> +                      * and start parsing extra data:
> +                      */
> +                     offset =3D 0;
> +                     limit =3D extra_size;
> +                     continue;
> +
>               default:
>                       goto invalid;
>               }
> @@ -318,17 +453,7 @@ static int setup_sigframe_layout(struct rt_sigframe_=
user_layout *user)
>                       return err;
>       }
>
> -     /*
> -      * Allocate space for the terminator record.
> -      * HACK: here we undo the reservation of space for the end record.
> -      * This bodge should be replaced with a cleaner approach later on.
> -      */
> -     user->limit =3D offsetof(struct rt_sigframe, uc.uc_mcontext.__reser=
ved) +
> -             sizeof(user->sigframe->uc.uc_mcontext.__reserved);
> -
> -     err =3D sigframe_alloc(user, &user->end_offset,
> -                          sizeof(struct _aarch64_ctx));
> -     return err;
> +     return sigframe_alloc_end(user);
>  }
>
>
> @@ -369,6 +494,40 @@ static int setup_sigframe(struct rt_sigframe_user_la=
yout *user,
>               __put_user_error(current->thread.fault_code, &esr_ctx->esr,=
 err);
>       }
>
> +     if (err =3D=3D 0 && user->extra_offset) {
> +             char __user *sfp =3D (char __user *)user->sigframe;
> +             char __user *userp =3D
> +                     apply_user_offset(user, user->extra_offset);
> +
> +             struct extra_context __user *extra;
> +             struct _aarch64_ctx __user *end;
> +             u64 extra_datap;
> +             u32 extra_size;
> +
> +             extra =3D (struct extra_context __user *)userp;
> +             userp +=3D EXTRA_CONTEXT_SIZE;
> +
> +             end =3D (struct _aarch64_ctx __user *)userp;
> +             userp +=3D TERMINATOR_SIZE;
> +
> +             /*
> +              * extra_datap is just written to the signal frame.
> +              * The value gets cast back to a void __user *
> +              * during sigreturn.
> +              */
> +             extra_datap =3D (__force u64)userp;
> +             extra_size =3D sfp + round_up(user->size, 16) - userp;
> +
> +             __put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
> +             __put_user_error(EXTRA_CONTEXT_SIZE, &extra->head.size, err=
);
> +             __put_user_error(extra_datap, &extra->datap, err);
> +             __put_user_error(extra_size, &extra->size, err);
> +
> +             /* Add the terminator */
> +             __put_user_error(0, &end->magic, err);
> +             __put_user_error(0, &end->size, err);
> +     }
> +
>       /* set the "end" magic */
>       if (err =3D=3D 0) {
>               struct _aarch64_ctx __user *end =3D
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
