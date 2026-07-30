Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4D3909A7
	for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398769; cv=none; b=K9qWADp08fVcQ5w6OfqXoGxwTtpakvta/E2anTv8dc4rHC5CyuzdJc5HTBEhQfmNuDLmjspHBIuEBddTdj06syrV7YP/eaap9vMTiZ4iJ9E3BKB46juF0BeHkfLYke/q2NLcVzZGTWu4ZqFqNwOm+mOgMWGfErJ8WhoO3ug+4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398769; c=relaxed/simple;
	bh=jjo+0yszJ5w9VEUwr/pMoYpXZsOeZIUHZ2vnwnaDg9A=;
	h=To:Message-Id:Cc:From:References:Subject:Mime-Version:In-Reply-To:
	 Date:Content-Type; b=LzEYZNo7JVeLacfjLvVEmdYn3cxAI2STjyZYqqoUjCwRRc7Ihq2G74NB3o1hspcj/MDZnbX3Pz/w041NUYFLUVYu2D2pDNEsR5GsQmMjL02jycSKN2/C80TPKe8i2FF/lEWKSEZTbfEsKxx/BSDL9iQmjJB1D/ZSDI9ZZX67deU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BBOvar99; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BBOvar99"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785398761; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=KujgVCTc1rWCSsOVBTNJAgS0MTdCaoJqux8n84RW75U=;
 b=BBOvar99bWM/TOnChHrUllELNTpzyunIYp5rLVlYhzJXmPK56vsnKfGDiurZesy/ouPYj/
 5vbJkQXEinHwp42UfeWyr8EDrUHI5Gl3PhvPLZIkNCsI+u5wcuyhPth+GfNWriAM/PFJ1W
 WCLQQapXLVlDzc5jH4QqeAoI12xh/ZF0IZql8oKx078Z/kV5NYGZIg7Paf5CZSFk+ECz4q
 J9TkMQCxDMVOpH3FBZrBGkmP7Dv0EUD7q8twYMXA4BnRpkSWTi3QONpghHCS2KubVplhBy
 Z22T2bDpTyi6nRk2yuCGhEGkUIim+KJxfSmmhr/RsIWns7icqR8VZp0Rk6qUKQ==
To: "Borislav Petkov" <bp@alien8.de>
Message-Id: <0126ccfc-fe8f-4dc6-87e0-fc9ba5d116b2@bytedance.com>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260727123429.5673-1-lizhe.67@bytedance.com> <20260727123429.5673-8-lizhe.67@bytedance.com> <20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a6b05e7+c626c1+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jul 2026 16:05:36 +0800
Content-Type: text/plain; charset=UTF-8

On 7/30/26 7:48 AM, Borislav Petkov wrote:
> On Mon, Jul 27, 2026 at 08:34:27PM +0800, Li Zhe wrote:
>> The new x86 memcpy_nontemporal() helper in this series maps to
> s/in this series//
>
> That's implicit.
>
>> memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
>> for constant-sized struct page template copies.
>>
>> The immediately relevant x86_64 sizeof(struct page) values here are 64,
>> 80, and 96 bytes. memcpy_flushcache() currently inlines only the 4, 8,
>> and 16-byte cases, so even those constant-sized struct page copies fall
>> through to __memcpy_flushcache().
>>
>> Add 32, 48, 64, 80, and 96-byte MOVNTI sequences to the main fixed-size
>> switch so those constant-sized copies can stay on the inline path.
>> Factor the larger sequences into movnti_8()/16()/32()/64() helpers so
>> the switch can reuse them without duplicating the inline assembly.
>> While the ZONE_DEVICE template-copy path only needs 64/80/96-byte
>> copies, keep 32-byte and 48-byte copies inline as well rather than
>> sending those nearby fixed-size cases back to __memcpy_flushcache().
> Do not explain the code - explain *why* those sizes. I already asked a bunch
> of times.
>
>> These new fixed-size cases follow the existing memcpy_flushcache()
>> fixed-size MOVNTI cases. The existing 4/8/16-byte cases already use
>> MOVNTI without a separate destination alignment check.
>>
>> The movnti_8()/16()/32()/64() helpers keep the "memory" clobber
>> intentionally. The destination memory operand describes the MOVNTI
>> destination, but it does not express the broader compiler-scheduling
>> constraint that this path wants: keep the fixed-size copy as a compact
>> sequence of streaming stores and avoid moving unrelated memory accesses
>> into the middle of that sequence.
> A lot of bla for its own sake.
>
>> A microbenchmark compared two memcpy_flushcache()-style helpers that
>> shared the same generic body and differed only in whether
>> 32/48/64/80/96-byte copies stayed in the fixed-size switch or were
>> redirected to __memcpy_flushcache() when the destination was not 8-byte
>> aligned. The timed interval covered the copy loop only; wmb() was used
>> only to separate rounds.
> So we're doing this only for a microbenchmark's sake?
>
>> In pseudo-code, the two variants were:
>>
>> variant A:
>> 	switch (len) {
>> 		case 32:
>> 		case 48:
>> 		case 64:
>> 		case 80:
>> 		case 96:
>> 			do fixed-size MOVNTI stores;
>> 			return;
>> 		default:
>> 			generic __memcpy_flushcache()-style body;
>> 	}
>>
>> variant B:
>> 	switch (len) {
>> 		case 32:
>> 		case 48:
>> 		case 64:
>> 		case 80:
>> 		case 96:
>> 			if (!IS_ALIGNED(dst, 8))
>> 				goto generic_path;
>> 			do fixed-size MOVNTI stores;
>> 			return;
>> 		default:
>> 	generic_path:
>> 			generic __memcpy_flushcache()-style body;
>> 	}
>>
>> For offsets 1..7 averaged, keeping those sizes in the fixed-size
>> switch took about 0.410/0.411/0.426/0.426/0.428 us per
>> 32/48/64/80/96-byte copy, while redirecting the same cases to
>> __memcpy_flushcache() took about 0.962/0.956/0.923/0.998/1.001 us.
>>
>> The correctness rationale for not adding a separate destination
>> alignment check is that these cases follow the existing 4/8/16-byte
>> memcpy_flushcache() MOVNTI cases, and I did not find Intel SDM text
>> requiring an 8-byte aligned destination for MOVNTI.
>>
>> The microbenchmark is only the performance motivation for keeping
>> these small constant-size copies in the inline path.
> So in the end of the commit message, I still don't know why we need this code.
>
> I mean, it should be pretty trivial to explain: I'm adding those additional
> sizes because it brings this and that. Srsly.
>
> If you cannot justify that, why are you even doing it?
>
> So from going over this again, the reason why you're adding those other sizes
> are because struct page can be that big. Yes?
>
> How do you know? What's the proof?
>
> I'd expect a justification along the lines of: in a somewhat normal Linux
> installation, struct size can be of size <bla>. Adding MOVNTI helpers of size
> <bla> brings so and so performance uplift.


Yes, the real motivation is the ZONE_DEVICE struct page template copy.

The second paragraph of the commit message was intended to explain the
main sizes: the immediately relevant x86_64 sizeof(struct page) values
are 64, 80 and 96 bytes. But I agree that the commit message did not
connect those sizes to the real ZONE_DEVICE benefit clearly enough.

This patch was added because I had measured a benefit from keeping those
struct page sized memcpy_flushcache() copies in the fixed-size MOVNTI
path. The current patch order and commit message did not make that clear
enough, because the ZONE_DEVICE memcpy_nontemporal() user came after the
x86 extension.

I will fix that in v9 by reordering the patches so the ZONE_DEVICE
memcpy_nontemporal() user comes first, and then rewriting the x86 commit
message around that caller and the measured benefit. I will also remove
"in this series" and trim the commit message so it focuses on why the
patch is useful rather than explaining the implementation details.

Thanks,
Zhe


>
> How hard it is to write it this way?
>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>>   arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
> ...
>
> at least the code is making a lot more sense now.
>
> The fact that you had to axe off so much cruft off of it tells me that you
> haven't really measured it right.
>
> So why do I really want your patch?
>
> Thx.
