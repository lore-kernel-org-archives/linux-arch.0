From: "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 12:50:15 -0700
Message-ID: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-2-yu-cheng.yu@intel.com>
 <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com> <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
 <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com> <fed72ecc917373669ac546d4e8214793d78bd513.camel@intel.com>
 <9b7ff325-d7cd-9309-d060-ad641486d106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9b7ff325-d7cd-9309-d060-ad641486d106-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 9, 2020 at 12:35 PM Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
> > On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
> >> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
> >>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
> >>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
> >>>>> +  enabled automatically if the binary and the system can support it.
> >>>>
> >>>> This is kinda interesting.  It means that a JIT couldn't choose to
> >>>> protect the code it generates and have different rules from itself?
> >>>
> >>> JIT needs to be updated for CET first.  Once that is done, it runs with CET
> >>> enabled.  It can use the NOTRACK prefix, for example.
> >>
> >> Am I missing something?
> >>
> >> What's the direct connection between shadow stacks and Indirect Branch
> >> Tracking other than Intel marketing umbrellas?
> >
> > What I meant is that JIT code needs to be updated first; if it skips RETs,
> > it needs to unwind the stack, and if it does indirect JMPs somewhere it
> > needs to fix up the branch target or use NOTRACK.
>
> I'm totally lost.  I think we have very different models of how a JIT
> might generate and run code.
>
> I can totally see a scenario where a JIT goes and generates a bunch of
> code, then forks a new thread to go run that code.  The control flow of
> the JIT thread itself *NEVER* interacts with the control flow of the
> program it writes.  They never share a stack and nothing ever jumps or
> rets between the two worlds.
>
> Does anything actually do that?  I've got no idea.  But, I can clearly
> see a world where the entirety of Chrome and Firefox and the entire rust
> runtime might not be fully recompiled and CET-enabled for a while.  But,
> we still want the JIT-generated code to be CET-protected since it has
> the most exposed attack surface.
>
> I don't think that's too far-fetched.

CET support is all or nothing.   You can mix and match, but you will get
no CET protection, similar to NX feature.

-- 
H.J.
