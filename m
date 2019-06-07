Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfFGHyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:54:41 -0400
Date: Fri, 7 Jun 2019 09:54:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 23/27] x86/cet/shstk: ELF header parsing of Shadow
 Stack
Message-ID: <20190607075428.GQ3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-24-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-24-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607075428.HmnyYNGbSef9hqNyrCbRP5cR02DQsGD7NmhUPEgx9rA@z>

On Thu, Jun 06, 2019 at 01:06:42PM -0700, Yu-cheng Yu wrote:

> +#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
> +int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> +{
> +	int r;
> +	uint32_t property;

Flip those two lines around.

> +
> +	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> +			     &property);
> +
> +	memset(&current->thread.cet, 0, sizeof(struct cet_status));

It seems to me that memset would be better placed before
get_gnu_property().

> +	if (r)
> +		return r;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {

	if (r || !cpu_feature_enabled())
		return r;

> +		if (property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			r = cet_setup_shstk();
> +		if (r < 0)
> +			return r;
> +	}
> +	return r;

and loose the indent.

> +}
> +#endif
> -- 
> 2.17.1
> 
