Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfBILZ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Feb 2019 06:25:58 -0500
Date: Sat, 9 Feb 2019 12:25:51 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190209112551.GA5089@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-6-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190209112551.P0Dh04e0qhqIgzTCztA0oa9jJHepBLs7La2nCA4HztA@z>

On Wed, Jan 30, 2019 at 01:46:48PM +0100, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.
> 
> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
> and SYM_CODE_END too.
> 
> The result:
>  Value  Size Type    Bind   Vis      Ndx Name
>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/thunk_32.S | 4 ++--
>  arch/x86/entry/thunk_64.S | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

...

> @@ -57,7 +56,7 @@
>  #if defined(CONFIG_TRACE_IRQFLAGS) \
>   || defined(CONFIG_DEBUG_LOCK_ALLOC) \
>   || defined(CONFIG_PREEMPT)
> -.L_restore:
> +SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>  	popq %r11
>  	popq %r10
>  	popq %r9
> @@ -70,4 +69,5 @@
>  	popq %rbp
>  	ret
>  	_ASM_NOKPROBE(.L_restore)
> +SYM_CODE_END(.L_restore)

That local label doesn't even land in the symbol table:

$ readelf -a  arch/x86/entry/thunk_64.o | grep restore
$

so no need to touch it, AFAICT. And all local labels, for that matter.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
