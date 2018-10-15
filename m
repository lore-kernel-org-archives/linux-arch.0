Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35779 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJPG0L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 02:26:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id o63-v6so8150267yba.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 15:38:55 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3130062ywc.72.2018.10.15.15.38.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:38:54 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id v1-v6so8166131ywv.6
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 15:38:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com> <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 15 Oct 2018 15:38:53 -0700
Message-ID: <CAGXu5jL5v_Db9RnLYEJtFcGHYf3j023Kxd5eWvtpBjYYQorYMQ@mail.gmail.com>
Subject: Re: [RFC 17/17] arm64: compile the kernel with ptrauth -msign-return-address
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <jacob.bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Adam Wallis <awallis@codeaurora.org>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, Dave P Martin <Dave.Martin@arm.com>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181015223853.OGqUgOnWU39_jSApo1hRQRDdFOz9scFlMg9f6BiM7I4@z>

On Thu, Oct 11, 2018 at 7:23 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> Hi Kristina,
>
> On 05/10/18 09:47, Kristina Martsenko wrote:
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 106039d25e2f..dbcd43ea99d8 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -56,6 +56,10 @@ KBUILD_AFLAGS      += $(lseinstr) $(brokengasinst)
>>  KBUILD_CFLAGS        += $(call cc-option,-mabi=lp64)
>>  KBUILD_AFLAGS        += $(call cc-option,-mabi=lp64)
>>
>> +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
>> +KBUILD_CFLAGS        += -msign-return-address=all
>> +endif
>
> Should not it be done via cc-option so old toolchains keep working [1]?
>
> [1]
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3 20141031 (prerelease)
> Copyright (C) 2014 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> $ aarch64-linux-gnu-gcc -msign-return-address=all
> aarch64-linux-gnu-gcc: error: unrecognized command line option '-msign-return-address=all'
> ...

I would like to see CONFIG_ARM64_PTR_AUTH testing for compiler support
via Kconfig (as stack-protector does). This would allow developers to
only see the option if it was available (i.e. no "downgrade" happens
if the compiler is missing support). Using cc-option runs the risk of
building a kernel with CONFIG_ARM64_PTR_AUTH set, but _not_ actually
using ptr auth.

-Kees

-- 
Kees Cook
Pixel Security
