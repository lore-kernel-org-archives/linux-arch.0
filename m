From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
Date: Tue, 28 Jul 2020 20:37:34 +1000
Message-ID: <1595931748.6mal1nph7g.astroid@bobo.none>
References: <20200728033405.78469-1-npiggin@gmail.com>
        <20200728033405.78469-2-npiggin@gmail.com>
        <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgG1Khl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 06:37:41 -0400
In-Reply-To: <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>

Excerpts from Vineet Gupta's message of July 28, 2020 2:01 pm:
> On 7/27/20 8:33 PM, Nicholas Piggin wrote:
>> Many of these are no-ops on many architectures, so extend mmu_context.h
>> to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h
>>=20
>=20
>> -static inline void switch_mm(struct mm_struct *prev,
>> -			struct mm_struct *next,
>> -			struct task_struct *tsk)
>> +/**
>> + * activate_mm - called after exec switches the current task to a new m=
m, to switch to it
>> + * @prev_mm: previous mm of this task
>> + * @next_mm: new mm
>> + */
>> +#ifndef activate_mm
>> +static inline void activate_mm(struct mm_struct *prev_mm,
>> +			       struct mm_struct *next_mm)
>>  {
>> +	switch_mm(prev_mm, next_mm, current);
>>  }
>> +#endif
>=20
> Is activate_mm() really needed now. It seems most arches have
>    activate_mm(p, n) -> switch_mm(p, n, NULL)
>=20
> And if we are passing current, that can be pushed inside switch_mm()

Thanks for taking a look, I think there may be more consolidation
like this possible, and certainly some of the arch patches could
have gone a bit further.

I wanted to be fairly careful to make only quite trivial changes
(only the obvious no-ops) for the first iteration, but once this
is in the tree it should become a fair bit easier to do some
of your suggestions.

There's a few things that make activate_mm->switch_mm not quite
simple - alpha, nios2, parisc, s390, maybe x86.

Thanks,
Nick
