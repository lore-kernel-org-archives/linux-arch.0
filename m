From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Thu, 21 May 2020 16:23:38 -0700
Message-ID: <a8f55ca9d7ca81b4acb7afecd8144aa396975cfb.camel@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <202005211550.AF0E83BB@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <202005211550.AF0E83BB@keescook>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel
List-Id: linux-arch.vger.kernel.org

On Thu, 2020-05-21 at 16:02 -0700, Kees Cook wrote:
> On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> > Introduce a quick test to verify shadow stack and IBT are working.
> 
> Cool! :)
> 
> I'd love to see either more of a commit log or more comments in the test
> code itself. I had to spend a bit of time trying to understand how the
> test was working. (i.e. using ucontext to "reset", using segv handler to
> catch some of them, etc.) I have not yet figured out why you need to
> send USR1/USR2 for two of them instead of direct calls?

Yes, I will work on it.

[...]

> > +
> > +#pragma GCC push_options
> > +#pragma GCC optimize ("O0")
> 
> Can you avoid compiler-specific pragmas? (Or verify that Clang also
> behaves correctly here?) Maybe it's better to just build the entire file
> with -O0 in the Makefile?

This file is compiled using -O2 in the makefile.  I will see if other ways are
possible.

[...]

> > +
> > +void segv_handler(int signum, siginfo_t *si, void *uc)
> > +{
> 
> Does anything in siginfo_t indicate which kind of failure you're
> detecting? It'd be nice to verify test_id matches the failure mode being
> tested.

Yes, there is an si_code for control-protection fault.
I will fix this.

Agree with your other comments.

Thanks,
Yu-cheng
