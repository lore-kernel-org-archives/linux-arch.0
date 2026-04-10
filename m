Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B039EF0B;
	Fri, 10 Apr 2026 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846232; cv=none; b=sXxK/w9Piuzh4AOzO6o0KB/H69/P/i2iFSBMKrdgiUM41Fxb7dE5DeWB8P7tpt8Chvr1ZOy4mPFtuZbsePUew4A+bN60iLXgsu8JKRugtYeSJdRFUvTm8v5gmSD8QQXfyhTdrU0IRuN+Btf1cFhJ2R8WiX4qMsnmouoyh9LdjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846232; c=relaxed/simple;
	bh=er8Lk2y7reXP4++X5Sc35l4FKj9mHmvIFq8jXXRDfFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoyTsbzGAqHTfxoz7X5AEnn4PAhJbzLoPMQD3GDIHZ30zbCPqfpFT9Acm/p3NmprwUqXAABZs7A70w/qftHTTrjcWY2ID7KrJKgNKf4Ys0a+Q0g6Soe+uUbuVFob79xHkROwxlVMmURcggUMFjHZRDxO7HOD5S3pKo+PokZQzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QMQvUPjg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QMQvUPjg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7006C47E0;
	Fri, 10 Apr 2026 11:36:59 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D245E3F632;
	Fri, 10 Apr 2026 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775846225; bh=er8Lk2y7reXP4++X5Sc35l4FKj9mHmvIFq8jXXRDfFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMQvUPjgfeyLuB/485mMx/3GHF1ky2aQNxTM1JIHTQ5ql0H5z4anq3Y+ovhp6rg1/
	 CafKVxr6xm/rkQGOM2K4SrZBnmR3oTFtS2b/LojZ/SneD3d4ANbWFlM86a/4uEJTjm
	 thNXSFKO8POWl4qlbgcvzJVEcKvjrmJnlN1/u5Go=
Date: Fri, 10 Apr 2026 19:36:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Message-ID: <adlDSiuBeSduK0mj@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-3-usama.anjum@arm.com>
 <adlCN9sUcQdWbf_i@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adlCN9sUcQdWbf_i@arm.com>

On Fri, Apr 10, 2026 at 07:32:23PM +0100, Catalin Marinas wrote:
> What the original approach might help with is use-after-realloc in case
> we had a tagged pointer in a past life of a page and it still works now.
> Oh well, that's I guess for other types of hardening to address like
> delayed reallocation.

Another thought (for a separate series) - we could try to map the stack
as Untagged (unless stack tagging is enabled; needs compiler
instrumentation) and enable canonical tag checking (newer addition to
MTE). This way, any stray tagged pointer won't work on the stack since
it needs a 0xf tag (canonical).

-- 
Catalin
