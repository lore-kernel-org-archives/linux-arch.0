From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Fri, 22 May 2020 11:07:49 -0700
Message-ID: <02d825344b39891cf9c084edce44db168cce45fe.camel@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
         <202005221020.B578B8C6@keescook>
         <20200522172711.GA317569@hirez.programming.kicks-ass.net>
         <202005221034.59F5DF75@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <202005221034.59F5DF75@keescook>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pavel
List-Id: linux-arch.vger.kernel.org

On Fri, 2020-05-22 at 10:36 -0700, Kees Cook wrote:
> On Fri, May 22, 2020 at 07:27:11PM +0200, Peter Zijlstra wrote:
> > On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:
> > 
> > > But yes, I think getting a copy of asm.h would be nice here. I don't
> > > think the WRITE_ONCE() is needed in this particular case. Hmm.
> > 
> > Paranoia on my end because I had no clue wth he wanted with his -O0
> > magic gunk.
> 
> Heh, yes, which is why I asked for many more comments. ;) I *think* it
> was entirely to control the stack (and ssp) behavior (i.e. don't inline,
> don't elide unused stack variables, etc).

Yes, that was the reason.

Yu-cheng
