Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:51078 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751527Ab3EPPJV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 May 2013 11:09:21 -0400
Date: Thu, 16 May 2013 16:01:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 11/11] ARM64: mm: THP support.
Message-ID: <20130516150155.GG18308@arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-12-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-12-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130516150156.0E17cXtXufwRBK7xIe2mLppKpr5BlqCgTVtx3GHmdTE@z>

On Wed, May 08, 2013 at 10:52:43AM +0100, Steve Capper wrote:
> Bring Transparent HugePage support to ARM. The size of a
> transparent huge page depends on the normal page size. A
> transparent huge page is always represented as a pmd.
> 
> If PAGE_SIZE is 4KB, THPs are 2MB.
> If PAGE_SIZE is 64KB, THPs are 512MB.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
