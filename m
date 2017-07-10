From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 00/28] kbuild: complete UAPI de-coupling and cleanup scripts/Makefile.headersinst
Date: Mon, 10 Jul 2017 18:12:28 +0900
Message-ID: <CAK7LNASdy7Lm+Bos2usOUeEPrCYzTdfVk1T79zm9v8JOTNEBZg@mail.gmail.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com> <20170710084208.GA25874@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:36420 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdGJJMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2017 05:12:48 -0400
In-Reply-To: <20170710084208.GA25874@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Sam,


2017-07-10 17:42 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro.
>
> On Mon, Jul 10, 2017 at 03:32:32AM +0900, Masahiro Yamada wrote:
>> In v4.12-rc1, we had a big progress for headers_install.
>> All (and only) headers under UAPI directories are exported.
>> However, asm-generic wrappers are still exceptions because
>> most of arch/*/include/asm/Kbuild include "generic-y" for
>> exported headers.  As a result, many of generic-wrappers to be
>> exported are generated outside UAPI directories.
>>
>> To finish de-coupling UAPI, "generic-y" for exported headers
>> should be moved to arch/*/include/uapi/asm/Kbuild.
>>
>> With those cleanups, the logic of headers_install will become
>> even simpler.  UAPI will be completely self-contained.
>>
>> This series is based on:
>> commit 19bf2e0ef18ec8a7284ecc83459a2664cb885cd5
>>
>> Changes for v2:
>>   - rebase on the latest in the mainline in order to avoid merge conflicts
>
> Series looks good.
>
> In several of your patches assignments are moved to the arch
> specific uapi file, but the same assignment are already present in
> include/uapi/asm-generic/Kbuild.asm so the assignment is redundant.
>
> For example:
> $ARCH uapi Kbuild:
> generic-y += errno.h
>
> uapi/asm-generic Kbuild:
> mandatory-y += errno.h
>
> As this patch-set is touching all arch files this
> could be a good opportunity to clean this up too.
>
> But maybe mandatory-y and generic-y do something different,
> and both are needed. In wich cases all is good.
>

Thanks for your review, and you have a good point.

If neither arch-own header implementation is found
nor generic-y is specified, the build system can automatically generate
generic wrappers for "mandatory" headers.

I also considered of it, but I wanted to take my time.

I simply moved generic-y without introducing any logical change
in order to make this series less controversial.

One point of forcing explicit generic-y might be,
to give arch maintainers an opportunity to judge
if falling back to asm-generic one works or not.



-- 
Best Regards
Masahiro Yamada
