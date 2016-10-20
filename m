From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Thu, 20 Oct 2016 12:04:52 +0200
Message-ID: <1476957892.28989.24.camel@tiscali.nl>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:33417 "EHLO
        lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750953AbcJTKFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Oct 2016 06:05:00 -0400
In-Reply-To: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>

Masahiro,

A few comments regarding, I guess, future work.

On Sun, 2016-10-16 at 20:07 +0900, Masahiro Yamada wrote:
> The use of config_enabled() is ambiguous.  For config options,
> IS_ENABLED(), IS_REACHABLE(), etc. will make intention clearer.
> Sometimes config_enabled() has been used for non-config options
> because it is useful to check whether the given symbol is defined
> or not.
> 
> I have been tackling on deprecating config_enabled(), and now is the
> time to finish this work.
> 
> Some new users have appeared for v4.9-rc1, but it is trivial to
> replace them:
> 
>  - arch/x86/mm/kaslr.c
>   replace config_enabled() with IS_ENABLED() because
>   CONFIG_X86_ESPFIX64 and CONFIG_EFI are boolean.
> 
>  - include/asm-generic/export.h
>   replace config_enabled() with __is_defined().
> 
> Then, config_enabled() can be removed now.
> 
> Going forward, please use IS_ENABLED(), IS_REACHABLE(), etc. for
> config options, and __is_defined() for non-config symbols.

There are about a dozen instances of IS_ENABLED() that target something
other than a kconfig macros. Are you planning to convert those to
__is_defined() too? 

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -31,7 +31,6 @@
>   * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
>   * the last step cherry picks the 2nd arg, we get a zero.
>   */
> -#define config_enabled(cfg)		___is_defined(cfg)

Is there a reason to keep using the double underscore prefix?

>  #define __is_defined(x)			___is_defined(x)
>  #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
>  #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)

__is_defined() is now meant to be used generally, and not just on
kconfig macros. Can it be moved into another header?


Paul Bolle
