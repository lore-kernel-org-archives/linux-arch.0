Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40394 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755018AbdLOKgC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Dec 2017 05:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <1513296698.18523.291.camel@codethink.co.uk>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <20171127193037.8711-8-deepa.kernel@gmail.com>
 <1513296698.18523.291.camel@codethink.co.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Dec 2017 11:36:01 +0100
Message-ID: <CAK8P3a29Nh6bK4tgNM8PxUCj_XnzU71vZR992=E5MUUFkSjPNg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v2 07/10] include: Add new y2038 safe __kernel_timespec
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, y2038 Mailman List <y2038@lists.linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Albert ARIBAUD <albert.aribaud@3adev.fr>, GNU C Library <libc-alpha@sourceware.org>
Message-ID: <20171215103601.MUvyvh4vkek8GaTwK57JjLxq-SxOZUxWV1xNRN-ZU-8@z>

On Fri, Dec 15, 2017 at 1:11 AM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Mon, 2017-11-27 at 11:30 -0800, Deepa Dinamani wrote:
>> --- a/include/uapi/linux/time.h
>> +++ b/include/uapi/linux/time.h
>> @@ -42,6 +42,13 @@ struct itimerval {
>> > >   struct timeval it_value;        /* current value */
>>  };
>>
>> +#ifndef __kernel_timespec
>> +struct __kernel_timespec {
>> +     __kernel_time64_t       tv_sec;                 /* seconds */
>> +     long long               tv_nsec;                /* nanoseconds */
>> +};
>> +#endif
>
> I wonder if it makes sense to override the alignment of this structure?
>  (64-bit types are aligned differently on 32-bit vs 64-bit x86, but not
> other compat cases.)  It might reduce the need for conversions in
> compat code elsewhere later.

I think the alignment here should be agreed with glibc so they use the
same alignment for their new timespec. I don't see a specific mention
of this at
https://sourceware.org/glibc/wiki/Y2038ProofnessDesign#struct___timespec64
so I'm adding Albert and libc-alpha to Cc for clarification.

I agree it would simplify things a bit to ensure that time64_t and
__timespec64/__kernel_timespec have a 64-bit alignment even on
x86-32, but I don't know if there is precedent for using gcc
__attribute__((aligned(8)) on POSIX data types, of if that might
cause problems e.g. for non-gnu compilers.

       Arnd
