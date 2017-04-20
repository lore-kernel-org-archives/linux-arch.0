Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33745 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031463AbdDTTwU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2017 15:52:20 -0400
Received: by mail-io0-f169.google.com with SMTP id k87so84481552ioi.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Apr 2017 12:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2C2WhWjzF=HrzU15Ncg0juR+nstZukBEpqCrVNW5pnDA@mail.gmail.com>
References: <20161216105634.235457-1-arnd@arndb.de> <3302470.IDcDrWa0u6@wuerfel>
 <CAGXu5jLPRYi+HK=07Zndc8szEKD4mZCqaHJFnHmmoYr7tA1xPw@mail.gmail.com> <CAK8P3a2C2WhWjzF=HrzU15Ncg0juR+nstZukBEpqCrVNW5pnDA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Apr 2017 12:52:18 -0700
Message-ID: <CAGXu5jLTR+dY_Ayyix5Tg0Yn9LBFAt=j56MQVdJVGue-R-CizA@mail.gmail.com>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu
Message-ID: <20170420195218.qSHRiW0oCox_h8lj8bsgysLkzJoCi7_3esSvJv07Q1E@z>

On Thu, Apr 20, 2017 at 3:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Apr 16, 2017 at 9:52 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> The original gcc-4.3 release was in early 2008. If we decide to still
>>>> support that, we probably want the first 10 quirks in this series,
>>>> while gcc-4.6 (released in 2011) requires none of them.
>>
>> I'd be in support of raising the minimum to gcc 4.6. (I'd actually
>> prefer 4.7, just to avoid some 4.6 packaging issues, and for better
>> gcc plugin support.)
>>
>> I'm curious what gcc 4.6 binaries are common in the wild besides
>> old-stable Debian (unsupported in maybe a year from now?) and 12.04
>> Ubuntu (going fully unsupported in 2 weeks). It looks like 4.6 was
>> used only in Fedora 15 and 16 (both EOL).
>
> I think we are better off defining two versions: One that we know
> a lot of people care about, and we actively try to make that work
> well in all configurations (e.g. 4.6, 4.7 or 4.8), fixing all warnings
> we run into, and an older version that we try not to break
> intentionally (e.g. 3.4, 4.1 or 4.3) but that we only fix when
> someone actually runs into a problem they can't work around
> by upgrading to a more modern compiler.

For "working well everywhere" I feel like 4.8 is the better of those
three (I'd prefer 4.9). I think we should avoid 4.6 -- it seems not
widely used.

For an old compiler... yikes. 3.4 sounds insane to me. :)

-Kees

-- 
Kees Cook
Pixel Security
