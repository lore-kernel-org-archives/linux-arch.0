From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Tue, 14 Apr 2020 22:13:44 +1000
Message-ID: <1586864403.0qfilei2ft.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200414072316.GA5503@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDNMPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 08:15:19 -0400
In-Reply-To: <20200414072316.GA5503@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org

Excerpts from Christoph Hellwig's message of April 14, 2020 5:23 pm:
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappi=
ngs,
>> have vmalloc attempt to allocate PMD-sized pages first, before falling b=
ack
>> to small pages. Allocations which use something other than PAGE_KERNEL
>> protections are not permitted to use huge pages yet, not all callers exp=
ect
>> this (e.g., module allocations vs strict module rwx).
>>=20
>> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), fr=
om
>> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
>>=20
>> This can result in more internal fragmentation and memory overhead for a
>> given allocation. It can also cause greater NUMA unbalance on hashdist
>> allocations.
>>=20
>> There may be other callers that expect small pages under vmalloc but use
>> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
>> alternative would be a new function or flag which enables large mappings=
,
>> and use that in callers.
>=20
> Why do we even use vmalloc in this case rather than just doing a huge
> page allocation?

Which case? Usually the answer would be because you don't want to use
contiguous physical memory and/or you don't want to use the linear=20
mapping.

> What callers are you intersted in?

The dentry and inode caches for this test, obviously.

Lots of other things could possibly benefit though, other system=20
hashes like networking, but lot of other vmalloc callers that might
benefit right away, some others could use some work to batch up
allocation sizes to benefit.

Thanks,
Nick
