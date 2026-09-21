Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A17496D5B;
	Mon, 21 Sep 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995820; cv=none; b=qNiR/1A7jkrLG6dEjhA+O7vyRI0RJmjhYCVQtE0BIIL6EGqdWsM0IFbc6BaAdotSt7SsXVkjNVc8L3e7HiSTameoR0QsC2tyJA6GGA+yX0Xarj1f3igiPoP6rvQye0luv49qHsARmjf/NCnwakjGi+nwuzHOUoOCkPnZEtxL64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995820; c=relaxed/simple;
	bh=OoPqL9ehIIvD/OJY5G8d5/03edwIvHcNFvhV8sTgPSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8EDK25J3WLIETtVrjx+EamoWkzHZNBvyuea4QnTwa819zgwJVE19idOE2wB/PMcBKSZ2PjCEZAv2bYU9czTWMDuuhMFiAfPrV8mapTii63dlzbnAk/wvx3j+Cn4/s2cPuxT80MizpxWVnKtx3gQcHi12KbvDEjEfk5z1gs5hT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y9x5z2N9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y9x5z2N9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4571C19F0;
	Mon, 21 Sep 2026 06:03:35 -0700 (PDT)
Received: from [10.57.6.224] (unknown [10.57.6.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EAF3F86F;
	Mon, 21 Sep 2026 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789995818; bh=OoPqL9ehIIvD/OJY5G8d5/03edwIvHcNFvhV8sTgPSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y9x5z2N9wxF1WJc9DrkVDbq6LZtMWGUJDqscc1hkUG8aFM75LsyBMucrsg5EiOBdx
	 z/KSv4t2K5w/2K/s6vlsXf3XnlX276qju0hZG4HW9aOmWjiILwbXEnleijlMRvTfc/
	 6aooxHtsj5Y6TP7O2n7n5OE1KlPrfuIzbkwiW3Ms=
Message-ID: <433d32a4-f59a-4d6c-915d-2c1b4c22b840@arm.com>
Date: Mon, 21 Sep 2026 15:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/mm: describe set_memory() and set_direct_map()
 APIs
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260919-set-memory-docs-v2-1-a2a4b3657690@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260919-set-memory-docs-v2-1-a2a4b3657690@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2026 12:43, Mike Rapoport (Microsoft) wrote:
> [...]
>
> +Modifying the kernel page tables
> +================================
> +
> +Except for the vmalloc area, the kernel page tables are mostly static. Still,
> +there are cases when the permissions of existing kernel mappings have to be
> +updated, for instance when a module is loaded and its text becomes read-only
> +and executable, or when a page is temporarily removed from the direct map to
> +reduce its exposure.
> +
> +There are two families of functions for this, both declared in
> +`include/linux/set_memory.h`:
> +
> +* `set_memory_*()` change permissions of an arbitrary kernel mapping. They
> +  take a kernel virtual address and the number of pages.
> +
> +* `set_direct_map_*()` change permissions of the direct mapping of the page
> +  frame represented by a `struct page`. They take a `struct page` pointer and

The new phrasing is a mouthful but at least should be accurate :) It
should probably say "range of page frames" or something like that though.

Looks good otherwise!

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
