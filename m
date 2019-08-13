Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHMXtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 19:49:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so49979445plb.9
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 16:49:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 11/27] x86/mm: Introduce _PAGE_DIRTY_SW
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Date: Tue, 13 Aug 2019 16:49:29 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <08A983E6-7B9C-4BDF-887A-F57734FADC9E@amacapital.net>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com> <20190813205225.12032-12-yu-cheng.yu@intel.com> <dac2d62b-9045-4767-87dd-eac12e7abafd@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190813234929.uqs5-Ff5fofy3YQ01vEi5B-bO4qO35TpZS6Rzw_65Q4@z>


On Aug 13, 2019, at 4:02 PM, Dave Hansen <dave.hansen@intel.com> wrote:

>>=20
>> static inline pte_t pte_mkwrite(pte_t pte)
>> {
>> +    pte =3D pte_move_flags(pte, _PAGE_DIRTY_SW, _PAGE_DIRTY_HW);
>>    return pte_set_flags(pte, _PAGE_RW);
>> }
>=20
> It also isn't clear to me why this *must* move bits here.  Its doubly
> unclear why you would need to do this on systems when shadow stacks are
> compiled in but disabled.

Why is it conditional at all?  ISTM, in x86, RO+dirty has been effectively r=
epurposed. To avoid having extra things that can conditionally break, I thin=
k this code should be unconditional.=20

That being said, I=E2=80=99m not at all sure that pte_mkwrite on a shadow st=
ack page makes any sense.

> <snip>
>=20
> Same comments for pmds and puds.

Wasn=E2=80=99t Kirill working on a rework if the whole page table system to j=
ust have integer page table levels?=
