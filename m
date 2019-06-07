Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfFGIHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 04:07:19 -0400
Date: Fri, 7 Jun 2019 10:07:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 07/14] x86/cet/ibt: Add arch_prctl functions for IBT
Message-ID: <20190607080706.GS3419@hirez.programming.kicks-ass.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200926.4029-8-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607080706.0QfCZH7Ia7a9iYgZVUbwcrUVa-2tgWqMhIwBFSVcZ90@z>

On Thu, Jun 06, 2019 at 01:09:19PM -0700, Yu-cheng Yu wrote:

> +static int handle_bitmap(unsigned long arg2)
> +{
> +	unsigned long addr, size;
> +
> +	if (get_user(addr, (unsigned long __user *)arg2) ||
> +	    get_user(size, (unsigned long __user *)arg2 + 1))
> +		return -EFAULT;
> +
> +	return cet_setup_ibt_bitmap(addr, size);
> +}


> +	/*
> +	 * Allocate legacy bitmap and return address & size to user.
> +	 */
> +	case ARCH_X86_CET_SET_LEGACY_BITMAP:
> +		return handle_bitmap(arg2);

AFAICT it does exactly the opposite of that comment; it gets the address
and size from userspace and doesn't allocate anything at all.
