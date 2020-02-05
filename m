From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Date: Wed, 5 Feb 2020 12:29:40 +0000
Message-ID: <a5b6cdbb-2eef-9e84-4ae0-13aad9d1466a@kot-begemot.co.uk>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]:58010 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBEM3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:29:50 -0500
In-Reply-To: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <tavi.purdila@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Will Deacon <will@kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On 05/02/2020 12:24, Octavian Purdila wrote:
> On Wed, Feb 5, 2020 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
>>> From: Octavian Purdila <tavi.purdila@gmail.com>
>>>
>>> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
>>> are not compiled due to type conflict of atomic64_t defined in
>>> linux/type.h.
>>>
>>> This commit fixes the issue and allow using generic atomic64 ops.
>>>
>>> Currently, LKL is only the user which defines GENERIC_ATOMIC64
>>> (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
>>> issues before this commit.
>>
>> Uhhhhh, no.
>>
>> Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.
>>
>> Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.
>>
>> Please explain more.
>>
> 
> Hi Peter,
> 
> I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
> understand your point that a 64 bit architecture that can't handle 64
> bit atomic operation is broken.
> 
> One way to deal with this in LKL would be to use GCC atomic builtins
> or if that doesn't work expose them as host operations. This would
> keep LKL as a meta-arch that can run on multiple physical
> architectures. I'll give it a try.
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


You can lift a set of defines which do that for most compilers/arches 
out of OVS code.

Have a look at lib/ovs-atomic*.h

It should do exactly what you want (+/- cutting it down to things you need).

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
