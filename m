From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/5] kernel: tracepoints: add support for relative
 references
Date: Fri, 18 Aug 2017 10:26:16 +0200
Message-ID: <20170818082616.vyk5z5s2kicc66ip@gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
 <20170814105231.14608-6-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33272 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdHRI0U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 04:26:20 -0400
Content-Disposition: inline
In-Reply-To: <20170814105231.14608-6-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rosted>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> -static void for_each_tracepoint_range(struct tracepoint * const *begin,
> -		struct tracepoint * const *end,
> +static void for_each_tracepoint_range(const void *begin, const void *end,
>  		void (*fct)(struct tracepoint *tp, void *priv),
>  		void *priv)
>  {
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +	const signed int *iter;
> +
> +	if (!begin)
> +		return;
> +	for (iter = begin; iter < (signed int *)end; iter++) {
> +		fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
> +	}

I think checkpatch is correct here to complain about the unnecessary curly braces 
here.

Plus why the heavy use of 'signed int' here and elsewhere in the patches - why 
not 'int' ?

Plus #2, the heavy use of type casts looks pretty ugly to begin with - is there no 
way to turn this into more natural code?

Thanks,

	Ingo
