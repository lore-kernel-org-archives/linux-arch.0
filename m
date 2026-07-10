Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECC4499A3;
	Fri, 10 Jul 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656593; cv=none; b=YNgWfo+jgK+TcEiPQVtMQXB2wRSle4mToXTgmo5FmBN7Onin57UD/oR7ABuUSJc4+kmhwxydebDdeOllj+AR2jKKRCYZtrCkcUg719iQ+fEhxYpQku3Ebhi0JPQHqSWOnBLWmwFvxQIh+0QcVGJtTREv4yhSRtOsNdJpNAnq5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656593; c=relaxed/simple;
	bh=+uGUBqvPYES6PXfbIHb0cgdUSGMx1u7ozvhCYTMpAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcOZeFqyiWIDZXKmUvvxBu91k1IRXAGDck8uryDXJQy+Fan7LNFL8KTOh+ZDUhtvUGLh+ZjMIn/E65evRgDiL8HTzsHryZVDA6fgzKOmch/78ZClvjibsDLqCP/SmwMdh0QkESnf3mubCNybBT8TEXJTABxdQGehDP+QOcTNwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UZKgSZ9H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UZKgSZ9H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XZ2ZKJwyH+czH0S6wCGrcRFmnJfF64txwylbTE5TD3Y=; b=UZKgSZ9HstM/m6zYkRbYa7ngfh
	DZ/56Ny6UarWRcWvOxILB52RdTY0S/lHv4mZLNuD2heZv5MHp43p74p7HIuDftdk55uB6CB1dDa3K
	jbkrEd87hXH4+3hLmn0IQwvXRw/c7ySwiiHkMFgXYVetbjUKqLsHBY1QS+vuGR6dG38TRnUY/Neoo
	XJlA7lXNLL8J0bmr4Y4KTj+lhtXLClFJ3OqTu6Z/Dkfng25d6iHRlJh/0nzLndSfFYKGT6Gf2BPMr
	PVr+yA/Fk8aBAZWsQVZ6SRgj7aGESs5Kjbdl/pHBqMDGf/0EupVJ0um+iO2M4vAGoq7t4phcoTnCW
	l0QHE1dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi2YJ-000000044w5-0wtb;
	Fri, 10 Jul 2026 04:09:27 +0000
Date: Thu, 9 Jul 2026 21:09:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eugen Hristev <ehristev@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/26] mm/swapfile: Annotate static information into
 meminspect
Message-ID: <alBwd9ACdVNEucut@infradead.org>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708-meminspect-v3-v3-11-7aa5a0a74d5c@oss.qualcomm.com>
 <ak4AgXqMnkn8rVGE@lucifer>
 <20260708190535.fhqaddicljho44eq@hu-mojha-hyd.qualcomm.com>
 <ak-1HujOABoQ9wR_@lucifer>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-1HujOABoQ9wR_@lucifer>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 09, 2026 at 03:53:44PM +0100, Lorenzo Stoakes wrote:
> > The whole reason we had to tag most of the MM symbols is that
> > the crash tool looks for this information while launching itself.
> 
> You're missing the point.
> 
> EXPORT_SYMBOL_GPL() != EXPORT_SYMBOL().
> 
> We cannot and will not allow symbols that are GPL-only to be exported by the
> back door to non-GPL modules.
> 
> Meminspect seems to ignore all of this and just exports symbols another way
> overriding kernel mechanisms which is just not acceptable...
> 
> I also don't really understand what you're saying here either, what has what
> crash looks up on startup got to do with anything?

Yeah, random backdoor exports for a totally opaque facility without
good use cases that comes from a known malicious actor like qualcomm is
a no-go.  I don't think anyone should even waste time on this.

