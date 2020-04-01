Return-Path: <SRS0=KXl1=5R=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29382 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgDATIT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Apr 2020 15:08:19 -0400
Message-ID: <6f68d7af6a618c087a85d2db6ad40b346e055452.camel@intel.com>
Subject: Re: [RFC PATCH v9 09/27] x86/mm: Introduce _PAGE_DIRTY_SW
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 01 Apr 2020 12:08:16 -0700
In-Reply-To: <325d3a25-0016-ea19-c0c9-7958066fc94e@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-10-yu-cheng.yu@intel.com>
         <325d3a25-0016-ea19-c0c9-7958066fc94e@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200401190816.u-sppJa1BvPyHBMGG_u32chndxC34rD_8x6-tkE463M@z>

On Wed, 2020-02-26 at 13:35 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > When Shadow Stack (SHSTK) is introduced, a R/O and Dirty PTE exists in the
> > following cases:
> > 
> > (a) A modified, copy-on-write (COW) page;
> > (b) A R/O page that has been COW'ed;
> > (c) A SHSTK page.
[...]

> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index e647e3c75578..826823df917f 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -23,7 +23,8 @@
> >  #define _PAGE_BIT_SOFTW2	10	/* " */
> >  #define _PAGE_BIT_SOFTW3	11	/* " */
> >  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> > -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> > +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> > +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
> >  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
> >  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
> >  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> > @@ -35,6 +36,12 @@
> >  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
> >  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
> >  
> > +/*
> > + * This bit indicates a copy-on-write page, and is different from
> > + * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
> > + */
> > +#define _PAGE_BIT_DIRTY_SW	_PAGE_BIT_SOFTW5 /* was written to */
> 
> Does it *only* indicate a copy-on-write (or copy-on-access) page?  If
> so, haven't we misnamed it?

It indicates either a copy-on-write page or a read-only page that has been
cow'ed.  What about _PAGE_BIT_COW?

Yu-cheng
