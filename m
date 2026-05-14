Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747921771B
	for <linux-arch@vger.kernel.org>; Thu, 14 May 2026 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725019; cv=none; b=VUhEMhFeCpQFpGr0aYQciZw/AFH6v1YgFYE0nHDM7+E1KpZpSKTGojFRUS/gz1VkAUkjGXX9S1edsCqz4wnY8l3R9LcI9whdj66Udrc4JeNoI+ONbvuvjp9mI1q4pwhQEQCDylrvaz6fy63HtCskOYk32Qfvd62q7h08ZIvzpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725019; c=relaxed/simple;
	bh=+/EqXFH8UBug4+vHiukxscxva32NTqpB0Kx21ItGbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzAMGI9bKY+FssbNuLv5T2n0VHmWz9GuUfMosQk44asCJuGIHk7ZuFmNCeKgrjU6xqlgOULgZAClsDHu0ZIverGDo//nvedlH8gnOyRZTJqdvHerGbLO7rr6Fjm0XkaTjAt4hOdkpoPJ+JfVDw0+5OShsk+6TlTUmSITmPWyHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NiSJMa8A; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NiSJMa8A"
Message-ID: <5478f96d-277c-46c3-b437-1660706fd784@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778725006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfUkHUvFvN9MUTYLegQqMkS5z5gU7HMTPPWfFS0sDNs=;
	b=NiSJMa8AZj6pYNg9iccdQZ5+vV7Wlf4xHw5EyItlN4Uzap+ockOpYSTg+rB5FQHFwKLE9q
	37R8dEt5EQ20J8HrNgu4yVkzNtBvhOyEDYo7mqvXwh6ZTBJIzHPruVplA/f5Z1wtC8L2J1
	PwbFzmSX20hM2/kLwuIJAb3c0sVQDBQ=
Date: Thu, 14 May 2026 10:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: make zeropage read-only
To: Yang Shi <shy828301@gmail.com>
Cc: jannh@google.com, rppt@kernel.org, akpm@linux-foundation.org,
 arnd@arndb.de, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 ardb@kernel.org, sethjenkins@google.com
References: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
 <20260513021148.17588-1-lance.yang@linux.dev>
 <CAHbLzkpBB2ia4pUG1khZy1w5G_sq6DD+9OnqjrJ6Yu0KxPAe=A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <CAHbLzkpBB2ia4pUG1khZy1w5G_sq6DD+9OnqjrJ6Yu0KxPAe=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/5/14 07:10, Yang Shi wrote:
> On Tue, May 12, 2026 at 7:12 PM Lance Yang <lance.yang@linux.dev> wrote:
>>
>>
>> On Tue, May 12, 2026 at 10:14:01AM -0700, Yang Shi wrote:
>>> On Tue, May 12, 2026 at 6:48 AM Jann Horn <jannh@google.com> wrote:
>>>>
>>>> On Tue, May 12, 2026 at 4:31 AM Lance Yang <lance.yang@linux.dev> wrote:
>>>>> Would it makes sense to apply a similar treatment to huge_zero_folio
>>>>> as well?
>>>>>
>>>>> with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y, it is allocated at boot and
>>>>> never freed, so it should never be written after initialization either :)
>>>>
>>>> Oh, neat, I didn't realize that that feature exists.
>>>>
>>>> I guess there are two aspects of making the huge zero folio RO that
>>>> could be problematic:
>>>>
>>>> 1. If the huge zero folio comes from the page allocator, making it
>>>> read-only might require splitting a huge PUD, which could have
>>>> performance implications.
>>>> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
>>>> linear mapping can't be split at runtime at all depending on hardware
>>>> capabilities, meaning the entire linear mapping may need to be mapped
>>>> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
>>>> early enough to be excepted from that. See can_set_direct_map() and
>>>> force_pte_mapping() in arch/arm64/.
>>>
>>> Yes. First of all, this relies rodata mode. If rodata=on (used to be
>>> called full), the linear mapping may be mapped by PUD/PMD if the
>>> hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
>>> level all the time. But how huge zero folio is mapped in linear
>>> mapping should not matter, you just need to change the linear mapping
>>> permission to RO anyway.
>>>
>>> If the rodata mode is off or noalias (used to be called on), the
>>> linear mapping may be mapped by PUD/PMD, but basically changing linear
>>> mapping permission is not expected by kernel.
>>
>> Ah, right. So for huge_zero_folio the hard part is not just making the
>> backing memory read-only, but also whether we can change the linear
>> mapping permission for that range. That depends on the arm64 rodata mode
>> / direct-map setup.
> 
> An alternative is you can allocate huge zero folio in the early stage
> of boot before linear mapping is set up. Then when setting up linear
> mapping, you can just make that PMD RO. It should work regardless of
> rodata mode.

Cool. Good call. That would avoid changing the linear map permissions at
runtime.

Thanks for pointing that out! I'll take a look when I get a chance :)

Cheers, Lance

> Thanks,
> Yang
> 
>>
>> Thanks Jann and Yang for the explanations!
>> Lance
>>
>>> Thanks,
>>> Yang
>>>
>>>>
>>>> So making the huge zero folio RO in the linear map would probably
>>>> require adding a new config flag, connecting that to
>>>> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
>>>> memory management.
>>>>
>>>

