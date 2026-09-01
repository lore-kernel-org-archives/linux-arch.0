Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBC3B05AB
	for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231519; cv=none; b=I0a+Nt8ywANr0+5bbs957QeeD8djwN/sEnFC1hbutZuwBeFXWYu1cE3YmLCQ3Akwb+NP/9tbm4daODAhsdN8FRX8fk8XGjuBrwao7b85eAdtbF8vS1RG4TKcuIHp/2yTyBzj47Wih0s0O5fVty+a466FEHccvFScXCcW6OgL9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231519; c=relaxed/simple;
	bh=l9BpW+9AQa5fio5skrVoXenJrvSLXLe4Yo9TabK2Mr4=;
	h=Date:Message-Id:Content-Type:Subject:References:From:Mime-Version:
	 To:In-Reply-To:Cc; b=bOEmVw/oQEPVPzgZq9rRimKPFlSCdw07gIJaE3MqRaQsQTNIMzhRbThQ14M+LiBmNV/n5oDf5ZrX7LpOwQzKxnVXnWolP3/JYCFLXHesWd6wObjcWehAjmLwYfVboZ4qzP9HWgM4+XawXGognMYEdEylU1xtjmW30fgxjTOMudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LWJSCW5s; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LWJSCW5s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788231512; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IWe25f/V5EyAwZsvk6syK52ldRZujBuH0XXRF2BXP3E=;
 b=LWJSCW5sQhVXmXof4ttwdazcl7KEK/Eh9LBMuGlIJFpZSg8Rdv5Fr45rvGb6ecFYO9p5z6
 QAsH5YuYASuHVF3ow9f7mjbmsprWEPUq6kvlE4LEvuM1dcQBUeL/xAhAWG7aPnykwLHx0v
 AAPb0si1N5TtrX+RW9UXWoIy/JkwY5cYMtzVbNzd+85bwpTNivZfQ+Fkva+l1yxSWqOv2A
 l8dvueIjJqFUZHkT3BxZl4CHDOWRTP8Kh7xSblM2S63eHv6AkBr3xJTR7Q0g/txQR9g/jV
 16SzbYkZxIzn1JCXW2mL5RSMWjsQhGpqRozTHGYAeciVkgb7pyC364oHoKFc+w==
Date: Tue, 1 Sep 2026 10:58:09 +0800
Message-Id: <f7099580-870f-4cdf-84cc-a82cc47a42b0@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a963f56+68a3f2+vger.kernel.org+lizhe.67@bytedance.com>
Subject: Re: [PATCH v11 0/7] mm: optimize zone-device memmap initialization
User-Agent: Mozilla Thunderbird
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260831111638.76012-1-lizhe.67@bytedance.com> <20260831164531.be5a8fa210401830e85eb974@linux-foundation.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <20260831164531.be5a8fa210401830e85eb974@linux-foundation.org>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>

On 9/1/26 7:45 AM, Andrew Morton wrote:
> On Mon, 31 Aug 2026 19:16:31 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
>
>> memmap_init_zone_device() can take a noticeable amount of time when large
>> pmem namespaces are bound or rebound, because it initializes nearly
>> identical struct page descriptors one PFN at a time. This series reduces
>> that ZONE_DEVICE memmap initialization overhead by reusing prepared
>> struct page templates and, on x86, using memcpy_nontemporal() for the
>> template copy path.
>>
>> ...
>>
>> This reduces the average memmap initialization time measured during
>> rebind by about 48.0% for nd_pmem and 41.6% for dax_pmem on that arm64
>> VM setup. Since this arm64 setup does not use the x86 MOVNTI fast paths,
>> the result also suggests that the generic template-copy optimization can
>> benefit architectures without an architecture-specific
>> memcpy_nontemporal() backend.
> Well that's nice.
>
> Sashiko seems to have found some new things to complain about:
> 	https://sashiko.dev/#/patchset/20260831111638.76012-1-lizhe.67@bytedance.com
>
Hi Andrew,

Thanks for taking a look.

For the comment on patch 5 about the cnt == 0 case, I agree that
memcpy_flushcache() should preserve the usual zero-length memcpy
semantics. This is a pre-existing issue in the x86
memcpy_flushcache()/__memcpy_flushcache() implementation, not a bug
introduced by this series. The new ZONE_DEVICE call site added by this
series always copies sizeof(struct page), so it cannot hit the
zero-length case.

Since this is a pre-existing issue and is independent of this patchset,
would you prefer me to send a separate standalone fix for the x86
memcpy_flushcache() zero-length case, rather than folding it into this
series?

For the MOVNTI ordering concern in patch 6, this was discussed in the
previous round. Based on that discussion, I believe the current code is
correct, so I do not plan any additional code changes for these items.

Thanks,
Zhe
