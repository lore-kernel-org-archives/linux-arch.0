From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Tue, 19 May 2020 18:04:11 -0700
Message-ID: <CALCETrWavh1_Atk=VPQbOoB5tY=zGWGukW8qjF51msKTJSJgQQ@mail.gmail.com>
References: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com> <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lw>
List-Id: linux-arch.vger.kernel.org

On Mon, May 18, 2020 at 6:35 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On May 18, 2020, at 5:38 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > =EF=BB=BFOn 5/18/20 4:47 PM, Yu-cheng Yu wrote:
> >>> On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
> >>> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
> >>>> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
> >>>>> [...]
> >>>>> I have run them with CET enabled.  All of them pass, except for the=
 following:
> >>>>> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a=
 64-bit
> >>>>> address.  This is understandable.
> >>>> [...]
> >>>> One a separate topic: You ran the selftests and one failed.  This is=
 a
> >>>> *MASSIVE* warning sign.  It should minimally be described in your co=
ver
> >>>> letter, and accompanied by a fix to the test case.  It is absolutely
> >>>> unacceptable to introduce a kernel feature that causes a test to fai=
l.
> >>>> You must either fix your kernel feature or you fix the test.
> >>>>
> >>>> This code can not be accepted until this selftests issue is rectifie=
d.
> >> The x86/sigreturn test constructs 32-bit ldt entries, and does sigretu=
rn from
> >> 64-bit to 32-bit context.  We do not have a way to construct a static =
32-bit
> >> shadow stack.
> >
> > Why? What's the limiting factor?  Hardware architecture?  Something in
> > the kernel?
> >
> >> Why do we want that?  I think we can simply run the test with CET
> >> disabled.
> >
> > The sadistic parts of selftests/x86 come from real bugs.  Either bugs
> > where the kernel fell over, or where behavior changed that broke apps.
> > I'd suggest doing some research on where that particular test case came
> > from.  Find the author of the test, look at the changelogs.
> >
> > If this is something that a real app does, this is a problem.  If it's =
a
> > sadistic test that Andy L added because it was an attack vector against
> > the entry code, it's a different story.
>
> There are quite a few tests that do these horrible things in there. IN my=
 personal opinion, sigreturn.c is one of the most important tests we have =
=E2=80=94 it does every horrible thing to the entry code that I thought of =
and that I could come up with a way of doing.  We have been saved from regr=
essing many times by these tests.  CET, and especially the CPL0 version of =
CET, is its own set of entry horror, and we need to keep these tests workin=
g.
>
> I assume the basic issue is that we call raise(), the context magically c=
hanges to 32-bit, but SSP has a 64-bit value, and horrors happen.  So I thi=
nk two things need to happen:
>
> 1. Someone needs to document what happens when IRET tries to put a 64-bit=
 value into SSP but CS is compat. Because Intel has plenty of history of do=
ing colossally broken things here. IOW you could easily be hitting a hardwa=
re design problem, not a software issue per se.
>
> 2. The test needs to work. Assuming the hardware doesn=E2=80=99t do somet=
hing utterly broken, either the 32-bit code needs to be adjusted to avoid a=
ny CALL
> or RET, or you need to write a little raise_on_32bit_shstk() func that sw=
itches to an SSP that fits in 32 bits, calls raise(), and switches back.  F=
rom memory, I didn=E2=80=99t think there was a CALl or RET, so I=E2=80=99m =
guessing that SSP is getting truncated when we round trip through CPL3 comp=
at mode and the result is that the kernel invoked the signal handler with t=
he wrong SSP.  Whoops.
>

Following up here, I think this needs attention from the H/W architects.

From the SDM:

SYSRET and SYSEXIT:

IF ShadowStackEnabled(CPL)
SSP =E2=86=90 IA32_PL3_SSP;
FI;

IRET:

IF ShadowStackEnabled(CPL)
IF CPL =3D 3
THEN tempSSP =E2=86=90 IA32_PL3_SSP; FI;
IF ((EFER.LMA AND CS.L) =3D 0 AND tempSSP[63:32] !=3D 0)
THEN #GP(0); FI;
SSP =E2=86=90 tempSSP

The semantics of actually executing in compat mode with SSP >=3D 2^32
are unclear.  If nothing else, VM exit will save the full SSP and a
subsequent VM entry will fail.

I don't know what the actual effect of operand-size-32 SYSRET or
SYSEXIT with too big a PL3_SSP will be, but I think it needs to be
documented.  Ideally it will not put the CPU in an invalid state.
Ideally it will also not fault, because SYSRET faults in particular
are fatal unless the vector uses IST, and please please please don't
force more ISTs on anyone.

So I think we may need to put this entire series on hold until we get
some answers, because I suspect we're going to have a nice little root
hole otherwise.
