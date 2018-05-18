From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 03/28] x86/asm/suspend: use SYM_DATA for data
Date: Fri, 18 May 2018 12:03:48 +0200
Message-ID: <CAJZ5v0gH-Zjd_VWv9wBrtvTjewHdyjEiRhR2GWpSS2huMcWKLw@mail.gmail.com>
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-4-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518091721.7604-4-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 18, 2018 at 11:16 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/wakeup_32.S | 2 +-
>  arch/x86/kernel/acpi/wakeup_64.S | 2 +-
>  arch/x86/kernel/head_32.S        | 6 ++----
>  arch/x86/kernel/head_64.S        | 5 ++---
>  4 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 4203d4f0c68d..feac1e5ecba0 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,7 +89,7 @@ ret_point:
>
>  .data
>  ALIGN
> -ENTRY(saved_magic)     .long   0
> +SYM_DATA(saved_magic,  .long 0)
>  saved_eip:             .long 0
>
>  # saved registers
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 510fa12aab73..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -133,4 +133,4 @@ saved_rbx:          .quad   0
>  saved_rip:             .quad   0
>  saved_rsp:             .quad   0
>
> -ENTRY(saved_magic)     .quad   0
> +SYM_DATA(saved_magic,  .quad   0)
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index b59e4fb40fd9..80965fd75fea 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
>
>  __REFDATA
>         .align 4
> -ENTRY(initial_code)
> -       .long i386_start_kernel
> -ENTRY(setup_once_ref)
> -       .long setup_once
> +SYM_DATA(initial_code,         .long i386_start_kernel)
> +SYM_DATA(setup_once_ref,       .long setup_once)
>
>  /*
>   * BSS section
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 8344dd2f310a..17543533642d 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -463,9 +463,8 @@ early_gdt_descr:
>  early_gdt_descr_base:
>         .quad   INIT_PER_CPU_VAR(gdt_page)
>
> -ENTRY(phys_base)
> -       /* This must match the first entry in level2_kernel_pgt */
> -       .quad   0x0000000000000000
> +/* This must match the first entry in level2_kernel_pgt */
> +SYM_DATA(phys_base, .quad 0x0000000000000000)
>  EXPORT_SYMBOL(phys_base)
>
>  #include "../../x86/xen/xen-head.S"
> --
> 2.16.3
>
