Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:57251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGQbp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:31:45 -0400
Message-ID: <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 07 Jun 2019 09:23:43 -0700
In-Reply-To: <20190607080832.GT3419@hirez.programming.kicks-ass.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607162343.tqyk7W73X4KouRipM2KJVEZJnTl0QMCUJbGW3C2YGWc@z>

On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
> > Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
> > that allows execution of legacy, non-IBT compatible library by an
> > IBT-enabled application.  When set, each bit in the bitmap indicates
> > one page of legacy code.
> > 
> > The bitmap is allocated and setup from the application.
> > +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
> > +{
> > +	u64 r;
> > +
> > +	if (!current->thread.cet.ibt_enabled)
> > +		return -EINVAL;
> > +
> > +	if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
> > +		return -EINVAL;
> > +
> > +	current->thread.cet.ibt_bitmap_addr = bitmap;
> > +	current->thread.cet.ibt_bitmap_size = size;
> > +
> > +	/*
> > +	 * Turn on IBT legacy bitmap.
> > +	 */
> > +	modify_fpu_regs_begin();
> > +	rdmsrl(MSR_IA32_U_CET, r);
> > +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> > +	wrmsrl(MSR_IA32_U_CET, r);
> > +	modify_fpu_regs_end();
> > +
> > +	return 0;
> > +}
> 
> So you just program a random user supplied address into the hardware.
> What happens if there's not actually anything at that address or the
> user munmap()s the data after doing this?

This function checks the bitmap's alignment and size, and anything else is the
app's responsibility.  What else do you think the kernel should check?

Yu-cheng
