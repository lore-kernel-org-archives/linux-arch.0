Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37234 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJ1v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 05:27:51 -0400
Date: Thu, 11 Jul 2019 19:24:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
References: <20190711030339.20892-1-npiggin@gmail.com>
        <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
In-Reply-To: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
MIME-Version: 1.0
Message-Id: <1562835751.mpbmrr7rdc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org

Christopher Lameter's on July 11, 2019 5:54 pm:
> On Thu, 11 Jul 2019, Nicholas Piggin wrote:
>=20
>> Remove page table allocator "quicklists". These have been around for a
>> long time, but have not got much traction in the last decade and are
>> only used on ia64 and sh architectures.
>=20
> I also think its good to remove this code. Note sure though if IA64
> may still have a need of it. But then its not clear that the IA64 arch is
> still in use. Is it still maintained?

It should still work (as well as other archs). Does it have any
particular need for page table allocation speed compared to others?

I actually think it's more benefit for ia64 and sh than anything.
For other arches it's no big deal, and generic code just sprinkles
some poorly named function around the place with no real way to
know where it should go or test it. Then not to mention its
interaction with other memory queues.

>> Also it might be better to instead make more general improvements to
>> page allocator if this is still so slow.
>=20
> Well yes many have thought so and made attempts to improve the situation
> which generally have failed. But even the fast path of the page allocator
> seems to bloat more and more. The situation is deteriorating instead of
> getting better and as a result lots of subsystems create their own caches
> to avoid the page allocator.

Yeah, to some degree I agree. And if someone would test it on a modern
CPU and workload that would be cool.

But for example in most workloads you would expect the rate of page
allocation and freeing for processes to be on the same order of=20
magnitude at the low end, up to 2 orders of magnitude higher than
page tables that map them. Not true perhaps for very large shared
mmaps, but all in all IMO it's not clear this is a good tradeoff, or
it's a good idea to proliferate these little queues around the place.

Anyway that's just handwaving from me, but I'm not against the code
being resurrected and added to the more important archs if it shows
good gains on something relevant.

Thanks,
Nick
=
