From: Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 26/26] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Date: Fri, 22 May 2020 19:29:34 +0200
Message-ID: <20200522172934.GI12341@asgard.redhat.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-27-yu-cheng.yu@intel.com>
 <202005211528.A12B4AD@keescook>
 <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 22, 2020 at 10:17:43AM -0700, Yu-cheng Yu wrote:
> On Thu, 2020-05-21 at 15:42 -0700, Kees Cook wrote:
> > On Wed, Apr 29, 2020 at 03:07:32PM -0700, Yu-cheng Yu wrote:
> [...]
> > > +
> > > +int prctl_cet(int option, u64 arg2)
> > > +{
> > > +	struct cet_status *cet;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
> > > +		return -EINVAL;
> > 
> > Using -EINVAL here means userspace can't tell the difference between an
> > old kernel and a kernel not built with CONFIG_X86_INTEL_CET. Perhaps
> > -ENOTSUPP?
> 
> Looked into this.  The kernel and GLIBC are not in sync.  So maybe we still use
> EINVAL here?
> 
> Yu-cheng
> 
> 
> 
> In kernel:
> ----------
> 
> #define EOPNOTSUPP	95
> #define ENOTSUPP 	524
> 
> In GLIBC:
> ---------
> 
> printf("ENOTSUP=%d\n", ENOTSUP);
> printf("EOPNOTSUPP=%d\n", EOPNOTSUPP);
> printf("%s=524\n", strerror(524));
>  
> ENOTSUP=95
> EOPNOTSUPP=95
> Unknown error 524=524

EOPNOTSUPP/ENOTSUP/ENOTSUPP is actually a mess, it's summarized recently
by Michael Kerrisk[1].  From the kernel's point of view, I think it
would be reasonable to return EOPNOTSUPP, and expect that the userspace
would use ENOTSUP to match against it.

[1] https://lore.kernel.org/linux-man/cb4c685b-6c5d-9c16-aade-0c95e57de4b9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org/
