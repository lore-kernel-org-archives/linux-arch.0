Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from r00tworld.com ([212.85.137.150]:52279 "EHLO r00tworld.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbKZAPx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Nov 2015 19:15:53 -0500
From: "PaX Team" <pageexec@freemail.hu>
Date: Thu, 26 Nov 2015 01:15:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] introduce post-init read-only memory
Reply-to: pageexec@freemail.hu
Message-ID: <56564F0F.3158.108D0B78@pageexec.freemail.hu>
In-reply-to: <1448494286-16029-3-git-send-email-keescook@chromium.org>
References: <1448494286-16029-1-git-send-email-keescook@chromium.org>, <1448494286-16029-3-git-send-email-keescook@chromium.org>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20151126001511.2rY6GuL06AHcOWOnb8mrlKq3_K59xd-AVWnR2y9uUmU@z>

On 25 Nov 2015 at 15:31, Kees Cook wrote:

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index c4bd0e2c173c..772c784ba763 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -256,6 +256,7 @@
>   .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
>    VMLINUX_SYMBOL(__start_rodata) = .;			\
>    *(.rodata) *(.rodata.*)					\
> +		*(.data..ro_after_init)	/* Read only after init */	\
   ^^^^^^^^^^^
looks like it's tabs vs. spaces...

> +/*
> + * __read_only is used to mark things that are read-only after init (i.e.
      ^^^^^^^^^^^
i know you liked the old name but probably this one needs to change too :P

> + * after mark_rodata_ro() has been called). These are effectively read-only,
> + * but may get written to during init, so can't live in .rodata (via "const").
> + */
> +#ifndef __ro_after_init
> +#define __ro_after_init __attribute__((__section__(".data..ro_after_init")))
> +#endif


