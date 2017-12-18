Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41305 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934236AbdLRUTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 15:19:23 -0500
Received: by mail-ua0-f193.google.com with SMTP id q13so11497222uaq.8
        for <linux-arch@vger.kernel.org>; Mon, 18 Dec 2017 12:19:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c7c7a30e-a122-1bbf-88a2-3349d755c62d@gmail.com>
References: <20171213092550.2774-1-mhocko@kernel.org> <20171213093110.3550-1-mhocko@kernel.org>
 <20171213093110.3550-2-mhocko@kernel.org> <20171213125540.GA18897@amd>
 <20171213130458.GI25185@dhcp22.suse.cz> <20171213130900.GA19932@amd>
 <20171213131640.GJ25185@dhcp22.suse.cz> <20171213132105.GA20517@amd>
 <20171213144050.GG11493@rei> <CAGXu5jLqE6cUxk-Girx6PG7upEzz8jmu1OH_3LVC26iJc2vTxQ@mail.gmail.com>
 <c7c7a30e-a122-1bbf-88a2-3349d755c62d@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 18 Dec 2017 12:19:21 -0800
Message-ID: <CAGXu5jJ289R9koVoHmxcvUWr6XHSZR2p0qq3WtpNyN-iNSvrNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmap.2: MAP_FIXED updated documentation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Cyril Hrubis <chrubis@suse.cz>, Pavel Machek <pavel@ucw.cz>, Michal Hocko <mhocko@kernel.org>, Linux API <linux-api@vger.kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
Message-ID: <20171218201921.jDre_ZukMaGTRk397WRbu9mKBf4HVU5XA9_BAdOMU9w@z>

On Mon, Dec 18, 2017 at 11:12 AM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Hello Kees,
>
> I'm late to the party, and only just caught up with the fuss :-).

No worries!

> On 12/14/2017 12:19 AM, Kees Cook wrote:
>> On Wed, Dec 13, 2017 at 6:40 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>>> Hi!
>>>> You selected stupid name for a flag. Everyone and their dog agrees
>>>> with that. There's even consensus on better name (and everyone agrees
>>>> it is better than .._SAFE). Of course, we could have debate if it is
>>>> NOREPLACE or NOREMOVE or ... and that would be bikeshed. This was just
>>>> poor naming on your part.
>>>
>>> Well while everybody agrees that the name is so bad that basically
>>> anything else would be better, there does not seem to be consensus on
>>> which one to pick. I do understand that this frustrating and fruitless.
>>
>> Based on the earlier threads where I tried to end the bikeshedding, it
>> seemed like MAP_FIXED_NOREPLACE was the least bad option.
>>
>>> So what do we do now, roll a dice to choose new name?
>>>
>>> Or do we ask BFDL[1] to choose the name?
>>
>> I'd like to hear feedback from Michael Kerrisk, as he's had to deal
>> with these kinds of choices in the past. I'm fine to ask Linus too. I
>> just want to get past the name since the feature is quite valuable.
>>
>> And if Michal doesn't want to touch this patch any more, I'm happy to
>> do the search/replace/resend. :P
>
> Something with the prefix MAP_FIXED_ seems to me obviously desirable,
> both to suggest that the function is similar, and also for easy
> grepping of the source code to look for instances of both.
> MAP_FIXED_SAFE didn't really bother me as a name, but
> MAP_FIXED_NOREPLACE (or MAP_FIXED_NOCLOBBER) seem slightly more
> descriptive of what the flag actually does, so a little better.

Great, thanks!

Andrew, can you s/MAP_FIXED_SAFE/MAP_FIXED_NOREPLACE/g in the series?

-Kees

-- 
Kees Cook
Pixel Security
