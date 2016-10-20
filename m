Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61773 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755543AbcJTPCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2016 11:02:21 -0400
MIME-Version: 1.0
In-Reply-To: <1476967442.28989.38.camel@tiscali.nl>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com>
 <1476957892.28989.24.camel@tiscali.nl> <CAK7LNATp2vta0_Qzcs-TuXAX8jQejZyLXiqKKvfi8M=NLtxgAA@mail.gmail.com>
 <1476967442.28989.38.camel@tiscali.nl>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 21 Oct 2016 00:02:01 +0900
Message-ID: <CAK7LNASAJt33-cKxOTqCWXb2A6Ky3rhE0ZOMSone4-JUAxO9OQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
Message-ID: <20161020150201.su5XeT93NqouSKYBn-wSVM5sXe6dazMnN3bgem7BcAM@z>

Hi Paul,


2016-10-20 21:44 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> [Added Nicolas.]
>
> On Thu, 2016-10-20 at 21:06 +0900, Masahiro Yamada wrote:
>> 2016-10-20 19:04 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
>> > On Sun, 2016-10-16 at 20:07 +0900, Masahiro Yamada wrote:
>> > There are about a dozen instances of IS_ENABLED() that target something
>> > other than a kconfig macros. Are you planning to convert those to
>> > __is_defined() too?
>>
>> I did not notice that, but looks like there are some to be checked.
>
> Are you willing to do that or should I give it a try (after this patch
> has landed, of course)?


If you volunteer to do it,
that'll be appreciated.

If you CC me, I am happy to review the patches.


-- 
Best Regards
Masahiro Yamada
