Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lithops.sigma-star.at ([195.201.40.130]:52252 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfJOPhm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 11:37:42 -0400
Date: Tue, 15 Oct 2019 17:37:37 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <879392618.23509.1571153857379.JavaMail.zimbra@nod.at>
In-Reply-To: <20191011115108.12392-14-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz> <20191011115108.12392-14-jslaby@suse.cz>
Subject: Re: [PATCH v9 13/28] um: Annotate data appropriately
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Message-ID: <20191015153737.Kv_pGk50sDPJnMa2UX3uN3RcuHrnnhckBbt-CmGE4Fw@z>

----- Ursprüngliche Mail -----
> Von: "Jiri Slaby" <jslaby@suse.cz>
> An: bp@alien8.de
> CC: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Jiri Slaby" <jslaby@suse.cz>, "Jeff Dike" <jdike@addtoit.com>, "richard"
> <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
> Gesendet: Freitag, 11. Oktober 2019 13:50:53
> Betreff: [PATCH v9 13/28] um: Annotate data appropriately

> Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.
> 
> We get:
>  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
>  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: user-mode-linux-user@lists.sourceforge.net
> ---
> arch/x86/um/vdso/vdso.S | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
> index a4a3870dc059..a6eaf293a73b 100644
> --- a/arch/x86/um/vdso/vdso.S
> +++ b/arch/x86/um/vdso/vdso.S
> @@ -1,11 +1,11 @@
> /* SPDX-License-Identifier: GPL-2.0 */
> #include <linux/init.h>
> +#include <linux/linkage.h>
> 
> __INITDATA
> 
> -	.globl vdso_start, vdso_end
> -vdso_start:
> +SYM_DATA_START(vdso_start)
> 	.incbin "arch/x86/um/vdso/vdso.so"
> -vdso_end:
> +SYM_DATA_END_LABEL(vdso_start, SYM_L_GLOBAL, vdso_end)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
