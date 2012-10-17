From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] mm: thp: Set the accessed flag for old pages on
 access fault.
Date: Wed, 17 Oct 2012 11:26:20 -0400 (EDT)
Message-ID: <20121017.112620.1865348978594874782.davem@davemloft.net>
References: <1349197151-19645-1-git-send-email-will.deacon@arm.com>
	<20121002150104.da57fa94.akpm@linux-foundation.org>
	<20121017130125.GH5973@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40785 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2JQP0W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2012 11:26:22 -0400
In-Reply-To: <20121017130125.GH5973@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, Steve.Capper@arm.com

From: Will Deacon <will.deacon@arm.com>
Date: Wed, 17 Oct 2012 14:01:25 +0100

> +		update_mmu_cache(vma, address, pmd);

This won't build, use update_mmu_cache_pmd().
