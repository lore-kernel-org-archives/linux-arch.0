Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7E2CCC5
	for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2026 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692857; cv=none; b=DiW+EpDbh2Abh8n3UMpJeAlcQ/ZCUq/t5MtpB+FT5t9U9SyOeB0XFUBu4ipPXEFz21OvWi72e1lnUEqeCX7BJ8vTIhIY7kDFJdZ4baZmxUY14WAbd5m5Cqgj6LLP4nj5LWHCoM26Y3Q9Q2+hbUeK/0m0+lBXeoiH14wuWHizbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692857; c=relaxed/simple;
	bh=noynmVdv6GOWzBzQEODBsTTH5zKK0O/aYXI/N+MayE4=;
	h=Mime-Version:Cc:References:To:Subject:Content-Type:From:Date:
	 Message-Id:In-Reply-To; b=iVcJiTgEZtK0ue/kBfgEqOvYBCCr5f8kpiArY8/rpdMQMIjUUfxh7NhtBB372PaTuaJHTahdRJzbTtlmf9lPPThptakybBgevLUmsuizRQEyw/5rFWbfPaZ0iX7LWRDNImqoRLZ5E+tqCRYIN4lh279tRgkiwcLRkPJezOKpyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=q66hMoEW; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="q66hMoEW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784692843; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=noynmVdv6GOWzBzQEODBsTTH5zKK0O/aYXI/N+MayE4=;
 b=q66hMoEWLHr21wHkDhf956gafpoc6kvCmdYLKPhsLYtPDLHgxw5NVIc58fUastAUG+w6wZ
 m/QHj496nYEUd641ftBov0DKne22M0CY2ReIz9TrZanvLfnJJI1SA2c4RnDBMvgiOOpJJb
 iQDLDGfSKZcMA4326AtMLiKr2x8kNgfEyCwaaZdMpmVSZxx4ofri1Mz/BKhxkDuEmwmCBj
 qUSkx+O2m01my0VgK+SKowsxrULyslOIOQ4mb16dkQff5/41qKSK1vu13sJQTkxP0M98vP
 M/rL3djkPfPshZ53ZQQd393oBW47TdmYP7AtWf8vJqBqdKXYfW0G0Iqc+ylwZA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>
User-Agent: Mozilla Thunderbird
References: <20260720120259.1545-1-lizhe.67@bytedance.com> <33fae97d-75db-4df7-9aa3-05a51f8747cd@intel.com>
To: "Dave Hansen" <dave.hansen@intel.com>, <akpm@linux-foundation.org>, 
	<apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <muchun.song@linux.dev>
Subject: Re: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed, 22 Jul 2026 12:00:19 +0800
Message-Id: <5284ba93-13c2-4727-9693-fa192d6c1cda@bytedance.com>
In-Reply-To: <33fae97d-75db-4df7-9aa3-05a51f8747cd@intel.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a604069+354dd3+vger.kernel.org+lizhe.67@bytedance.com>

On 7/20/26 9:05 PM, Dave Hansen wrote:
> On 7/20/26 05:02, Li Zhe wrote:
>> This reduces the average memmap initialization time measured during
>> rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.
> There are lots of things in the kernel we could optimize.
>
> Why is this important?
This is in the synchronous probe/bind path for large DAX/PMEM
ZONE_DEVICE mappings. Userspace operations such as enabling or
reconfiguring nd_pmem/dax_pmem namespaces, or bringing a hot-added PMEM
device online, will benefit from the lower synchronous initialization
latency.

The numbers in the cover letter are only for memmap_init_zone_device(),
not for the full driver bind operation. But that time is still a
blocking part of the user-visible operation. On the 100 GB setup it is
already a few hundred milliseconds per bind/rebind, and the cost grows
with the amount of ZONE_DEVICE memmap initialized. With larger devices,
or several namespaces being brought online, that becomes visible
provisioning and recovery latency.

So the benefit is lower latency for provisioning, hot-add, and recovery
or rebind of large DAX/PMEM devices.

Thanks,
Zhe
