Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8933D6FA
	for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398317; cv=none; b=pN7/jLlb3pzJ7EHeGU5eVH01royoCZT6mIC3EQReFie6HuxpwcOVv0kqxQ2DhSlMA17QkzZyXMUfmvy9sg0XO1J/vcZmfPJFTA64nWKtOHBgyw8H4Mhwmj3rLjLZEH1nKcizYheE2XcpVGhDkWda04sUQ9OpabScrT2iNtf89Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398317; c=relaxed/simple;
	bh=cbG8gcR8wtZkY4mtBlUylI47qxA2El/K5Irhyt+u8kw=;
	h=Date:Message-Id:Mime-Version:References:In-Reply-To:Cc:Subject:
	 Content-Type:To:From; b=aQd5JfWKmrOMf+EHSZMxL1+W2fb12InnF9Md3UeVM+s9xdJL9NzptIlUGZ3+iZQT3tLdIz4PLO17cfY/hrGXH2Tz9v+67AZvdvdne4Ctrl77HNKlVs2kLY2bAB7byM4mqdNzKn63p0vlwkTlezS09ojhQnEmjPX2fAHBHkBN3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Oo1w2Rsx; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Oo1w2Rsx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785398311; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cbG8gcR8wtZkY4mtBlUylI47qxA2El/K5Irhyt+u8kw=;
 b=Oo1w2Rsx8HCa6/mNJQvUHUb2PqIfpJCEnQ3HUz9D/IUGTqom6dMVwdAYKWtAlQZenEtB8W
 xPdHiyumuwMKKWo4AlcA2NZwkAHaAmAZQ9+SCNNc7B/wqg4bwp7ZgyhJXGz3cy/6x51lnG
 d2qtvew3p/N1QVKbIfimMgxGLbhJUoQfM5aGMEx4fsLauONwvpDJCzsG+ETTSdXEjdONRi
 dC2ixE3pPvHVKIokACtTgonXXDKTDF7Fx6yz/89LYx/mjmZiAu9AH7ovTQ3slCGB+K4Crv
 BYqThQIJNTbxB6FwP+Ad3n9EWFGu1Bob/0bWS/GcS0FIXtlhOD79HotN29M8ow==
Date: Thu, 30 Jul 2026 15:58:06 +0800
Message-Id: <0537aca9-3474-4382-ba39-40137773398b@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a6b0425+d704d9+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com> <20260720120259.1545-11-lizhe.67@bytedance.com> <178525732063.1556190.16834028754418994747.b4-review@b4>
Content-Transfer-Encoding: 7bit
In-Reply-To: <178525732063.1556190.16834028754418994747.b4-review@b4>
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <muchun.song@linux.dev>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v7 9/9] mm: always use the zone-device template init path
Content-Type: text/plain; charset=UTF-8
To: "Mike Rapoport" <rppt@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>

On 7/29/26 12:48 AM, Mike Rapoport wrote:
>> The template path still has a local opt-out predicate for the
>> page_ref_set tracepoint and keeps a non-template fallback path. This
>> makes the code more complex without a strong reason to keep the
>> separate path.
>>
>> Use the template path unconditionally after the corresponding seed page
>> has been initialized: the first head page seeds the head template, and
>> the first tail page in each compound range seeds the tail template.
>>
>> This keeps the first-page seeding logic unchanged, but removes the extra
>> non-template fallback from the main loops.
>>
>> This also means sanitized builds no longer force this path back to the
>> per-page initialization stores, and an enabled page_ref_set tracepoint
>> will no longer observe every ZONE_DEVICE initialization-time refcount
>> assignment. That tradeoff is intentional: this code is still initializing
>> struct pages before they are handed out, and keeping those local debug
>> special cases would preserve a separate initialization-only path while
>> making the common code more complex.
> Just fold this change into the relevant patches and don't introduce the
> opt-out at the first place.
Thanks. I will fold this into the relevant patches in v9.

Thanks,
Zhe

