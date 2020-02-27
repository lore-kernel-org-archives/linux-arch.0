From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for user-mode Shadow Stack protection
Date: Wed, 26 Feb 2020 19:57:01 -0800
Message-ID: <FF42D299-D7A4-4884-9E45-DBEB5853FE56@amacapital.net>
References: <CAMe9rOqhf4y+e6h8i7P8+70pwLSg8n=ise6LEqABNPKarECdeA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43199 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgB0D5F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 22:57:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so883145pfh.10
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 19:57:05 -0800 (PST)
In-Reply-To: <CAMe9rOqhf4y+e6h8i7P8+70pwLSg8n=ise6LEqABNPKarECdeA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>


> On Feb 26, 2020, at 6:11 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 26, 2020 at 5:16 PM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>>=20
>> On 2/26/20 5:02 PM, H.J. Lu wrote:
>>>> That way everybody with old toolchains can still build the kernel (and
>>>> run/test code with your config option on, btw...).
>>> CET requires a complete new OS image from kernel, toolchain, run-time.
>>> CET enabled kernel without the rest of updated OS won't give you CET
>>> at all.
>>=20
>> If you require a new toolchain, nobody even builds your fancy feature.
>> Probably including 0day and all of the lazy maintainers with crufty old
>> distros.
>=20
> GCC 8 or above is needed since vDSO must be compiled with
> --fcf-protection=3Dbranch.

Fair enough. I don=E2=80=99t particularly want to carry a gross hack to add t=
he ENDBRANCHes without compiler support.
