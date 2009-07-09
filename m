From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] score: add regsets support for score
Date: Thu, 9 Jul 2009 17:08:54 +0200
Message-ID: <200907091708.54468.arnd@arndb.de>
References: <OF5282122C.261603C7-ON482575ED.003A86FA-482575ED.003C4AEE@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62297 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760965AbZGIPJD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2009 11:09:03 -0400
In-Reply-To: <OF5282122C.261603C7-ON482575ED.003A86FA-482575ED.003C4AEE@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>

On Wednesday 08 July 2009, liqin.chen@sunplusct.com wrote:
> ptrace.c add register sets support for score architecture.
> 
> - genregs_get(struct task_struct *target,
>                const struct user_regset *regset,
>                unsigned int pos, unsigned int count,
>                void *kbuf, void __user *ubuf)
>         Retrieve the contents of score userspace general registers.
> 
> - genregs_set(struct task_struct *target,
>                const struct user_regset *regset,
>                unsigned int pos, unsigned int count,
>                const void *kbuf, const void __user *ubuf)
>         Update the contents of the score userspace general registers.
> 
> Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>
> ---
>  arch/score/include/asm/elf.h |    3 +-
>  arch/score/kernel/ptrace.c   |   78 
> ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 1 deletions(-)

You still use an email client that breaks patches by adding line-wraps.
Please use a different mail client for sending patches. You could for
example use git-send-email with a random freemail account and still
set your corporate sender address.

The code you add looks ok to me, but it appears you forgot to hook
it up to the ptrace logic. Some architectures use it only for
PTRACE_{GET,SET}REGS, others also use it in PTRACE_{PEEK,POKE}USR,
I'm not sure what the right approach is for new architectures.
Should a new architecture actually implement both of those
interfaces?

Maybe Christoph (who was asking for the change) or Roland can comment
on that.

	Arnd <><

> diff --git a/arch/score/include/asm/elf.h b/arch/score/include/asm/elf.h
> index 8324363..d69668c 100644
> --- a/arch/score/include/asm/elf.h
> +++ b/arch/score/include/asm/elf.h
> @@ -2,7 +2,7 @@
>  #define _ASM_SCORE_ELF_H
>  
>  /* ELF register definitions */
> -#define ELF_NGREG      45
> +#define ELF_NGREG      42
>  #define ELF_NFPREG     33
>  #define EM_SCORE7      135
>  
> @@ -57,6 +57,7 @@ do { \
>  struct task_struct;
>  struct pt_regs;
>  
> +#define CORE_DUMP_USE_REGSET
>  #define USE_ELF_CORE_DUMP
>  #define ELF_EXEC_PAGESIZE      PAGE_SIZE
>  
> diff --git a/arch/score/kernel/ptrace.c b/arch/score/kernel/ptrace.c
> index 1db876b..9eec6a2 100644
> --- a/arch/score/kernel/ptrace.c
> +++ b/arch/score/kernel/ptrace.c
> @@ -23,11 +23,89 @@
>   * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  
> +#include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/ptrace.h>
> +#include <linux/regset.h>
>  
>  #include <asm/uaccess.h>
>  
> +/*
> + * retrieve the contents of SCORE userspace general registers
> + */
> +static int genregs_get(struct task_struct *target,
> +                      const struct user_regset *regset,
> +                      unsigned int pos, unsigned int count,
> +                      void *kbuf, void __user *ubuf)
> +{
> +       const struct pt_regs *regs = task_pt_regs(target);
> +       int end_pos = sizeof(struct pt_regs) - 9 * sizeof(long);
> +       int ret;
> +
> +       ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +                                 regs->regs,
> +                                 offsetof(struct pt_regs, regs),
> +                                 end_pos);
> +       if (!ret)
> +               ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> +                                               end_pos, -1);
> +
> +       return ret;
> +}
> +
> +/*
> + * update the contents of the SCORE userspace general registers
> + */
> +static int genregs_set(struct task_struct *target,
> +                      const struct user_regset *regset,
> +                      unsigned int pos, unsigned int count,
> +                      const void *kbuf, const void __user *ubuf)
> +{
> +       struct pt_regs *regs = task_pt_regs(target);
> +       int end_pos = sizeof(struct pt_regs) - 9 * sizeof(long);
> +       int ret;
> +
> +       ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +                                regs->regs,
> +                                offsetof(struct pt_regs, regs),
> +                                end_pos);
> +       if (!ret)
> +               ret = user_regset_copyin_ignore(&pos, &count, &kbuf, 
> &ubuf,
> +                                               end_pos, -1);
> +
> +       return ret;
> +}
> +
> +/*
> + * Define the register sets available on the score7 under Linux
> + */
> +enum score7_regset {
> +       REGSET_GENERAL,
> +};
> +
> +static const struct user_regset score7_regsets[] = {
> +       [REGSET_GENERAL] = {
> +               .core_note_type = NT_PRSTATUS,
> +               .n              = ELF_NGREG,
> +               .size           = sizeof(long),
> +               .align          = sizeof(long),
> +               .get            = genregs_get,
> +               .set            = genregs_set,
> +       },
> +};
> +
> +static const struct user_regset_view user_score_native_view = {
> +       .name           = "score7",
> +       .e_machine      = EM_SCORE7,
> +       .regsets        = score7_regsets,
> +       .n              = ARRAY_SIZE(score7_regsets),
> +};
> +
> +const struct user_regset_view *task_user_regset_view(struct task_struct 
> *task)
> +{
> +       return &user_score_native_view;
> +}
> +
>  static int is_16bitinsn(unsigned long insn)
>  {
>         if ((insn & INSN32_MASK) == INSN32_MASK)
