Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCGP2M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Mar 2019 10:28:12 -0500
Date: Thu, 7 Mar 2019 16:28:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: fix building with clang
Message-ID: <20190307152805.GA25101@redhat.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307091218.2343836-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190307152805.d1SD-XVAVzTedNnUQcFgjC5YFqscw5qHG0F7kR7i_oA@z>

On 03/07, Arnd Bergmann wrote:
>
> clang warns about the sigset_t manipulating functions (sigaddset, sigdelset,
> sigisemptyset, ...) because it performs semantic analysis before discarding
> dead code, unlike gcc that does this in the reverse order.
>
> The result is a long list of warnings like:
>
> In file included from arch/arm64/include/asm/ftrace.h:21:
> include/linux/compat.h:489:10: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
>         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];

stupid question... I have no idea if this can work or not, but may be we can just do

	--- x/Makefile
	+++ x/Makefile
	@@ -701,6 +701,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-Qun
	 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
	 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
	 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
	+KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
	 # Quiet clang warning: comparison of unsigned expression < 0 is always false
	 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
	 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the

?

> As a (rather ugly) workaround,

Yes :/

But I am not going to argue, just a couple of questions.

> I turn the nice switch()/case statements
> into preprocessor conditionals, and where that is not possible, use the
> '%' operator

I can't say what looks worse... to me it would be either use ifdef's or %'s
everywhere in signal.h, with this patch the code doesn't look consistent.
But I won't insist.


>  static inline int sigisemptyset(sigset_t *set)
>  {
> -	switch (_NSIG_WORDS) {
> -	case 4:
> -		return (set->sig[3] | set->sig[2] |
> -			set->sig[1] | set->sig[0]) == 0;
> -	case 2:
> -		return (set->sig[1] | set->sig[0]) == 0;
> -	case 1:
> -		return set->sig[0] == 0;
> -	default:
> -		BUILD_BUG();
> -		return 0;
> -	}
> +#if _NSIG_WORDS == 4
> +	return (set->sig[3] | set->sig[2] |
> +		set->sig[1] | set->sig[0]) == 0;
> +#elif _NSIG_WORDS == 2
> +	return (set->sig[1] | set->sig[0]) == 0;
> +#elif _NSIG_WORDS == 1
> +	return set->sig[0] == 0;
> +#else
> +	BUILD_BUG();
> +#endif
>  }

Or perhaps we can simply rewrite this and other helpers?

I don't think that, say,

	static inline int sigisemptyset(sigset_t *set)
	{
		for (i = 0; i < ARRAY_SIZE(set->sig); ++i)
			set->sig[i] = 0;
	}

will make asm worse...

Oleg.
