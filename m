Return-Path: <SRS0=aoLA=42=vger.kernel.org=linux-doc-owner@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 15:02:47 -0700
Message-ID: <2F4A39C5-34EF-4D41-A178-08C34FFA9762@amacapital.net>
References: <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
In-Reply-To: <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200309220247.w-kozLX9-XMfLLqU2xCLEM5QuuJrN5zg37KfIKydo-o@z>


> On Mar 9, 2020, at 2:13 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 9, 2020 at 1:59 PM Dave Hansen <dave.hansen@intel.com=
> wrote:
>>=20
>> On 3/9/20 1:54 PM, H.J. Lu wrote:
>>>> If a program with the magic ELF CET flags missing can=E2=80=99t make a
>>>> thread with IBT and/or SHSTK enabled, then I think we=E2=80=99ve made a=
n
>>>> error and should fix it.
>>>>=20
>>> A non-CET program can start a CET program and vice versa.
>>=20
>> Could we be specific here, please?
>>=20
>> HJ are you saying that:
>> * CET program can execve() a non-CET program, and
>> * a non-CET program can execve() a CET program
>>=20
>> ?
>=20
> Yes.
>=20
>> That's obvious.
>>=20
>> But what are the rules for clone()?  Should there be rules for
>> mismatches for CET enabling between threads if a process (not child
>> processes)?
>=20
> What did you mean? A threaded application is either CET enabled or not
> CET enabled.   A new thread from clone makes no difference.

Why?  Dave=E2=80=99s example seems like a good reason to allow per-thread co=
ntrol.



>=20
> --=20
> H.J.
