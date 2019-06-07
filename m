Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:5427 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfFGTbu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 15:31:50 -0400
Message-ID: <997ef050c13e3654dee6a862d810cffcafce249b.camel@intel.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 07 Jun 2019 12:23:46 -0700
In-Reply-To: <c5c21778-f10f-cef8-c937-1e8ad1e2a7cf@intel.com>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <c5c21778-f10f-cef8-c937-1e8ad1e2a7cf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607192346.s5pGrXA4Djjcm4WmVbG5_OfPPzTrLAQZT3p77jMVpWg@z>

On Fri, 2019-06-07 at 12:03 -0700, Dave Hansen wrote:
> On 6/6/19 1:09 PM, Yu-cheng Yu wrote:
> > +	modify_fpu_regs_begin();
> > +	rdmsrl(MSR_IA32_U_CET, r);
> > +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> > +	wrmsrl(MSR_IA32_U_CET, r);
> > +	modify_fpu_regs_end();
> 
> Isn't there a bunch of other stuff in this MSR?  It seems like the
> bitmap value would allow overwriting lots of bits in the MSR that have
> nothing to do with the bitmap... in a prctl() that's supposed to only be
> dealing with the bitmap.

Yes, the bitmap address should have been masked, although it is checked for page
alignment (which has the same effect).  I will fix it.

Yu-cheng
