Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGIJF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 04:09:05 -0400
Date: Fri, 7 Jun 2019 10:08:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
Message-ID: <20190607080832.GT3419@hirez.programming.kicks-ass.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200926.4029-4-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607080832.CmjNEOOF514viRAdSiV2CQy-EXMgfAFOLk3fxqmVnPE@z>

On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
> Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
> that allows execution of legacy, non-IBT compatible library by an
> IBT-enabled application.  When set, each bit in the bitmap indicates
> one page of legacy code.
> 
> The bitmap is allocated and setup from the application.

> +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
> +{
> +	u64 r;
> +
> +	if (!current->thread.cet.ibt_enabled)
> +		return -EINVAL;
> +
> +	if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
> +		return -EINVAL;
> +
> +	current->thread.cet.ibt_bitmap_addr = bitmap;
> +	current->thread.cet.ibt_bitmap_size = size;
> +
> +	/*
> +	 * Turn on IBT legacy bitmap.
> +	 */
> +	modify_fpu_regs_begin();
> +	rdmsrl(MSR_IA32_U_CET, r);
> +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> +	wrmsrl(MSR_IA32_U_CET, r);
> +	modify_fpu_regs_end();
> +
> +	return 0;
> +}

So you just program a random user supplied address into the hardware.
What happens if there's not actually anything at that address or the
user munmap()s the data after doing this?
