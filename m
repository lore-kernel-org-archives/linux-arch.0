Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:11823 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfH2E4C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 00:56:02 -0400
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr> <201908241206.D223659@keescook>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
Date: Thu, 29 Aug 2019 06:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <201908241206.D223659@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190829045559.9fbqPMfZvenv6nCGcY6FoO4OSJwRoH7kpxqG1DjzbNQ@z>


Le 24/08/2019 à 21:08, Kees Cook a écrit :

Euh ... only received this mail yesterday. Same for the other answer.


> On Fri, Aug 23, 2019 at 04:26:59PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 23/08/2019 à 00:56, Andrew Morton a écrit :
>>> On Tue, 20 Aug 2019 09:47:55 -0700 Kees Cook <keescook@chromium.org> wrote:
>>>
>>>> Reply-To: 20190819234111.9019-8-keescook@chromium.org
>>>
>>> Really?
>>
>> That seems correct, that's the "[PATCH 7/7] bug: Move WARN_ON() "cut here"
>> into exception handler" from the series at
>> https://lkml.org/lkml/2019/8/19/1155
>>
>>
>>>
>>>> Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler
>>>
>>> It's strange to receive a standalone [7/7] patch.
>>
>> Iaw the Reply_To, I understand it as an update of the 7th patch of the
>> series.
> 
> Was trying to avoid the churn of resending the identical 1-6 patches
> (which are all just refactoring to make 7/7 not a mess).

Yes but Reply-To: means the address we have to use to answer to this email.

I think you wanted to use In-reply-to:

> 
> I can resend the whole series, if that's preferred.

I guess not.

> 
>>>> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
>>>
>>> I'm seeing double.
> 
> Tracking down all these combinations has been tricky, which is why I did
> the patch 1-6 refactoring: it makes the call hierarchy much easier to
> examine (IMO).

But still, Andrew is seing double ... And me as well :)

Fixes: Fixes:

Christophe

> 
> -Kees
> 
