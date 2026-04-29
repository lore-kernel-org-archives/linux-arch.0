Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7234DCD2;
	Wed, 29 Apr 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473817; cv=none; b=ikJU2+p0YtvkUAgUKhf280iLAh2J/sK28xXAfvgLKXnanoQBhvsqhj2NSVViOkwGIpqp0LTao6kX2HOHZyBHySJm7Y03DyDlVwTyqwYE8SL4pl10TY1EFrz9WdqvXTGH/oypVICDObhkXL96w0pLO0G/HJbx9ssPFrz0RErHl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473817; c=relaxed/simple;
	bh=0QB+Qvxjjp0fPU4pPP754f+dTc32bLiJD+Cyf8FT9Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWOyeTP3eFfmVvv2eQRb5pOAYOKDXNM3eHL25FcRA6io2Nlo4EQ6AbSz35Mv6yKEy7Tbi3elkDYIudD26t63xaUGA6ZCPTsO/thJMD9uylkgjziwrH2MSOHmMOflcz6z7oighnRYV+IC38nm1hiuWw4s7eBEba0UqrTX23zJ138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AgsKn4Dx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AgsKn4Dx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261911596;
	Wed, 29 Apr 2026 07:43:30 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB373F62B;
	Wed, 29 Apr 2026 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777473815; bh=0QB+Qvxjjp0fPU4pPP754f+dTc32bLiJD+Cyf8FT9Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgsKn4Dxtc+zw54Fg3JARa6pKd6EWx9WJ4N4tIieLoiO0Yh9LcDjFwHvK/lNO6zbk
	 1NbhPkF0DRY2QP4bp1+HDQmSK21srsJJdMhaaHcvYnXNPCQ2C+uYwSBue7h1A8ZO1c
	 HR4bYnQBmkZ5GexDoMfV0gabeltW9XYjiNMbL2/g=
Date: Wed, 29 Apr 2026 15:43:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
	kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, arnd@arndb.de,
	Muhammad Usama Anjum <usama.anjum@arm.com>, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, tglx@kernel.org,
	mathieu.desnoyers@efficios.com, linux-arch@vger.kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v4 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Message-ID: <afIY9zevao9S3zKy@arm.com>
References: <20260429102704.680174-1-dev.jain@arm.com>
 <20260429102704.680174-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429102704.680174-3-dev.jain@arm.com>

On Wed, Apr 29, 2026 at 03:57:03PM +0530, Dev Jain wrote:
> From: Muhammad Usama Anjum <usama.anjum@arm.com>
> 
> HW-tag KASAN never checks kernel stacks because stack pointers carry the
> match-all tag, so setting/poisoning tags is pure overhead.
> 
> - Add __GFP_SKIP_KASAN to THREADINFO_GFP so every stack allocator that
>   uses it skips tagging (fork path plus arch users)
> - Add __GFP_SKIP_KASAN to GFP_VMAP_STACK for the fork-specific vmap
>   stacks.
> - When reusing cached vmap stacks, skip kasan_unpoison_range() if HW tags
>   are enabled.
> 
> Software KASAN is unchanged; this only affects tag-based KASAN.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
