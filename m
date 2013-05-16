Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52820 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751392Ab3EPPCh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 May 2013 11:02:37 -0400
Date: Thu, 16 May 2013 15:59:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 10/11] ARM64: mm: Raise MAX_ORDER for 64KB pages
 and THP.
Message-ID: <20130516145927.GF18308@arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130516145927.yeJ5qCbq1yo2pRfB-HspByw65Fo6uV0cUCPFfJD2Gw0@z>

On Wed, May 08, 2013 at 10:52:42AM +0100, Steve Capper wrote:
> The buddy allocator has a default MAX_ORDER of 11, which is too
> low to allocate enough memory for 512MB Transparent HugePages if
> our base page size is 64KB.
> 
> This patch introduces MAX_ZONE_ORDER and sets it to 14 when 64KB
> pages are used in conjuction with THP, otherwise the default value
> of 11 is used.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
