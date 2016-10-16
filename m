From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Sun, 16 Oct 2016 18:19:45 +0200
Message-ID: <20161016161945.GA1456@gmail.com>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33393 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754307AbcJPQTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2016 12:19:50 -0400
Content-Disposition: inline
In-Reply-To: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The use of config_enabled() is ambiguous.  For config options,
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
>  - arch/x86/mm/kaslr.c
>   replace config_enabled() with IS_ENABLED() because
>   CONFIG_X86_ESPFIX64 and CONFIG_EFI are boolean.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
