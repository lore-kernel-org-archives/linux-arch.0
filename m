Return-Path: <SRS0=ekR5=6V=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26106 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGQ7A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 May 2020 12:59:00 -0400
Message-ID: <e0bb75f71ccc7fdf5cd5012441536918a09a9322.camel@intel.com>
Subject: Re: [PATCH v10 05/26] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 07 May 2020 09:59:02 -0700
In-Reply-To: <f4329e8c-0b3a-2c52-2145-08ea4dcab26e@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-6-yu-cheng.yu@intel.com>
         <f4329e8c-0b3a-2c52-2145-08ea4dcab26e@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200507165902.Bm9j1WGSTAFDOyYcRMrVeLb72ny7JgxfFW7-U3nKNWI@z>

On Thu, 2020-05-07 at 08:55 -0700, Dave Hansen wrote:
> On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
> > +config X86_INTEL_SHADOW_STACK_USER
> > +	prompt "Intel Shadow Stacks for user-mode"
> > +	def_bool n
> > +	depends on CPU_SUP_INTEL && X86_64
> > +	depends on AS_HAS_SHADOW_STACK
> > +	select ARCH_USES_HIGH_VMA_FLAGS
> > +	select X86_INTEL_CET
> > +	select ARCH_HAS_SHADOW_STACK
> 
> I called protection keys: X86_INTEL_MEMORY_PROTECTION_KEYS
> 
> AMD recently posted documentation which shows them implementing it as
> well.  The "INTEL_" is feeling now like a mistake.
> 
> Going forward, we should probably avoid sticking the company name on
> them, if for no other reason than avoiding confusion and/or churn in the
> future.
> 
> Shadow stacks, for instance, seem like something that another vendor
> might implement one day.  So, let's at least remove the "INTEL_" from
> the config option names themselves.  Mentioning Intel in the changelog
> and the Kconfig help text is fine.

Yes, sure.

Yu-cheng
