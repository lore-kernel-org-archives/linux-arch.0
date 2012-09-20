From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] mm: thp: Fix the update_mmu_cache() last argument
 passing in mm/huge_memory.c
Date: Thu, 20 Sep 2012 15:32:12 -0400 (EDT)
Message-ID: <20120920.153212.297605753294494829.davem@davemloft.net>
References: <CAHkRjk7uCZZvA_Ubq7vgkAV2r-vMNHxs+hZmvf+99ks+4v7isA@mail.gmail.com>
	<20120919155346.GB32398@linux-mips.org>
	<20120920124401.GF4654@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38757 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab2ITTcP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2012 15:32:15 -0400
In-Reply-To: <20120920124401.GF4654@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: ralf@linux-mips.org, Catalin.Marinas@arm.com, akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@suse.cz, Steve.Capper@arm.com

From: Will Deacon <will.deacon@arm.com>
Date: Thu, 20 Sep 2012 13:44:01 +0100

> Just to clarify: do you want a cast from pmd_t * to pte_t * or instead copy
> the hugetlb code and pass ptes around instead of pmds? The latter is pretty
> invasive...

But will be necessary for SPARC64 and POWERPC where the hugetlb
entries are encoded at the PTE level.
