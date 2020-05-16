From: Andrew Cooper <andrew.cooper3-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Sat, 16 May 2020 15:09:22 +0100
Message-ID: <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
 <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 16/05/2020 03:37, H.J. Lu wrote:
> On Fri, May 15, 2020 at 5:13 PM Andrew Cooper <andrew.cooper3-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org> wrote:
>> Finally seeing as the question was asked but not answered, it is
>> actually quite easy to figure out whether shadow stacks are enabled in
>> the current thread.
>>
>>     mov     $1, %eax
>>     rdsspd  %eax
> This is for 32-bit mode.

It actually works for both, if all you need is a shstk yes/no check.

Usually, you also want SSP in the yes case, so substitute rdsspq %rax as
appropriate.

(On a tangent - binutils mandating the D/Q suffixes is very irritating
with mixed 32/64bit code because you have to #ifdef your instructions
despite the register operands being totally unambiguous.  Also, D is the
wrong suffix for AT&T syntax, and should be L.  Frankly - the Intel
manuals are wrong and should not have the operand size suffix included
in the opcode name, as they are consistent with all the other
instructions in this regard.)

>   I use
>
>         /* Check if shadow stack is in use.  */
>         xorl    %esi, %esi
>         rdsspq  %rsi
>         testq   %rsi, %rsi
>         /* Normal return if shadow stack isn't in use.  */
>         je      L(no_shstk)

This is probably fine for user code, as I don't think it would be
legitimate for shstk to be enabled, with SSP being 0.

Sadly, the same is not true for kernel shadow stacks.

SSP is 0 after SYSCALL, SYSENTER and CLRSSBSY, and you've got to be
careful to re-establish the shadow stack before a CALL, interrupt or
exception tries pushing a word onto the shadow stack at 0xfffffffffffffff8.

It is a very good (lucky?) thing that frame is unmapped for other
reasons, because this corner case does not protect against multiple
threads/cores using the same shadow stack concurrently.

~Andrew
