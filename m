Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:49543 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752977Ab3EPOAK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 May 2013 10:00:10 -0400
Date: Thu, 16 May 2013 14:52:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 06/11] ARM64: mm: Restore memblock limit when
 map_mem finished.
Message-ID: <20130516135233.GB18308@arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-7-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-7-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130516135234.mnhwwGiX9e4IviYy2ZKqT2ozFJsu12FgM9evoSrKlmk@z>

On Wed, May 08, 2013 at 10:52:38AM +0100, Steve Capper wrote:
> In paging_init the memblock limit is set to restrict any addresses
> returned by early_alloc to fit within the initial direct kernel
> mapping in swapper_pg_dir. This allows map_mem to allocate puds,
> pmds and ptes from the initial direct kernel mapping.
> 
> The limit stays low after paging_init() though, meaning any
> bootmem allocations will be from a restricted subset of memory.
> Gigabyte huge pages, for instance, are normally allocated from
> bootmem as their order (18) is too large for the default buddy
> allocator (MAX_ORDER = 11).
> 
> This patch restores the memblock limit when map_mem has finished,
> allowing gigabyte huge pages (and other objects) to be allocated
> from all of bootmem.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
