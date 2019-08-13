Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:42008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMQj0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:26 -0400
Date: Tue, 13 Aug 2019 18:40:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 02/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20190813164009.GG16770@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-3-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Message-ID: <20190813164009.WK2o3FP3WLh-UGigtX9sT2NXASbg25gC0jybgOZkNs4@z>

On Thu, Aug 08, 2019 at 12:38:28PM +0200, Jiri Slaby wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data.

Well, but are we sure that removing that alignment is fine in all cases?
If so, the commit message should state why it is ok for those symbols to
not be aligned now.

And before it, phys_base looks like this:

.globl phys_base ; .p2align 4, 0x90 ; phys_base:

and it is correctly 8 bytes:

ffffffff82011010 <phys_base>:
ffffffff82011010:       00 00                   add    %al,(%rax)
ffffffff82011012:       00 00                   add    %al,(%rax)
ffffffff82011014:       00 00                   add    %al,(%rax)
ffffffff82011016:       00 00                   add    %al,(%rax)

However, with this patch, it becomes:

.globl phys_base ; ; phys_base: ; .quad 0x0000000000000000 ; .type phys_base STT_OBJECT ; .size phys_base, .-phys_base

which is better as now we'll have the proper symbol size:

 86679: ffffffff8200f00a     8 OBJECT  GLOBAL DEFAULT   11 phys_base

but in the vmlinux image it is 14(!) bytes:

...
ffffffff8200f002 <early_gdt_descr_base>:
ffffffff8200f002:       00 a0 3b 82 ff ff       add    %ah,-0x7dc5(%rax)
ffffffff8200f008:       ff                      (bad)
ffffffff8200f009:       ff                      incl   (%rax)

ffffffff8200f00a <phys_base>:
ffffffff8200f00a:       00 00                   add    %al,(%rax)
ffffffff8200f00c:       00 00                   add    %al,(%rax)
ffffffff8200f00e:       00 00                   add    %al,(%rax)
ffffffff8200f010:       00 00                   add    %al,(%rax)

<--- should end here but the toolchain "stretches" it for whatever
reason. Perhaps padding?

ffffffff8200f012:       00 00                   add    %al,(%rax)
ffffffff8200f014:       00 00                   add    %al,(%rax)
ffffffff8200f016:       00 00                   add    %al,(%rax)

ffffffff8200f018 <early_pmd_flags>:
ffffffff8200f018:       e3 00                   jrcxz  ffffffff8200f01a <early_pmd_flags+0x2>
...

And that looks strange...

> Since we are dropping historical markings, make proper use of newly added
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

...

> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index f3d3e9646a99..6c1bf7ae55ff 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -469,9 +469,8 @@ early_gdt_descr:
>  early_gdt_descr_base:
>  	.quad	INIT_PER_CPU_VAR(gdt_page)
>  
> -ENTRY(phys_base)
> -	/* This must match the first entry in level2_kernel_pgt */
> -	.quad   0x0000000000000000
> +/* This must match the first entry in level2_kernel_pgt */
> +SYM_DATA(phys_base, .quad 0x0000000000000000)

You can write it

SYM_DATA(phys_base, .quad 0x0)

while at it. That string of 16 zeroes is unreadable and not needed.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
