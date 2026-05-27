Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2143AD50B;
	Wed, 27 May 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914799; cv=none; b=oska0oZTBVY8pYxPYfPjVKdy7ru4aorNuzF8ymuO69o3yJawob9PkdQ4Xr4RmtkbQRupHFtzzNey/7af3bfDryqcMi38DQ7yyWvZ9ZZSFPfH6GqobPSJ2crStqqGeNInCMn1Yuo0htqRNy4EkZ+t1S86CfrByekSg4r0k5Oifko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914799; c=relaxed/simple;
	bh=OjgMpruKTRXZxsp2LjIrAt2to+rWJD2LFFFBKmvjwBo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RcmLagamVLwiWkd9tZbjWZYmxK675v8OywYLLHQajKsVLwXrpsMuH++4fJ1RbW2ni3xnFIfsx49Y6M1dVf8WTs4HwA/WVhVQxcbEds/dVSH9dPuQroQRGxmQaHGbYlGSP+ufcIlam6LvtZD3NhNaUasdz5yuTHvpYg7UMTzGjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O9koNAPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O9koNAPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C2D1F000E9;
	Wed, 27 May 2026 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779914798;
	bh=zT6s2ZfDPFrK81hDTyTon4JdpXGE/BWdIUEPQ9B/F7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O9koNAPwuL8ckwpo4FRMzwxLdJDvUGlF79kpbznKq14OMdiUBct4+0GX9BFqefHGe
	 2n1H0CCz4iOm4W43yEysMDaQWFWTTkrYL9CQVzHy4TrDrXE7guiMGT13zeoLjeBASM
	 uowS3m5h30FBmsWNJvpY/m3Jw9EQcypAJG+w0PZU=
Date: Wed, 27 May 2026 13:46:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>,
 <mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 0/8] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260527134637.29621cc94aba22eb02f3a544@linux-foundation.org>
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 11:36:28 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> This series reduces latency in paths which create or recreate
> ZONE_DEVICE memmaps. Pmem hotplug is a concrete example.
> 
> memmap_init_zone_device() can spend a substantial amount of time
> initializing large ZONE_DEVICE ranges because it repeats nearly
> identical struct page setup for every PFN.
> 
> The series addresses that overhead in eight patches.

Thanks.  I'll take no action at this time, as it's getting late in the
-rc cycle and the patchset's review status is rather thin.

AI review had a number of things to say:
	https://sashiko.dev/#/patchset/20260527033636.28231-1-lizhe.67@bytedance.com
