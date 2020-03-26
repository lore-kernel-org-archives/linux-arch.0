Return-Path: <SRS0=xxT4=5L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57510 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgCZULu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 16:11:50 -0400
Date: Thu, 26 Mar 2020 21:11:42 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Message-ID: <20200326201142.GJ11398@zn.tnic>
References: <20200326193021.255002-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326193021.255002-1-hjl.tools@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Sami Tolvanen <samitolvanen@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>
Message-ID: <20200326201142.bQ-rmGqc8xXyzHyvi6YRQyzOMzMkuasBHsV3boQ8R4c@z>

On Thu, Mar 26, 2020 at 12:30:20PM -0700, H.J. Lu wrote:
> In x86 kernel, .exit.text and .exit.data sections are discarded at
> runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> and define it in x86 kernel linker script to keep them.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S     |  1 +
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index e3296aa028fe..7206e1ac23dd 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -21,6 +21,7 @@
>  #define LOAD_OFFSET __START_KERNEL_map
>  #endif
>  
> +#define RUNTIME_DISCARD_EXIT
>  #define EMITS_PT_NOTE
>  #define RO_EXCEPTION_TABLE_ALIGN	16
>  
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..6b943fb8c5fd 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -894,10 +894,16 @@
>   * section definitions so that such archs put those in earlier section
>   * definitions.
>   */
> +#ifdef RUNTIME_DISCARD_EXIT
> +#define EXIT_DISCARDS
> +#else
> +#define EXIT_DISCARDS							\
> +	EXIT_TEXT							\
> +	EXIT_DATA
> +#endif

/me goes back and reads the old thread on this...

Kees, do you expect other arches to actually need this
RUNTIME_DISCARD_EXIT thing or was that a hypothetical thing?

/me searches more...

oh, there's a patchset from you

https://lkml.kernel.org/r/20200228002244.15240-1-keescook@chromium.org

which already contains this patch *and* an ARM64 patch which defines
RUNTIME_DISCARD_EXIT so I'm guessing ARM64 wants to discard at runtime
too.

Which leaves the question why is H.J. sending that patch separate and
you carry it in a patchset about orphan section warning? Seems like it
wants to be in your patchset?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
