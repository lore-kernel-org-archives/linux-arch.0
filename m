From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 02/28] x86/asm/suspend: drop ENTRY from local data
Date: Fri, 18 May 2018 12:03:20 +0200
Message-ID: <CAJZ5v0jz-qzA-k0+6PvyALbwzpnRyB5SQpbDr9g-THiz7ZwH3g@mail.gmail.com>
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518091721.7604-3-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 18, 2018 at 11:16 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> ENTRY was intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
>
> So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
> as these symbols are local only.
>
> We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
> earlier [1].
>
> [1] https://lkml.org/lkml/2017/4/27/244
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
>  arch/x86/kernel/acpi/wakeup_32.S |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 0c26b1b44e51..4203d4f0c68d 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -90,7 +90,7 @@ ret_point:
>  .data
>  ALIGN
>  ENTRY(saved_magic)     .long   0
> -ENTRY(saved_eip)       .long   0
> +saved_eip:             .long 0
>
>  # saved registers
>  saved_idt:     .long   0,0
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 50b8ed0317a3..510fa12aab73 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
>  ENDPROC(do_suspend_lowlevel)
>
>  .data
> -ENTRY(saved_rbp)       .quad   0
> -ENTRY(saved_rsi)       .quad   0
> -ENTRY(saved_rdi)       .quad   0
> -ENTRY(saved_rbx)       .quad   0
> +saved_rbp:             .quad   0
> +saved_rsi:             .quad   0
> +saved_rdi:             .quad   0
> +saved_rbx:             .quad   0
>
> -ENTRY(saved_rip)       .quad   0
> -ENTRY(saved_rsp)       .quad   0
> +saved_rip:             .quad   0
> +saved_rsp:             .quad   0
>
>  ENTRY(saved_magic)     .quad   0
> --
> 2.16.3
>
