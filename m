Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:32858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSOrg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 10:47:36 -0400
Date: Mon, 19 Aug 2019 16:47:34 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 08/28] x86/uaccess: annotate local function
Message-ID: <20190819144734.GB4522@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-9-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-9-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819144734.8u7ge9YF7ELXoFnnY9rYXGvSxsjoOjpkq2a4xTR9TjU@z>

On Thu, Aug 08, 2019 at 12:38:34PM +0200, Jiri Slaby wrote:
> copy_user_handle_tail is a self-standing local function, annotate it as
> such using SYM_FUNC_START_LOCAL.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/lib/copy_user_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 4fe1601dbc5d..d163c9566abe 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -230,8 +230,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * Output:
>   * eax uncopied bytes or 0 if successful.
>   */
> -ALIGN;
> -copy_user_handle_tail:
> +SYM_CODE_START_LOCAL(copy_user_handle_tail)
>  	movl %edx,%ecx
>  1:	rep movsb
>  2:	mov %ecx,%eax
> @@ -239,7 +238,7 @@ copy_user_handle_tail:
>  	ret
>  
>  	_ASM_EXTABLE_UA(1b, 2b)
> -END(copy_user_handle_tail)
> +SYM_CODE_END(copy_user_handle_tail)
>  
>  /*
>   * copy_user_nocache - Uncached memory copy with exception handling
> -- 

Also, s/copy_user_handle_tail/.Lcopy_user_handle_tail/g

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
