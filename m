Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBF3624CE;
	Fri, 24 Apr 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052469; cv=none; b=PcChiHnEa71dvK05CGAkoCPIUBZp+XmNJiMU9E/DcsjeRNLGL/SU1JFJa80QotuEetXpsVCIgshG2xnCz/H4IB0SsdVtfqXzwvrBXk+mZziQWKv8vimeNQRfhVcV0rvdgm+0Ozh/MXcSojdX8Kbj9/qRFhyUKio4tVjzgX3mG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052469; c=relaxed/simple;
	bh=Teo20paGpHrbq1obZzr+ivLwVPOuVk5CdKUvJCX5l/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2yehUma+9/gXPIsF47YXbpbJdw2fGAZvQKr/1dmll72646zGuFp27QQiJGTS8dsr7uGlM4ULyEJNTy/HqZPr3mEslStIonekl4FiNpIlnulixzqBa5FWp4oZqxh/60R5YoJBidwNpp2KB3usb30XBhJbMH+OF1pYlTO4DITD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cPQuVxEx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cPQuVxEx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3165835AF;
	Fri, 24 Apr 2026 10:41:01 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B033F7B4;
	Fri, 24 Apr 2026 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777052466; bh=Teo20paGpHrbq1obZzr+ivLwVPOuVk5CdKUvJCX5l/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPQuVxEx+ilikHFEHbBAVKhTf7vRHHLLoWB14XBOqWjDoo4pBgHSEjHSse8e2RtPO
	 3Eec2OmUSUZv5Oial8RpzuMfHYSmBrpGQWeJUf9s5ByfOdIZG35t86xdh5x2kNvtC5
	 y/tw5yFTZfb3QB9tMRqplRkgCa2PIkOBKnomrZiw=
Date: Fri, 24 Apr 2026 18:41:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: arnd@arndb.de, kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, tglx@kernel.org,
	usama.anjum@arm.com, mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3 3/3] mm: skip KASAN tagging for page-allocated page
 tables
Message-ID: <aeurLGC4ohFU9Xtn@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
 <20260424130157.3163009-4-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424130157.3163009-4-dev.jain@arm.com>

On Fri, Apr 24, 2026 at 06:31:57PM +0530, Dev Jain wrote:
> From: Muhammad Usama Anjum <usama.anjum@arm.com>
> 
> Page tables are always accessed via the linear mapping with a match-all
> tag, so HW-tag KASAN never checks them. For page-allocated tables (PTEs
> and PGDs etc), avoid the tag setup and poisoning overhead by using
> __GFP_SKIP_KASAN. SLUB-backed page tables are unchanged for now. (They
> aren't widely used and require more SLUB related skip logic. Leave it
> later.)
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Your signed-off-by is missing. You must add it if you are reposting
someone else's patches.

Also I only got cc'ed on patch 3. You should normally cc all people on
all patches. Maybe you could skip this if the patches are some
independent cleanups but even so, I'd still cc all the others at least
on the cover letter.

-- 
Catalin
