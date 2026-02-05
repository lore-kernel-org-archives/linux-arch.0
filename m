Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958A421F0F;
	Thu,  5 Feb 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310121; cv=none; b=aJ5vlXae7qgLrqgqRyz/iLJbhB4UmIAi+8ER4p9uXGSDhpWSO0cdHbXrx9e7CB2SfbwqFv+kFnFBvgyabmwV8rRlC30YjHmeGqOgAXukMMwRtWql0AOLS6zCiM4mF8cT7e/uA+YxHfCO1xZ6OysWcljUI77gQLv4eFtRpIi8Jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310121; c=relaxed/simple;
	bh=byhdSIfpXwJJLEbl9yDeWmGc+L3g/CshZfQ1cqwD/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOGIuOo+s4W2xh0jLElVMUlXmT73im6Odx08vLdTflhxvadwsMKu9Z/TjNI6fMvoj4Kr0lnT3BkeR2R8uZoNwZHQgYf7Jlhr2nwNIOFlCMF8OEjo2HXQotEa5IbpPL2FWflWzsQh5xOxHvJzIvQZM5H1qUf6upUdMNSG5H6Vvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMnVnRsR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMnVnRsR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yx/d01Y58MDZvuU9Az//GxypXm/UanK1HY+5wvpwfYU=; b=MMnVnRsRRqqFRmmqm8szxt55xC
	kumtGKJdsNGk1kzy5/T3qafT1MGgU2cyyBGV7bHPnR7O4Gh3dHG7iA4iulap9fnlIK594qOoyzuB4
	SVND5ODlyYngv7IzrVCeW4d01m9p7gb5Abo1jCv8lodGXGY9zl+G8QcqV0MyUZPRC++OePTTDS+8J
	uCGDnccOQoLRqUlTap688HhAGnOPvG2RtjFzFGbJZePYaReJhbIxVuCCsQKuqZ/fgpqAVsHkQuyA8
	iV+1jAgW/LD2kocjmOpkRhJtk9e8aXYQ6I1HL2ds9nwQlDVOgvXaqc2zWr9bHLK+Tx3jF0OJtp0IH
	wtE6Vjpw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2Wb-00000003tzE-36Oa;
	Thu, 05 Feb 2026 16:48:13 +0000
Date: Thu, 5 Feb 2026 16:48:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Dave Hansen <dave.hansen@intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Liam.Howlett@oracle.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org, arnd@arndb.de,
	baohua@kernel.org, baolin.wang@linux.alibaba.com,
	boris.ostrovsky@oracle.com, bp@alien8.de,
	dave.hansen@linux.intel.com, dev.jain@arm.com, hpa@zytor.com,
	hughd@google.com, ioworker0@gmail.com, jannh@google.com,
	jgross@suse.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, mingo@redhat.com, npache@redhat.com,
	npiggin@gmail.com, pbonzini@redhat.com, riel@surriel.com,
	ryan.roberts@arm.com, seanjc@google.com, shy828301@gmail.com,
	tglx@linutronix.de, virtualization@lists.linux.dev, will@kernel.org,
	x86@kernel.org, ypodemsk@redhat.com, ziy@nvidia.com
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Message-ID: <aYTJzft5cuqD9akC@casper.infradead.org>
References: <20260202133713.GF1395266@noisy.programming.kicks-ass.net>
 <540adec9-c483-460a-a682-f2076cf015c2@linux.dev>
 <20260202150957.GD1282955@noisy.programming.kicks-ass.net>
 <d6944cd8-d3b7-4b16-ab52-a61e7dc2221c@linux.dev>
 <06d48a52-e4ec-47cd-b3fb-0fccd4dc49f4@kernel.org>
 <3026ad8d-92ad-4683-8c3e-733d4070d033@linux.dev>
 <64f3a75a-30ff-4bee-833c-be5dba05f72b@intel.com>
 <c985a8ed-37ad-415e-b7b4-18a66b4da3fe@linux.dev>
 <647cbe2e-a034-4a75-9492-21ea1708eccc@intel.com>
 <99237729-f2b0-4a7a-8213-65a2f1c57744@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99237729-f2b0-4a7a-8213-65a2f1c57744@linux.dev>

On Fri, Feb 06, 2026 at 12:30:56AM +0800, Lance Yang wrote:
> On 2026/2/5 23:41, Dave Hansen wrote:
> > Yeah, but one aim of RCU is ensuring that readers see valid data but not
> > necessarily the most up to date data.
> > 
> > Are there cases where ongoing concurrent lockless page-table walks need
> > to see the writes and they can't tolerate seeing valid but slightly
> > stale data?
> 
> The issue is we're about to free the page table (e.g.
> pmdp_collapse_flush()).
> 
> We have to ensure no walker is still doing a lockless page-table walk
> when the page directories are freed, otherwise we get use-after-free.

But can't we RCU-free the page table?  Why do we need to wait for the
RCU readers to finish?

