From: "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Fri, 15 May 2020 19:37:00 -0700
Message-ID: <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com> <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com> <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com> <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com> <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6272c481-af90-05c5-7231-3ba44ff9bd02-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Cooper <andrew.cooper3-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jann Horn <jannh@google.>
List-Id: linux-arch.vger.kernel.org

On Fri, May 15, 2020 at 5:13 PM Andrew Cooper <andrew.cooper3-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 15/05/2020 23:43, Dave Hansen wrote:
> > On 5/15/20 2:33 PM, Yu-cheng Yu wrote:
> >> On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
> >>> On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
> >>> Can a binary compiled with CET run without CET?
> >> Yes, but a few details:
> >>
> >> - The shadow stack is transparent to the application.  A CET application does
> >> not have anything different from a non-CET application.  However, if a CET
> >> application uses any CET instructions (e.g. INCSSP), it must first check if CET
> >> is turned on.
> >> - If an application is compiled for IBT, the compiler inserts ENDBRs at branch
> >> targets.  These are nops if IBT is not on.
> > I appreciate the detailed response, but it wasn't quite what I was
> > asking.  Let's ignore IBT for now and just talk about shadow stacks.
> >
> > An app compiled with the new ELF flags and running on a CET-enabled
> > kernel and CPU will start off with shadow stacks allocated and enabled,
> > right?  It can turn its shadow stack off per-thread with the new prctl.
> >  But, otherwise, it's stuck, the only way to turn shadow stacks off at
> > startup would be editing the binary.
> >
> > Basically, if there ends up being a bug in an app that violates the
> > shadow stack rules, the app is broken, period.  The only recourse is to
> > have the kernel disable CET and reboot.
> >
> > Is that right?
>
> If I may interject with the experience of having got supervisor shadow
> stacks working for Xen.
>
> Turning shadow stacks off is quite easy - clear MSR_U_CET.SHSTK_EN and
> the shadow stack will stay in whatever state it was in, and you can
> largely forget about it.  (Of course, in a sandbox scenario, it would be
> prudent to prevent the ability to disable shadow stacks.)
>
> Turning shadow stacks on is much more tricky.  You cannot enable it in
> any function you intend to return from, as the divergence between the
> stack and shadow stack will constitute a control flow violation.
>
>
> When it comes to binaries,  you can reasonably arrange for clone() to
> start a thread on a new stack/shstk, as you can prepare both stacks
> suitably before execution starts.
>
> You cannot reasonably implement a system call for "turn shadow stacks on
> for me", because you'll crash on the ret out of the VDSO from the system
> call.  It would be possible to conceive of an exec()-like system call
> which is "discard my current stack, turn on shstk, and start me on this
> new stack/shstk".
>
> In principle, with a pair of system calls to atomically manage the ststk
> settings and stack switching, it might possible to construct a
> `run_with_shstk_enabled(func, stack, shstk)` API which executes in the
> current threads context and doesn't explode.
>
> Fork() is a problem when shadow stacks are disabled in the parent.  The
> moment shadow stacks are disabled, the regular stack diverges from the
> shadow stack.  A CET-enabled app which turns off shstk and then fork()'s
> must have the child inherit the shstk-off property.  If the child were
> to start with shstk enabled, it would explode almost immediately due to
> the parent's stack divergence which it inherited.
>
>
> Finally seeing as the question was asked but not answered, it is
> actually quite easy to figure out whether shadow stacks are enabled in
> the current thread.
>
>     mov     $1, %eax
>     rdsspd  %eax

This is for 32-bit mode.  I use

        /* Check if shadow stack is in use.  */
        xorl    %esi, %esi
        rdsspq  %rsi
        testq   %rsi, %rsi
        /* Normal return if shadow stack isn't in use.  */
        je      L(no_shstk)

>     cmp     $1, %eax
>     je      no_shstk
>             ...
> no_shsk:
>
> rdssp is allocated from the hint nop encoding space, and the minimum
> alignment of the shadow stack pointer is 4.  On older parts, or with
> shstk disabled (either at the system level, or for the thread), the $1
> will be preserved in %eax, while if CET is active, it will be clobbered
> with something that has the bottom two bits clear.
>
> It turns out this is a lifesaver for codepaths (e.g. the NMI handler)
> which need to use other CET instructions which aren't from the hint nop
> space, and run before the BSP can set everything up.
>
> ~Andrew



-- 
H.J.
