From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH v11 06/19] h8300: Assembly headers
Date: Sun, 10 May 2015 12:46:14 +0200
Message-ID: <CAFLxGvwb8DfZBgL6Va1jZ3NC8ExDU-zjfwiaBr8yRo5eQhUu4A@mail.gmail.com>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
	<1431097479-21101-7-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:35418 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbEJKqP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 May 2015 06:46:15 -0400
In-Reply-To: <1431097479-21101-7-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, May 8, 2015 at 5:04 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/arch/h8300/include/asm/uaccess.h b/arch/h8300/include/asm/uaccess.h
> new file mode 100644
> index 0000000..582af79
> --- /dev/null
> +++ b/arch/h8300/include/asm/uaccess.h
> @@ -0,0 +1,131 @@
> +#ifndef __H8300_UACCESS_H
> +#define __H8300_UACCESS_H
> +
> +/*
> + * User space memory access functions
> + */
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +
> +#include <asm/segment.h>
> +
> +#define VERIFY_READ    0
> +#define VERIFY_WRITE   1
> +
> +/* We let the MMU do all checking */
> +#define access_ok(type, addr, size) __access_ok((unsigned long)addr, size)
> +static inline int __access_ok(unsigned long addr, unsigned long size)
> +{
> +       return 1;
> +}
> +
> +/*
> + * The exception table consists of pairs of addresses: the first is the
> + * address of an instruction that is allowed to fault, and the second is
> + * the address at which the program should continue.  No registers are
> + * modified, so it is entirely up to the continuation code to figure out
> + * what to do.
> + *
> + * All the routines below use bits of fixup code that are out of line
> + * with the main instruction path.  This means when everything is well,
> + * we don't even have to jump over them.  Further, they do not intrude
> + * on our cache or tlb entries.
> + */
> +
> +struct exception_table_entry {
> +       unsigned long insn, fixup;
> +};
> +
> +/* Returns 0 if exception not found and fixup otherwise.  */
> +extern unsigned long search_exception_table(unsigned long);
> +
> +
> +/*
> + * These are the main single-value transfer routines.  They automatically
> + * use the right size if we just have the right pointer type.
> + */
> +
> +#define put_user(x, ptr)                               \
> +({                                                     \
> +       int __pu_err = 0;                               \
> +       typeof(*(ptr)) __pu_val = (x);                  \
> +       switch (sizeof(*(ptr))) {                       \
> +       case 1:                                         \
> +       /* falll through */ \
> +       case 2:                                         \
> +       /* fall through */ \
> +       case 4:                                         \
> +               *(ptr) = x;                             \
> +               break;                                  \
> +       case 8:                                         \
> +               memcpy(ptr, &__pu_val, sizeof(*(ptr))); \
> +               break;                                  \
> +       default:                                        \
> +               __pu_err = __put_user_bad();            \
> +               break;                                  \
> +       }                                               \
> +       __pu_err;                                       \
> +})
> +
> +#define __put_user(x, ptr) put_user(x, ptr)
> +
> +extern int __put_user_bad(void);
> +
> +/*
> + * Tell gcc we read from memory instead of writing: this is because
> + * we do not write to any memory gcc knows about, so there are no
> + * aliasing issues.
> + */
> +
> +#define __ptr(x) ((unsigned long *)(x))
> +
> +/*
> + * Tell gcc we read from memory instead of writing: this is because
> + * we do not write to any memory gcc knows about, so there are no
> + * aliasing issues.
> + */
> +
> +#define get_user(x, ptr)                                       \
> +({                                                             \
> +       typeof(*(ptr)) __gu_val;                                \
> +       int __gu_err = 0;                                       \
> +       switch (sizeof(*(ptr))) {                               \
> +       case 1:                                                 \
> +               *(u8 *)&__gu_val = *((u8 *)(ptr));              \
> +               break;                                          \
> +       case 2:                                                 \
> +               *(u16 *)&__gu_val = *((u16 *)ptr);              \
> +               break;                                          \
> +       case 4:                                                 \
> +               *(u32 *)&__gu_val = *((u32 *)ptr);              \
> +               break;                                          \
> +       case 8:                                                 \
> +               memcpy((void *)&__gu_val, ptr, sizeof(*(ptr))); \
> +               break;                                          \
> +       default:                                                \
> +               __gu_err = __get_user_bad();                    \
> +               break;                                          \
> +       }                                                       \
> +       (x) = (typeof(*(ptr)))__gu_val;                         \
> +       __gu_err;                                               \
> +})
> +#define __get_user(x, ptr) get_user(x, ptr)
> +
> +extern int __get_user_bad(void);
> +
> +#define copy_from_user(to, from, n)            (memcpy(to, from, n), 0)
> +#define copy_to_user(to, from, n)              (memcpy(to, from, n), 0)
> +
> +#define __copy_from_user(to, from, n) copy_from_user(to, from, n)
> +#define __copy_to_user(to, from, n) copy_to_user(to, from, n)
> +#define __copy_to_user_inatomic __copy_to_user
> +#define __copy_from_user_inatomic __copy_from_user
> +
> +unsigned long clear_user(void __user *addr, unsigned long size);
> +#define strnlen_user(s, n) (strnlen(s, n) + 1)
> +long strncpy_from_user(char *d, const char *s, long n);
> +
> +#define __clear_user   clear_user
> +
> +#endif /* _H8300_UACCESS_H */

Nothing serious, but I think you can drop most code in this file by
using asm-generic/uaccess.h.

-- 
Thanks,
//richard
