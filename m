Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BC2EC54A;
	Fri,  7 Aug 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071899; cv=none; b=qb5GMGS2UnMY3YAcNZQryzbSWfzQ7uRth/2qQMopaOH7umic0baLJoEPn0kAPx2stckVODZjkb7ybS2Jl8OWSzPg6ECTGN3y0ZTtnv+a6KYXi5I5jowSUBgulGWEYMpN6ccptOLEyBTHU/YhodNhMVQ7LdyaWv0xpons08mo9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071899; c=relaxed/simple;
	bh=uKm+O7AZw6fz//BmbGOF2o9qC5lVxMHc1iVJyBQ2sxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6b29XYPtEIIzs3DTYusQ1UdVm/e9AX98j2iX0yqpjmfG+XgCAZQo8jxGTkmWuhw/AL5nA6nP7LGf7fY3gYUXkdrUSgOXXNStRtuS+uVkaYN3kQqxIwfbduto2fYPij0mf5kfXtfVj9D73pnM61mPGfwadNUp9wpQ5TcqMjkScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KCGUWKlk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KCGUWKlk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC8ED1516;
	Thu,  6 Aug 2026 20:04:51 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AEE03F632;
	Thu,  6 Aug 2026 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786071895; bh=uKm+O7AZw6fz//BmbGOF2o9qC5lVxMHc1iVJyBQ2sxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCGUWKlkBhQkid6298mbUGrvwOy3yjyaj7fJuZ78NAAp61RUU+pb23ZqfUmWzKJny
	 K6qzmEI+vufX6AL0zi4P8fF81RodsJZrgzIsoIXX1V9N3RKa/xNPoWKU+sNlafL7o0
	 SveQaWFANxHPpoyzxB+irLTu9ZkkgXsMGPJ2Ml3I=
Date: Fri, 7 Aug 2026 08:34:52 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Drop pxd_ERROR()
Message-ID: <cvv4iwa33bpfrqn5vbg7qjomvazrxm55i4u4gubgcllwm2so5n@2hdj5rbzmcd6>
References: <20260806080639.1916749-1-anshuman.khandual@arm.com>
 <70cb93fc-22d3-49fd-9103-29a4759bc39b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cb93fc-22d3-49fd-9103-29a4759bc39b@kernel.org>

On Thu, Aug 06, 2026 at 01:47:23PM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 10:06, Anshuman Khandual wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> > 
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> > 
> > Although some platforms still use those macros internally as well. In which
> > case just move these macros inside the platform for now.
> 
> No, just get rid of them first.
> 
> The ones in arch/sh/mm/init.c are just supid:
> 
> if (pgd_none(*pgd)) {
> 	pgd_ERROR(*pgd);
> 
> printing a none PGD? Stupid. :)

Will drop them from arch/sh in a pre-requsite patch.

> 
> Then there is arch/parisc/kernel/pci-dma.c, which just open-codes
> pmd_clear_bad() ?
> 
> 	pmd_ERROR(*pmd);
> 	pmd_clear(pmd);

Will replace these instances in arch/parisc/ with corresponding generic
[pmd|pgd]_clear_bad() helpers as necessary in a pre-requsite patch.

> 
> 
> Anything else?

Just one more instance inside arch/loongarch/mm/init.c which could be
dropped as well.

        if (!pte_none(ptep_get(ptep))) {
                pte_ERROR(*ptep);
                return;
        }
> 
> > 
> > Cc: David Hildenbrand (Arm) <david@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org> 
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v7.2-rc6 but after the following patch
> > 
> > https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/
> > 
> > Would it also make sense to just drop __FILE__ and __LINE__ from the output
> > in pxd_clear_bad() helpers as they always print the same details regardless
> > the error path and does not add much value.
> 
> Yes, drop that, it's nonsensical given that all relevant calls are from
> mm/pgtable-generic.c

Will drop them.

> 
> Thanks for looking into this!
> 
> -- 
> Cheers,
> 
> David
