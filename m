From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Move most arches to asm-generic/current.h
Date: Mon, 30 Apr 2012 14:15:56 +0000
Message-ID: <201204301415.56690.arnd@arndb.de>
References: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63762 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2D3OP7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 10:15:59 -0400
In-Reply-To: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 24 April 2012, Stephen Boyd wrote:
> diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
> index 5e86f6a..bbfb795 100644
> --- a/include/asm-generic/current.h
> +++ b/include/asm-generic/current.h
> @@ -1,9 +1,16 @@
>  #ifndef __ASM_GENERIC_CURRENT_H
>  #define __ASM_GENERIC_CURRENT_H
>  
> +#include <linux/compiler.h>
>  #include <linux/thread_info.h>
>  
> -#define get_current() (current_thread_info()->task)
> +struct task_struct;
> +
> +static __always_inline struct task_struct *get_current(void)
> +{
> +       return current_thread_info()->task;
> +}
> +
>  #define current get_current()
>  
>  #endif /* __ASM_GENERIC_CURRENT_H */

Does this need to be an inline function rather than a macro? I think I
remember having trouble with header file dependencies when I tried making
it an inline function initially and I don't know if those have been
resolved.

I realize that the macro is ugly, but if you don't mind keeping it,
that would be the safer option in terms of breaking some architecture
in the process. If course if you can prove that all architectures using
the generic implementation can use the inline function, I'm all for
the change.

Aside from this, I very much like your patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
