Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:58932 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932079AbaH0LwX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Aug 2014 07:52:23 -0400
Date: Wed, 27 Aug 2014 12:51:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATH V2 4/6] arm: mm: Enable RCU fast_gup
Message-ID: <20140827115137.GK6968@arm.com>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
Message-ID: <20140827115137.yag_5PhSLXidgFTfc_mpmudy6dYVdjYSBxLISU7I-nc@z>

On Thu, Aug 21, 2014 at 04:43:30PM +0100, Steve Capper wrote:
> Activate the RCU fast_gup for ARM. We also need to force THP splits to
> broadcast an IPI s.t. we block in the fast_gup page walker. As THP
> splits are comparatively rare, this should not lead to a noticeable
> performance degradation.
> 
> Some pre-requisite functions pud_write and pud_page are also added.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
