Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbfFGRFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 13:05:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so1521113pfg.10
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 10:05:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <ac8827d7b516f4b58e1df20f45b94998d36c418c.camel@intel.com>
Date: Fri, 7 Jun 2019 10:05:13 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <A495EEB4-F05F-4AB3-831A-0F15B912A7EC@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com> <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net> <ac8827d7b516f4b58e1df20f45b94998d36c418c.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607170513.dGBIXPGyyK6NkvKk6tUz_02wnLd8Y-wkXDrChOOFdrE@z>




> On Jun 7, 2019, at 9:45 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
> On Fri, 2019-06-07 at 09:35 -0700, Andy Lutomirski wrote:
>>> On Jun 7, 2019, at 9:23 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>=20
>>>>> On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
>>>>> On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
>>>>> Indirect Branch Tracking (IBT) provides an optional legacy code bitmap=

>>>>> that allows execution of legacy, non-IBT compatible library by an
>>>>> IBT-enabled application.  When set, each bit in the bitmap indicates
>>>>> one page of legacy code.
>>>>>=20
>>>>> The bitmap is allocated and setup from the application.
>>>>> +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
>>>>> +{
>>>>> +    u64 r;
>>>>> +
>>>>> +    if (!current->thread.cet.ibt_enabled)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    current->thread.cet.ibt_bitmap_addr =3D bitmap;
>>>>> +    current->thread.cet.ibt_bitmap_size =3D size;
>>>>> +
>>>>> +    /*
>>>>> +     * Turn on IBT legacy bitmap.
>>>>> +     */
>>>>> +    modify_fpu_regs_begin();
>>>>> +    rdmsrl(MSR_IA32_U_CET, r);
>>>>> +    r |=3D (MSR_IA32_CET_LEG_IW_EN | bitmap);
>>>>> +    wrmsrl(MSR_IA32_U_CET, r);
>>>>> +    modify_fpu_regs_end();
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>=20
>>>> So you just program a random user supplied address into the hardware.
>>>> What happens if there's not actually anything at that address or the
>>>> user munmap()s the data after doing this?
>>>=20
>>> This function checks the bitmap's alignment and size, and anything else i=
s
>>> the
>>> app's responsibility.  What else do you think the kernel should check?
>>>=20
>>=20
>> One might reasonably wonder why this state is privileged in the first pla=
ce
>> and, given that, why we=E2=80=99re allowing it to be written like this.
>>=20
>> Arguably we should have another prctl to lock these values (until exec) a=
s a
>> gardening measure.
>=20
> We can prevent the bitmap from being set more than once.  I will test it.
>=20

I think it would be better to make locking an explicit opt-in.=
