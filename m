Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB623F661D
	for <linux-arch@vger.kernel.org>; Wed,  5 Aug 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923395; cv=none; b=mslD/FSUurMjO4ct2LflddtoCfXFscg9PVz4poxwaH5WJnMkOQwIXTINIUck7bQp7VRHa7dkTN+SjXXZbg5PCgoVPpwfd9SdKErUPOFE3MbZE8kJ8Byx9eg54XQ48F/s2SDXBFBqAZUAXWotmpXdSwU3tVzdl+UmsKYoDbMbTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923395; c=relaxed/simple;
	bh=kdm9JLDkzfeR7QzsuL8awd/xo9HMEeVRB2f+mQA1wKM=;
	h=Message-Id:Content-Type:References:To:Cc:From:Subject:
	 Mime-Version:In-Reply-To:Date; b=dI+yebi5LOuU9a76EuPJgCL8JbvDnKUgh+W/CUBDK7x3MW7e8wvyvnNmTZEEp22qCA0mBWfOSK3FMAflDwQ+1k2tITamD6szCNxC8+Gmw42nvOusGQ9tKrO4VM6ErNul+oJcG2iM1Q6v4NojgHhUnKpHqqr2XdeAz1+BWgxhMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SapNL7JM; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SapNL7JM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785923386; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Y/uAgkm9aok/nQAEqWTWVKcO/AScdnJJ1CYyygt77ao=;
 b=SapNL7JMPb1FOlhJ98JpcCYff/SGexhYFrVyyr9IdxPtMp08AiOuSpbIoobO1bCjcix+l4
 x0x3gG5Nxlu5wL8jV9lPCk8DGnak+l4AGLb4M13ka3lfnX1Z737gr9lbPvbsPNxTXn+lEp
 +mV3eUrEw7j1OBQ3STL558KJMn2VB1D8DQcAMexAsfL+OKEKh3kaiYcSvl20Ra52zMKwCq
 tdfIX3z4DUqQlxVyq3SKqCbPduETEWvNn4LzXJGoWhC4MWNbde/ZYRC2AkqiIwzrNY0UiC
 AKnpsZQhj5jmhhoukLV6iZMPAhkZX3Xu/CwlT7w944+dyxQeJuRJFI7cp7FEUA==
Message-Id: <7ce88e5a-8b96-4508-91b1-b72a589e6ac4@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260803070929.86075-1-lizhe.67@bytedance.com> <20260803144014.e2d4ebb83e9471b695f6290d@linux-foundation.org>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v9 0/8] mm: optimize zone-device memmap initialization
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a730738+175c56+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260803144014.e2d4ebb83e9471b695f6290d@linux-foundation.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Wed, 5 Aug 2026 17:49:22 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit

On 8/4/26 5:40 AM, Andrew Morton wrote:
> On Mon,  3 Aug 2026 15:09:21 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
>
>> Test procedure:
>> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
>> initialization time from the pr_debug() output of
>> memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>>    Average of nd_pmem rebinds: 244.28 ms
>>    Average of dax_pmem rebinds: 273.31 ms
>>
>> With this series applied:
>>    Average of nd_pmem rebinds: 96.79 ms
>>    Average of dax_pmem rebinds: 119.04 ms
>>
>> This reduces the average memmap initialization time measured during
>> rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.
> Well that's nice.
>
> Review is partial and it's late in the cycle so I'd prefer to schedule
> this for the next -rc cycle.
>
> AI review might have found a couple of things, please check?
> 	https://sashiko.dev/#/patchset/20260803070929.86075-1-lizhe.67@bytedance.com


Thanks.

I checked the Sashiko comments. The reported items are the same points
that were discussed in the previous v7/v8 reviews. v9 already folds the
related explanation into patch 7, so I do not plan any additional code
change for these items.

Thanks,
Zhe
