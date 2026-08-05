Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F513DA7CA
	for <linux-arch@vger.kernel.org>; Wed,  5 Aug 2026 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923477; cv=none; b=ophCB5XlNj+W+hQg5IGbz2EAwkinXMLcWRzRpQX6xvUxs116vAWRnwduO3d2qz0Ue53JXuD26AYpGD6P8h4t01CEV98/GfmwQfOF6VhIEPbsgTYPk8v+JmSdzeMATvjCmMh2aGvaPJ2h2H9XHsueZziKrHX6dCHpGuwub4bbC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923477; c=relaxed/simple;
	bh=/7rmQh5UIMjXl3eSec6+iVglbfzC2mjq8hJqDq0PiJA=;
	h=References:Cc:Subject:Date:Message-Id:Content-Type:In-Reply-To:To:
	 From:Mime-Version; b=n4cHc2C6xSubhh/koS3XS9kXyIIZCnIlZGB2joUdNnFVWFIVH/8k/Hs2/3GWGlZrYLd6yuwqv5/M6HkGVK4vkcMqOlpFRd7Lz3v845Pr4k4hLPxm5NsQxGbGorjXEYBY46I10JZohdkFiU6eXsIhPaOssWY4HI9GKmYaQrlOIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jH/beg/h; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jH/beg/h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785923470; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kAxC4YTMr3xtaFtujHMyZqm2zshOuBu29sIloAfmWcI=;
 b=jH/beg/ha4wPgDRvR+8MrMPV8+6y5zsz6MNSTDJGN1sdn2U6FT6H6+3DQta+MYmDeZzvQ1
 2WaRdAD+dPbO53TKaC38zBGIb98JvC8qFy2OcwJNv7SaFvjy31l7c8HhY9D5eEGLLXIMOy
 B7AW8gwCKl06VZ4PO68na5uVQ3r4yaqCwivkB7Wf3omgg5QAi/rghyAYoZU10rN1cBAHyU
 wlHIS8ffrnpu/9pT8sHmgPdFY8IwgbJsPc6bjKS149Rm4OlOOOgw1+fSkvj19Nm340+Q0k
 vTd9dDprqPCezT7Pb7RU53L9eYHz8I/Az+e5rNcifyNjNhqHQGs707hs/Dg5GA==
References: <20260803070929.86075-1-lizhe.67@bytedance.com> <20260803070929.86075-5-lizhe.67@bytedance.com> <CB22DBB6-0B52-46C2-9A19-4A18A6F6DEC1@linux.dev>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v9 4/8] mm: add a template-based fast path for zone-device page init
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Wed, 5 Aug 2026 17:50:47 +0800
Message-Id: <93090eff-7961-47f8-9373-787f6a0f8da4@bytedance.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CB22DBB6-0B52-46C2-9A19-4A18A6F6DEC1@linux.dev>
Content-Transfer-Encoding: 7bit
To: "Muchun Song" <muchun.song@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a73078c+0b6239+vger.kernel.org+lizhe.67@bytedance.com>

On 8/3/26 4:39 PM, Muchun Song wrote:
>
>> On Aug 3, 2026, at 15:09, Li Zhe <lizhe.67@bytedance.com> wrote:
>>
>> memmap_init_zone_device() repeats nearly identical head-page
>> initialization for each PFN. Prepare one reusable ZONE_DEVICE head-page
>> template through the existing slow path, refresh the PFN-dependent
>> fields in that template before each copy, and memcpy it into each
>> destination page.
>>
>> Use the template path unconditionally, as suggested by Muchun. The
>> page_ref_set tracepoint is primarily a debugging aid, while this code is
>> still initializing struct pages before they are handed out. From the
>> perspective of users of those pages, the initialization-time refcount
>> transitions are not part of the observable page lifetime.
>>
>> This means page_ref_set will no longer observe every initialization-time
>> refcount assignment for copied ZONE_DEVICE head pages. The impact is
>> controlled because the final initialized struct page state is unchanged,
>> and keeping a separate non-template path only for this local tracepoint
>> observability would add complexity to the common path.
>>
>> This patch accelerates head-page initialization. The pfns_per_compound
>> == 1 case gets the full benefit here, compound tails are handled in the
>> next patch.
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev on Intel Ice Lake server. This test exercises the nd_pmem rebind
>> path (pfns_per_compound == 1).
>>
>> Test procedure:
>> Rebind the nd_pmem driver 30 times and collect the memmap initialization
>> time from the pr_debug() output of memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>>   Average of rebinds for nd_pmem driver: 244.28 ms
>>
>> With this patch and its prerequisites applied:
>>   Average of rebinds for nd_pmem driver: 215.55 ms
>>
>> This reduces the average memmap initialization time measured during rebind
>> from 244.28 ms to 215.55 ms, or about 11%.
>>
>> Suggested-by: Muchun Song <muchun.song@linux.dev>
> I personally feel you might have used the wrong trailer here, because it
> implies that the overall design is based on someone's suggestion. But for me,
> I think what you actually meant is that in a previous version, I made a
> suggestion about simplifying the code, rather than dictating the overall
> direction of this entire patch series. So I feel I shouldn't be credited here.
> This information is already enough just appearing in the change log.
>
> Muchun,
> Thanks.


Thanks.

I will drop it and keep the simplification note only in the changelog.

Thanks,
Zhe

