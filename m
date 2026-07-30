Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D43876A1
	for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398045; cv=none; b=T9zBJqh1SEf8oE4nJluuit29dd0AU7DwS/tb6NsPMo6D1ZXunnCu6dxR4972A79FkuuEaWkF6ZKCKPw3jB+EEyH1UI9KXA7l+nXPTYnJMTwMVF93Oe9wbQpvkCRQCjuijLMyy1uQML+Sfdk0twRE1+L0SDsya2UZJHuHFOxkPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398045; c=relaxed/simple;
	bh=i8v0CBrzuIg3GbnT2uYqPiocpv9EQhDpNnWNDIDzVjY=;
	h=Subject:Message-Id:References:In-Reply-To:To:Cc:Content-Type:From:
	 Date:Mime-Version; b=HfERJhxfYQAtgYTp2hJZzkcDZs6YyYh48D4kMOb9xUqjLaQ3fQ8g93gfiqOvHA0I2QfIrjfo4HY+w0M+h2JFJ1sWm8MGJMnrFln1wVQ1GI7TaxxBU6MPNqzHF+LTTJEJQg5gpuE+hJyA5fo2tN7EAzKGk1KcCj650Z14/3Q/wjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GCtbApEQ; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GCtbApEQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785398035; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i8v0CBrzuIg3GbnT2uYqPiocpv9EQhDpNnWNDIDzVjY=;
 b=GCtbApEQtBTGYbAgBgzoKQTm7pt4C94MpHglYJgc5VBdi/BAuXU6MkZRWAmIoO+XE1hTsW
 +3NqA34XlN0IJjM/qDX07PRwD3I9f+cfzn6LGZNm4fi/04urEwWoosh0JgUBAf7Db4y6TB
 fkJRy5EAVk1B23acCjCdhtTRipLJEc1DuAQTd0V41sYWMlvovwvK/QiIp22+v3RXA5Cd/l
 7sKQwJNZxY/+qoUBrL+ilxA+LmBiruHVMIxQrgOug8Kn4oRmhFw4h/5kUdt477jcEMZ6W0
 QKYynbVpHS0FfoCpu3UQqZnlgWVx9RTEunDaodI80mJX4W1zwGzQpCFZvrY5sw==
Subject: Re: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
Message-Id: <d68f7091-60ae-4887-88f0-42f4288b8e52@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com> <20260720120259.1545-2-lizhe.67@bytedance.com> <178525732062.1556190.314794914123127147.b4-review@b4>
In-Reply-To: <178525732062.1556190.314794914123127147.b4-review@b4>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <muchun.song@linux.dev>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 30 Jul 2026 15:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a6b0308+4629c6+vger.kernel.org+lizhe.67@bytedance.com>

On 7/29/26 12:48 AM, Mike Rapoport wrote:
>> The numbers below measure the time spent in memmap_init_zone_device()
>> during driver bind/rebind. They are not measurements of the full
>> nd_pmem or dax_pmem bind/rebind operation.
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>> server.
> Since the first pathes touch the generic part of the memory map
> initialization, it would be nice to make sure they don't regress other
> architectures.


Thanks for pointing this out.

I was able to get temporary access to an arm64 environment and have
tested the generic template changes there as well. I will add the arm64
test result to the v9 cover letter.

Thanks,
Zhe
