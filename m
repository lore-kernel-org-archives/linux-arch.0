Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F13B895B
	for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2026 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219557; cv=none; b=IpB+SE6VlngjG4G3d27aQ0wmB/elmJuozDmmvq6bCfET3Qgu/YyJ1ttENGrOZzBBUVN0FDc1N5BKNKtyML2oLX4Z9R4NyZJz2ISRGYWFFpskANrZWLdV1d23kZf/79Ji5rjtE0iWWok9Rl2Dka+JR/wZczOiVVjLQAO+iw2hMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219557; c=relaxed/simple;
	bh=caf89WdQlAn88Zw6W4rdTABsOclOO1+8aovrt0TU80k=;
	h=Message-Id:In-Reply-To:Subject:Mime-Version:Cc:From:References:
	 Content-Type:To:Date; b=Dj0U6eMAVAffdJglaO7cT1akCWu1tMf6KPEkIoyGxFl7r00vKiEYEm1MpfMKweTv+0H275XiJt7Rn53KczQRwB/P3K3eWUhkBj7fcK1bPWr6/Cx2KX/sAccOo9uBiEFqxkiHcyehSArF8LC5SdYOpAvKPwlwxqVwnZUgYexzRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lGjcRvGe; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lGjcRvGe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785219548; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uMSlAg4H80uRnLlzygyMggmh5xo1htbT7Gs4J7Mu4X0=;
 b=lGjcRvGeA4xjfWVtvy04vgeocGnG/m+Sng3Tr5trR4aV+URFh9SFcJc7/cJZGPWdXqs2S4
 1HTUiqPAyGB7YrdXylVieFBCk4V6mQsdgSi3Qp7dHAaMuD6+CXz53JsNBGjtBCbzEMHMNk
 8yV+YFtH+eHn8kkGM2qeoYOBxrDjvJbnAQZHa+uTVmUm8O59yPdXPsA+lcQbuTzITyNrWW
 dmOzgZTCHAWCLWM7AJzFYBMZT1lkeQSNRqdWJg2C3Ncb2audeaDBaZui4G28eZLb5wBAVg
 y1JnzgPS7JHEEy5Oan992vh2VxYRRLT+corWIERzo0PGBw9r2dNnkM2kyckKMg==
Message-Id: <4d71dc0f-dce0-4d69-80ca-bdd8047eb9da@bytedance.com>
In-Reply-To: <20260727135725.694139f5ecad67752b0985d0@linux-foundation.org>
Subject: Re: [PATCH v8 0/9] mm: optimize zone-device memmap initialization
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a6849da+ea34df+vger.kernel.org+lizhe.67@bytedance.com>
User-Agent: Mozilla Thunderbird
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <20260727123429.5673-1-lizhe.67@bytedance.com> <20260727135725.694139f5ecad67752b0985d0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
To: "Andrew Morton" <akpm@linux-foundation.org>
Date: Tue, 28 Jul 2026 14:18:44 +0800
Content-Transfer-Encoding: 7bit

On 7/28/26 4:57 AM, Andrew Morton wrote:
> On Mon, 27 Jul 2026 20:34:20 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
>
>> memmap_init_zone_device() can take a noticeable amount of time when large
>> pmem namespaces are bound or rebound, because it initializes nearly
>> identical struct page descriptors one PFN at a time. This series reduces
>> that ZONE_DEVICE memmap initialization overhead by reusing prepared
>> struct page templates and, on x86, using memcpy_nontemporal() for the
>> template copy path.
> Thanks.
>
> Human review started out strong but petered out later in the series.
> This often happens.  I'd prefer to wait until it fills out further.
>
> AI review had things to say, as it often does:
> 	https://sashiko.dev/#/patchset/20260727123429.5673-1-lizhe.67@bytedance.com
Thanks for the review.

These comments seem to mostly cover the same memcpy_nontemporal(),
MOVNTI alignment, helper-level drain, and sanitizer/tracepoint tradeoff
topics that were discussed for v7.

The v8 changes keep the x86 non-temporal copy path unchanged, except for
making the generic memcpy_nontemporal() fallback a void function-like
macro. The remaining updates are clarifications in the cover letter and
commit messages.

So I do not plan further code changes for these comments at this point,
unless someone points out a problem in the previous discussion.

For the previous discussion, please see:
https://lore.kernel.org/all/20260722081800.90085-1-lizhe.67@bytedance.com/

Thanks,
Zhe
