From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2] score: add regset support
Date: Fri, 10 Jul 2009 14:49:44 +0200
Message-ID: <200907101449.45286.arnd@arndb.de>
References: <4A570650.3060309@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54576 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZGJMvA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 08:51:00 -0400
In-Reply-To: <4A570650.3060309@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "liqin.chen" <liqin.chen@sunplusct.com>
Cc: Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-arch-owner@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Friday 10 July 2009, liqin.chen wrote:
> +static int genregs_get(struct task_struct *target,
> +               const struct user_regset *regset,
> +               unsigned int pos, unsigned int count,
> +               void *kbuf, void __user *ubuf)
> +{
> +    const struct pt_regs *regs = task_pt_regs(target);
> +    int ret;
> +
> +    /* skip 8 * sizeof(unsigned long) not use for pt_regs */
> +    ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> +                    0, offsetof(struct pt_regs, regs));
> +
> +    /* r0 - r31 */
> +    ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +                  regs->regs,
> +                  offsetof(struct pt_regs, regs),
> +                  offsetof(struct pt_regs, cel));
> +
> +    if (!ret)
> +        /* cel, ceh, sr0, sr1, sr2, epc, ema, psr, ecr, condition */
> +        ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +                    &regs->cel,
> +                    offsetof(struct pt_regs, cel),
> +                    offsetof(struct pt_regs, is_syscall));

The two user_regset_copyout are consecutive, so AFAICT they can
be combined into a single function call.

> +
> +    if (!ret)
> +        ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> +                        sizeof(struct pt_regs), -1);
> +
> +    return ret;
> +}

While the code looks correct to me now based on Rolands comments,
I think it would be nicer to define separate pt_regs and user_regset
data structures to make the two independent and give you more
flexibility with the kernel stack layout in the future.

Maybe you could change

struct pt_regs {
       unsigned long pad0[6];
       unsigned long orig_r4;
       unsigned long orig_r7;
       unsigned long regs[32];

       unsigned long cel;
       unsigned long ceh;

       unsigned long sr0;      /* cnt */
       unsigned long sr1;      /* lcr */
       unsigned long sr2;      /* scr */

       unsigned long cp0_epc;
       unsigned long cp0_ema;
       unsigned long cp0_psr;
       unsigned long cp0_ecr;
       unsigned long cp0_condition;

       long is_syscall;
};

to

struct pt_regs {
       unsigned long regs[32];

       unsigned long cel;
       unsigned long ceh;

       unsigned long sr0;      /* cnt */
       unsigned long sr1;      /* lcr */
       unsigned long sr2;      /* scr */

       unsigned long cp0_epc;
       unsigned long cp0_ema;
       unsigned long cp0_psr;
       unsigned long cp0_ecr;
       unsigned long cp0_condition;
#ifdef __KERNEL__
       unsigned long orig_r4;
       unsigned long orig_r7;
       long is_syscall;
       unsigned long pad0[3];
#else
       unsigned long pad0[6];
#endif
};

> @@ -356,11 +430,17 @@ arch_ptrace(struct task_struct *child, long 
> request, long addr, long data)
>      }
>  
>      case PTRACE_GETREGS:
> -        ret = ptrace_getregs(child, (void __user *)datap);
> +        return copy_regset_to_user(child, &user_score_native_view,
> +                        REGSET_GENERAL,
> +                        0, sizeof(struct pt_regs),
> +                        (void __user *)datap);                        	
>          break;
>  
>      case PTRACE_SETREGS:
> -        ret = ptrace_setregs(child, (void __user *)datap);
> +        return copy_regset_from_user(child, &user_score_native_view,
> +                        REGSET_GENERAL,
> +                        0, sizeof(struct pt_regs),
> +                        (const void __user *)datap);
>          break;
>  
>      default:

I guess you still need to remove the PTRACE_PEEKUSR and PTRACE_POKEUSR
code, as mentioned by Roland.

Roland, Christoph: Do you think it would be reasonable to implement
this in common code? That would make it possible to have an empty
arch_ptrace() function.

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 61c78b2..a6b7862 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -570,6 +570,21 @@ int ptrace_request(struct task_struct *child, long request,
 			return 0;
 		return ptrace_resume(child, request, SIGKILL);
 
+#if defined(PTRACE_GENERIC_GETREGS) && defined(REGSET_GENERAL)
+	case PTRACE_GETREGS:
+		return copy_regset_to_user(child,
+				task_user_regset_view(child),
+				REGSET_GENERAL, 0,
+				sizeof(struct pt_regs),
+				(void __user *)datap);
+	case PTRACE_GETREGS:
+		return copy_regset_from_user(child,
+				task_user_regset_view(child),
+				REGSET_GENERAL, 0,
+				sizeof(struct pt_regs),
+				(void __user *)datap);
+#endif
+
 	default:
 		break;
 	}
