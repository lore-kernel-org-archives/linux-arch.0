Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474B435519;
	Mon, 20 Jul 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587416; cv=none; b=FCTi/HjESEV6mYDSpsCadSIej0dEVtKyGz8Ewr6a/K6KnukBNE9f8aIbza1iCT3FHnyMNWV4IKLjbZnRVYzhq4///yGg1z3RFaCpaNLxloxG6e/s6QVwG5vSB8DWeinFjMivC3rmR3zuczk6RgGtYR2gWh6BmxN+4Y/pnMQN1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587416; c=relaxed/simple;
	bh=tVg9U3O6fRLXsjD1k44qiNh8LO5HkEg9FmBjBz/pAx4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j0nf9h998VFl9LbjYOqy4I7rh2msrjVgoOQBzF8hiX3AZWdVJIj4IcBVFZ8LA9AqrWwKrZYSuZQuYIohzmN82OPI94MWPnbYO2Z98TADmn6NQBJ4p5J62g42hi+ItlLqm8pmbnkM6OAHTEzdG28PumS4MQIaBDv2w8UW1lkx2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b//Lp6Y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b//Lp6Y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052381F000E9;
	Mon, 20 Jul 2026 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784587415;
	bh=cV3t5zNRL7kvOzMLt3MLzzwzFcpy7JemF0QTTW5TJ1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b//Lp6Y1qQq95x1/uaW18cJVPYVPCDOQz6cYK2G/bx2upGzZMLgieNpFC/FT8eYU4
	 9hZQSTwr29TmoktdLWXBZLcyop14PsjPoCIlFZzcJiiNpe7G+dTUGkLnD3363238nN
	 E03456OTNBVdZArHUpbgc7eLCS4uSS7cQo9Oikw8=
Date: Mon, 20 Jul 2026 15:43:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
 <kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>,
 <tglx@kernel.org>, <muchun.song@linux.dev>, <linux-arch@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
Message-Id: <20260720154334.b619e7b436d2dc2481b233ea@linux-foundation.org>
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 20:02:49 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> memmap_init_zone_device() can take a noticeable amount of time when large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series reduces
> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nontemporal() for the
> template copy path.

What Dave said - more details on the real-world userspace benefit would
be helpful, thanks.

AI review might have found some things, one "critical":
	https://sashiko.dev/#/patchset/20260720120259.1545-1-lizhe.67@bytedance.com
