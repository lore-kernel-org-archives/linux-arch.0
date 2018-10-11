Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKVue (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Oct 2018 17:50:34 -0400
Subject: Re: [RFC 17/17] arm64: compile the kernel with ptrauth
 -msign-return-address
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
Date: Thu, 11 Oct 2018 15:23:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181005084754.20950-18-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kristina Martsenko <kristina.martsenko@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Adam Wallis <awallis@codeaurora.org>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, Dave P Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Message-ID: <20181011142305.SnEb6D8N-tWlQd1RU7xK3pUvvFdPqmfQ1V26kX5J6zw@z>

Hi Kristina,

On 05/10/18 09:47, Kristina Martsenko wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d25e2f..dbcd43ea99d8 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -56,6 +56,10 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>  
> +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
> +KBUILD_CFLAGS	+= -msign-return-address=all
> +endif

Should not it be done via cc-option so old toolchains keep working [1]?

[1]
$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3 20141031 (prerelease)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ aarch64-linux-gnu-gcc -msign-return-address=all
aarch64-linux-gnu-gcc: error: unrecognized command line option '-msign-return-address=all'
...

Cheers
Vladimir
