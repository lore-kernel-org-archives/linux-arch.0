Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA90355F4E;
	Fri, 24 Apr 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058268; cv=none; b=ciUpM/MgNywZ3JYp09DgJRlbPvS2gYTHH01hBYDS536Ep6BQ4DvW313sDSQOdxtetMX7aWYkwJMslW4tWSSXhpKTm5jCg4G5WmKomMTk1S1cJR3cArK8VgAl/ZScGN2wc+8sEi5AyCb3QGEK05KNOvgarZGWn/aL1cCjOFs29OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058268; c=relaxed/simple;
	bh=HvNI2LPsNqwOsJGaVf0CXKtyG+EZsGrZ5LpX92i/5Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tun1IsGMoaL3R99RYx8EINmvwBLUC8ENdx8P624CcDgdxzV18aXGRQ89uETBq2mh+VGop1DYVTaMQYqsdUFgX1XaWr9P7D/VxfMTc6dmjvpO4JP4rIQA/4hUYm0oo8XHa65JfQWS8OpdQf1glfC+CxShtD300zaDTYRX1UzMtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DFdBkeQ9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DFdBkeQ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tizH1hZ4/m/CMLzUr8DqgQxd7xmedgpSeepdPBUoxck=; b=DFdBkeQ9jOocDotu/u2n/2c/ms
	2ru9Uf9a6khtsE+zJM78ZowEZO5o+zzkDRHbNcpnTYn2wd5waP6Lu4UE1d9rNQkBdDwV0uThNGnUe
	+vHJdbBlksVmWeO/LKyFSTX1ab31l0ZPWXB+8FA1alrIM4lBXoPqM0UU+PcjUTy7K40mpLtsjqD3d
	q8DSWDfWjkPMoR9dXrzuYj8S4Rj1X8b1z0QYD2Bev56gf862+xiF1ul3+Nrr5R2+57oMmknjNE4oL
	ciYKrCOR2Zg53mbfC8ZkmNNdr82p9RQMCEHnnfYuv64dZO8e1sCWnREbdJXbbjkeTafU88n5huAYw
	ysHnhWPg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGM1R-0000000FNYF-15Gw;
	Fri, 24 Apr 2026 19:17:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA943303078; Fri, 24 Apr 2026 21:17:03 +0200 (CEST)
Date: Fri, 24 Apr 2026 21:17:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yosry Ahmed <yosry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <20260424191703.GB3783056@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <4e7699eb-e101-4a25-b585-79a777eb7cc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7699eb-e101-4a25-b585-79a777eb7cc2@kernel.org>

On Fri, Apr 24, 2026 at 09:09:21PM +0200, David Hildenbrand (Arm) wrote:

> Forcing contributors to reply to everything. I don't like that, in particular
> not as long as there is no way for contributors to run it early in private.
> 
> In most cases, contributors just do the reasonable thing: incorporate the
> feedback in a new version.

Yes, so I understand that you can run it locally, but then you get to
pay for the tokens (and sashiko burns tokens like dry grass). I also
understand why Google/LF doesn't open this up, its a money pit no doubt.

OTOH, I see this causing more reposts of series than we would have had
previously -- and we all love more versions of series.

I'm not sure I see a solution, other than to read less email -- its not
like I can even begin to read all email I get anyway.
