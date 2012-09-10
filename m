From: czankel <chris@zankel.net>
Subject: Re: [PATCH 4/4] xtensa: Setup CROSS_COMPILE at the top
Date: Mon, 10 Sep 2012 22:33:02 +0200
Message-ID: <504E4E7E.30608@zankel.net>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org> <1336855148-18817-4-git-send-email-geert@linux-m68k.org> <CAMuHMdXi9+vRk2R61qnzGg7p9e7p9DR1C_Ozw6MFCv+YqhSpVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38534 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab2IJUdJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2012 16:33:09 -0400
Received: by weyx8 with SMTP id x8so1543104wey.19
        for <linux-arch@vger.kernel.org>; Mon, 10 Sep 2012 13:33:08 -0700 (PDT)
In-Reply-To: <CAMuHMdXi9+vRk2R61qnzGg7p9e7p9DR1C_Ozw6MFCv+YqhSpVg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 9/9/12 10:20 AM, Geert Uytterhoeven wrote:
> On Sat, May 12, 2012 at 10:39 PM, Geert Uytterhoeven
> <geert@linux-m68k.org>  wrote:
>> CROSS_COMPILE must be setup before using e.g. cc-option (and a few other
>> as-*, cc-*, ld-* macros), else they will check against the wrong compiler
>> when cross-compiling, and may invoke the cross compiler with wrong or
>> suboptimal compiler options.
>>
>> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>
>> Cc: Chris Zankel<chris@zankel.net>
>>
>> Ping?
Acked-by: Chris Zankel <chris@zankel.net>


>>
>> ---
>>   arch/xtensa/Makefile |   24 ++++++++++++------------
>>   1 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
>> index 7608559..d41f9ed 100644
>> --- a/arch/xtensa/Makefile
>> +++ b/arch/xtensa/Makefile
>> @@ -21,6 +21,18 @@ variant-$(CONFIG_XTENSA_VARIANT_LINUX_CUSTOM)        := custom
>>   VARIANT = $(variant-y)
>>   export VARIANT
>>
>> +# Test for cross compiling
>> +
>> +ifneq ($(VARIANT),)
>> +  COMPILE_ARCH = $(shell uname -m)
>> +
>> +  ifneq ($(COMPILE_ARCH), xtensa)
>> +    ifndef CROSS_COMPILE
>> +      CROSS_COMPILE = xtensa_$(VARIANT)-
>> +    endif
>> +  endif
>> +endif
>> +
>>   # Platform configuration
>>
>>   platform-$(CONFIG_XTENSA_PLATFORM_XT2000)      := xt2000
>> @@ -54,18 +66,6 @@ KBUILD_DEFCONFIG := iss_defconfig
>>
>>   core-$(CONFIG_EMBEDDED_RAMDISK)        += arch/xtensa/boot/ramdisk/
>>
>> -# Test for cross compiling
>> -
>> -ifneq ($(VARIANT),)
>> -  COMPILE_ARCH = $(shell uname -m)
>> -
>> -  ifneq ($(COMPILE_ARCH), xtensa)
>> -    ifndef CROSS_COMPILE
>> -      CROSS_COMPILE = xtensa_$(VARIANT)-
>> -    endif
>> -  endif
>> -endif
>> -
>>   # Only build variant and/or platform if it includes a Makefile
>>
>>   buildvar := $(shell test -a $(srctree)/arch/xtensa/variants/$(VARIANT)/Makefile&&  echo arch/xtensa/variants/$(VARIANT)/)
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
