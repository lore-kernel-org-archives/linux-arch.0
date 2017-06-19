From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/5] move everyone over to thin archives
Date: Mon, 19 Jun 2017 15:30:18 +0900
Message-ID: <CAK7LNATZb-=1c9hnHWJCk5oyYcC1z190yHVtTJZLcOZG8MRCjQ@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170617231054.63aeb5ac@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38381 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdFSGa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 02:30:26 -0400
In-Reply-To: <20170617231054.63aeb5ac@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Nicholas,

2017-06-17 22:10 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> On Fri,  9 Jun 2017 15:24:12 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> This has gone through 0day several times now, and I think I've
>> weeded out all the build breakage. Following what Linus asked
>> for, I did not make it a user selectable option. I kept the
>> option there in case we need to do a depend on !ARCH for any
>> reason.
>>
>> Please consider for the kbuild tree.
>
> Any thoughts on this?
>
> Thanks,
> Nick

Sorry for my late reply.

Basically, I think thin-archive is the right direction we should go.
(and I agree thin-archive and DCE can get in separately)

Could you check my comments on each patch?



-- 
Best Regards
Masahiro Yamada
