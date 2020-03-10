From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 18:21:01 -0700
Message-ID: <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
References: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.co>
List-Id: linux-arch.vger.kernel.org

I am baffled by this discussion.

>> On Mar 9, 2020, at 5:09 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>>=20
>> =EF=BB=BFOn Mon, Mar 9, 2020 at 4:59 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>=20
>>>> .
>> This could presumably have been fixed by having libpcre or sljit
>> disable IBT before calling into JIT code or by running the JIT code in
>> another thread.  In the other direction, a non-CET libpcre build could
>> build IBT-capable JITted code and enable JIT (by syscall if we allow
>> that or by creating a thread?) when calling it.  And IBT has this
>=20
> This is not how thread in user space works.

void create_cet_thread(void (*func)(), unsigned int cet_flags);

I could implement this using clone() if the kernel provides the requisite su=
pport. Sure, creating threads behind libc=E2=80=99s back like this is perilo=
us, but it can be done.

>=20
>> fancy legacy bitmap to allow non-instrumented code to run with IBT on,
>> although SHSTK doesn't have hardware support for a similar feature.
>=20
> All these changes are called CET enabing.

What does that mean?  If program A loads library B, and library B very caref=
ully loads CET-mismatched code, program A may be blissfully unaware.

>=20
>> So, sure, the glibc-linked ELF ecosystem needs some degree of CET
>> coordination, but it is absolutely not the case that a process MUST
>> have all CET or no CET.  Let's please support the complicated cases in
>> the kernel and the ABI too.  If glibc wants to make it annoying to do
>> complicated things, so be it.  People work behind glibc's back all the
>> time.
>=20
> CET is no different from NX in this regard.

NX is in the page tables, and CET, mostly, is not.  Also, we seriously flubb=
ed READ_IMPLIES_EXEC and made it affect far more mappings than ever should h=
ave been affected.

If a legacy program (non-NX-aware) loads a newer library, and the library op=
ens a device node and mmaps it PROT_READ, it gets RX.  This is not a good de=
sign. In fact, it=E2=80=99s actively problematic.

Let us please not take Linux=E2=80=99s NX legacy support as an example of go=
od design.=
