Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E735F185
	for <linux-arch@vger.kernel.org>; Wed, 13 May 2026 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638332; cv=none; b=jAO/Bi/wDsvw5AijpYWpTXIB78QNpKCPfwqfC9cpcOiWqGTzOydEfitV/CfLl/AHcL0oVMpT5gY26rta2EnnWiOAT1guY7qkfGTn3GYsn8MfuU8p+ac+h6eTq+sGZe1t9biKkQBF9ZzxaNviIIlFQFkdsvPb9wrhuuZZBAPXAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638332; c=relaxed/simple;
	bh=cdjJWSLheRQ+3GuD9xg1u/bkib2oHeCrXtM/HsiT9hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYC6E4xwq3yET6iRgz3ysRcXUfcxtH2vL5a1rW5TyMTtTYjjFonXJScXI712LZgUzM5zThlCHFDYYp4KnBLZmerhRJzOBmgFhn1+MuyZZ/SwOf0AN9z1ft1UiRtUaMi1fAOJIUXacNOgvYQsH0t2E+TEdrmI3V7qznoFGxnD49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FvqK/RE1; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FvqK/RE1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778638329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdjJWSLheRQ+3GuD9xg1u/bkib2oHeCrXtM/HsiT9hA=;
	b=FvqK/RE1HsPP0f+Olp2dZTiI5rOPjZzpmfjMhV4TCxIgrlljmH7uX3cIBO75/yLdaj1TkK
	fwZTR2ctao8DGHXSY/4uBJ9orQKkWJgVytD8f91uGBoXacu3/XNJWE62Bp8Gsz7UYuybaH
	03SZrVpWg5okbuI8VjHVv+E+iz1cRzs=
From: Lance Yang <lance.yang@linux.dev>
To: shy828301@gmail.com,
	jannh@google.com
Cc: lance.yang@linux.dev,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	ardb@kernel.org,
	sethjenkins@google.com
Subject: Re: [PATCH] mm: make zeropage read-only
Date: Wed, 13 May 2026 10:11:48 +0800
Message-Id: <20260513021148.17588-1-lance.yang@linux.dev>
In-Reply-To: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
References: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, May 12, 2026 at 10:14:01AM -0700, Yang Shi wrote:
>On Tue, May 12, 2026 at 6:48 AM Jann Horn <jannh@google.com> wrote:
>>
>> On Tue, May 12, 2026 at 4:31 AM Lance Yang <lance.yang@linux.dev> wrote:
>> > Would it makes sense to apply a similar treatment to huge_zero_folio
>> > as well?
>> >
>> > with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y, it is allocated at boot and
>> > never freed, so it should never be written after initialization either :)
>>
>> Oh, neat, I didn't realize that that feature exists.
>>
>> I guess there are two aspects of making the huge zero folio RO that
>> could be problematic:
>>
>> 1. If the huge zero folio comes from the page allocator, making it
>> read-only might require splitting a huge PUD, which could have
>> performance implications.
>> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
>> linear mapping can't be split at runtime at all depending on hardware
>> capabilities, meaning the entire linear mapping may need to be mapped
>> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
>> early enough to be excepted from that. See can_set_direct_map() and
>> force_pte_mapping() in arch/arm64/.
>
>Yes. First of all, this relies rodata mode. If rodata=on (used to be
>called full), the linear mapping may be mapped by PUD/PMD if the
>hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
>level all the time. But how huge zero folio is mapped in linear
>mapping should not matter, you just need to change the linear mapping
>permission to RO anyway.
>
>If the rodata mode is off or noalias (used to be called on), the
>linear mapping may be mapped by PUD/PMD, but basically changing linear
>mapping permission is not expected by kernel.

Ah, right. So for huge_zero_folio the hard part is not just making the
backing memory read-only, but also whether we can change the linear
mapping permission for that range. That depends on the arm64 rodata mode
/ direct-map setup.

Thanks Jann and Yang for the explanations!
Lance

>Thanks,
>Yang
>
>>
>> So making the huge zero folio RO in the linear map would probably
>> require adding a new config flag, connecting that to
>> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
>> memory management.
>>
>
