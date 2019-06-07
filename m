Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13437 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfFGQZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:25:09 -0400
Message-ID: <1b5778f8f1336ad7a63f4621f189b7f04a56a9ed.camel@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 07 Jun 2019 09:17:06 -0700
In-Reply-To: <20190607075822.GR3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-23-yu-cheng.yu@intel.com>
         <20190607075822.GR3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607161706.qtibFIIkLE_LbDY9YiU4yW99zbmbLJ4AXEr1L9is3yM@z>

On Fri, 2019-06-07 at 09:58 +0200, Peter Zijlstra wrote:
> On Thu, Jun 06, 2019 at 01:06:41PM -0700, Yu-cheng Yu wrote:
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> > 
> > With this patch, if an arch needs to setup features from ELF properties,
> > it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and a specific
> > arch_setup_property().
> > 
> > For example, for X86_64:
> > 
> > int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> > {
> > 	int r;
> > 	uint32_t property;
> > 
> > 	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> > 			     &property);
> > 	...
> > }
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Did HJ write this patch as suggested by that SoB chain? If so, you lost
> a From: line on top, if not, the SoB thing is invalid.

I will fix that.

Yu-cheng
