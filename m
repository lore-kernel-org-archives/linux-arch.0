From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 09/27] x86/mm: Introduce _PAGE_DIRTY_SW
Date: Wed, 01 Apr 2020 12:08:16 -0700
Message-ID: <6f68d7af6a618c087a85d2db6ad40b346e055452.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-10-yu-cheng.yu@intel.com>
         <325d3a25-0016-ea19-c0c9-7958066fc94e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <325d3a25-0016-ea19-c0c9-7958066fc94e-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

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
