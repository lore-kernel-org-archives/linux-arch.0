Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:27510 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756518AbeEJDj5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 23:39:57 -0400
MIME-Version: 1.0
In-Reply-To: <20180509160727.GA7459@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
 <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com> <20180509160727.GA7459@ravnborg.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 May 2018 12:39:11 +0900
Message-ID: <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
Subject: Re: [PATCH 5/8] export.h: remove code for prefixing symbols with underscore
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180510033911.zzWVmPT6uS3zFv7ACMm4bnLClNZ9wTnga0TJIObZCmc@z>

Hi Sam,

2018-05-10 1:07 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro
>
> On Wed, May 09, 2018 at 04:23:49PM +0900, Masahiro Yamada wrote:
>> CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
>> They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
>> commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.
>>
>> No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX.
>> Clean up the export.h headers.  I am keeping VMLINUX_SYMBOL() and
>> VMLINUX_SYMBOL_STR() because they are widely used.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>> diff --git a/include/linux/export.h b/include/linux/export.h
>> index 1a1dfdb..b768d6d 100644
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -10,14 +10,8 @@
>>   * hackers place grumpy comments in header files.
>>   */
>>
>> -/* Some toolchains use a `_' prefix for all user symbols. */
>> -#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
>> -#define __VMLINUX_SYMBOL(x) _##x
>> -#define __VMLINUX_SYMBOL_STR(x) "_" #x
>> -#else
>>  #define __VMLINUX_SYMBOL(x) x
>>  #define __VMLINUX_SYMBOL_STR(x) #x
>> -#endif
>>
>>  /* Indirect, so macros are expanded before pasting. */
>>  #define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
>
> Since we no longer need any expansion, then the indirection
> seems unnessesary.
>
> I think we can reduce this to just:
> #define VMLINUX_SYMBOL(x) x

Thanks for the review.

Right.  We can do like this for VMLINUX_SYMBOL.


> Likewise for __VMLINUX_SYMBOL_STR


VMLINUX_SYMBOL_STR still need the double expansion
because we need to expand the argument before turning it into a string.

In other words, VMLINUX_SYMBOL_STR() should be equivalent
to __stringify() defined in <linux/stringify.h>



So, I can do like follows, but it is unbalanced.


#define VMLINUX_SYMBOL(x)     x

/* Indirect, so macros are expanded before pasting. */
#define __VMLINUX_SYMBOL_STR(x) #x
#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)



I decided to simply remove unnecessary lines
to avoid any possible troubles.

Anyway VMLINUX_SYMBOL(), VMLINUX_SYMBOL_STR() will not live long.
I need some cycles for tree-wide cleaning, though.


-- 
Best Regards
Masahiro Yamada
