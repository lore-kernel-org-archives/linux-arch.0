From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Mon, 18 May 2020 18:35:21 -0700
Message-ID: <58319765-891D-44B9-AF18-64492B01FF36@amacapital.net>
References: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org



> On May 18, 2020, at 5:38 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 5/18/20 4:47 PM, Yu-cheng Yu wrote:
>>> On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
>>> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
>>>> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
>>>>> [...]
>>>>> I have run them with CET enabled.  All of them pass, except for the fo=
llowing:
>>>>> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64=
-bit
>>>>> address.  This is understandable.
>>>> [...]
>>>> One a separate topic: You ran the selftests and one failed.  This is a
>>>> *MASSIVE* warning sign.  It should minimally be described in your cover=

>>>> letter, and accompanied by a fix to the test case.  It is absolutely
>>>> unacceptable to introduce a kernel feature that causes a test to fail.
>>>> You must either fix your kernel feature or you fix the test.
>>>>=20
>>>> This code can not be accepted until this selftests issue is rectified.
>> The x86/sigreturn test constructs 32-bit ldt entries, and does sigreturn f=
rom
>> 64-bit to 32-bit context.  We do not have a way to construct a static 32-=
bit
>> shadow stack.
>=20
> Why? What's the limiting factor?  Hardware architecture?  Something in
> the kernel?
>=20
>> Why do we want that?  I think we can simply run the test with CET
>> disabled.
>=20
> The sadistic parts of selftests/x86 come from real bugs.  Either bugs
> where the kernel fell over, or where behavior changed that broke apps.
> I'd suggest doing some research on where that particular test case came
> from.  Find the author of the test, look at the changelogs.
>=20
> If this is something that a real app does, this is a problem.  If it's a
> sadistic test that Andy L added because it was an attack vector against
> the entry code, it's a different story.

There are quite a few tests that do these horrible things in there. IN my pe=
rsonal opinion, sigreturn.c is one of the most important tests we have =E2=80=
=94 it does every horrible thing to the entry code that I thought of and tha=
t I could come up with a way of doing.  We have been saved from regressing m=
any times by these tests.  CET, and especially the CPL0 version of CET, is i=
ts own set of entry horror, and we need to keep these tests working.

I assume the basic issue is that we call raise(), the context magically chan=
ges to 32-bit, but SSP has a 64-bit value, and horrors happen.  So I think t=
wo things need to happen:

1. Someone needs to document what happens when IRET tries to put a 64-bit va=
lue into SSP but CS is compat. Because Intel has plenty of history of doing c=
olossally broken things here. IOW you could easily be hitting a hardware des=
ign problem, not a software issue per se.

2. The test needs to work. Assuming the hardware doesn=E2=80=99t do somethin=
g utterly broken, either the 32-bit code needs to be adjusted to avoid any C=
ALL
or RET, or you need to write a little raise_on_32bit_shstk() func that switc=
hes to an SSP that fits in 32 bits, calls raise(), and switches back.  =46rom=
 memory, I didn=E2=80=99t think there was a CALl or RET, so I=E2=80=99m gues=
sing that SSP is getting truncated when we round trip through CPL3 compat mo=
de and the result is that the kernel invoked the signal handler with the wro=
ng SSP.  Whoops.

>=20
> I don't personally know the background, but the changelogs can help you
> find the person that does.
