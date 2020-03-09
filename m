Return-Path: <SRS0=m5K7=42=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53217 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgCIUQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 16:16:17 -0400
Received: by mail-pj1-f66.google.com with SMTP id f15so373412pjq.2
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2020 13:16:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 13:16:14 -0700
Message-ID: <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
In-Reply-To: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200309201614.x12bCS5Nd-ndtLtNMgIbSBqXcmlEj3XNrEpk3gZK7Ig@z>



> On Mar 9, 2020, at 12:50 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 9, 2020 at 12:35 PM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>>=20
>>> On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
>>> On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
>>>> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
>>>>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
>>>>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
>>>>>>> +  enabled automatically if the binary and the system can support it=
.
>>>>>>=20
>>>>>> This is kinda interesting.  It means that a JIT couldn't choose to
>>>>>> protect the code it generates and have different rules from itself?
>>>>>=20
>>>>> JIT needs to be updated for CET first.  Once that is done, it runs wit=
h CET
>>>>> enabled.  It can use the NOTRACK prefix, for example.
>>>>=20
>>>> Am I missing something?
>>>>=20
>>>> What's the direct connection between shadow stacks and Indirect Branch
>>>> Tracking other than Intel marketing umbrellas?
>>>=20
>>> What I meant is that JIT code needs to be updated first; if it skips RET=
s,
>>> it needs to unwind the stack, and if it does indirect JMPs somewhere it
>>> needs to fix up the branch target or use NOTRACK.
>>=20
>> I'm totally lost.  I think we have very different models of how a JIT
>> might generate and run code.
>>=20
>> I can totally see a scenario where a JIT goes and generates a bunch of
>> code, then forks a new thread to go run that code.  The control flow of
>> the JIT thread itself *NEVER* interacts with the control flow of the
>> program it writes.  They never share a stack and nothing ever jumps or
>> rets between the two worlds.
>>=20
>> Does anything actually do that?  I've got no idea.  But, I can clearly
>> see a world where the entirety of Chrome and Firefox and the entire rust
>> runtime might not be fully recompiled and CET-enabled for a while.  But,
>> we still want the JIT-generated code to be CET-protected since it has
>> the most exposed attack surface.
>>=20
>> I don't think that's too far-fetched.
>=20
> CET support is all or nothing.   You can mix and match, but you will get
> no CET protection, similar to NX feature.
>=20

Can you explain?

If a program with the magic ELF CET flags missing can=E2=80=99t make a threa=
d with IBT and/or SHSTK enabled, then I think we=E2=80=99ve made an error an=
d should fix it.

> --=20
> H.J.
