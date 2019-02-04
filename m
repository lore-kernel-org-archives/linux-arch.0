From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Date: Mon, 4 Feb 2019 21:18:31 +0100
Message-ID: <20190204201831.GK29639@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-4-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-4-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 30, 2019 at 01:46:46PM +0100, Jiri Slaby wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
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
> -ENTRY(saved_magic)	.long	0
> +SYM_DATA(saved_magic,	.long 0)
>  saved_eip:		.long 0
>  
>  # saved registers
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 510fa12aab73..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -133,4 +133,4 @@ saved_rbx:		.quad	0
>  saved_rip:		.quad	0
>  saved_rsp:		.quad	0
>  
> -ENTRY(saved_magic)	.quad	0
> +SYM_DATA(saved_magic,	.quad	0)

Ok, I like the proper ELF symbol typing with this: NOTYPE goes away.

 74408: ffffffff82021920     0 NOTYPE  GLOBAL DEFAULT   11 saved_magic

->

 74366: ffffffff820218f0     8 OBJECT  GLOBAL DEFAULT   11 saved_magic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
