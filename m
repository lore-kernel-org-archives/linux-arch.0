Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:55839 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751821Ab3EXLYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:24:31 -0400
Date: Fri, 24 May 2013 12:23:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 09/11] ARM64: mm: HugeTLB support.
Message-ID: <20130524112346.GK18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-10-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-10-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524112346.SwjdyNUCOYXJ3tJwEO0777umXMyu9sY8td-tP3xqQoY@z>

On Thu, May 23, 2013 at 06:07:56PM +0100, Steve Capper wrote:
> Add huge page support to ARM64, different huge page sizes are
> supported depending on the size of normal pages:
> 
> PAGE_SIZE is 4KB:
>    2MB - (pmds) these can be allocated at any time.
> 1024MB - (puds) usually allocated on bootup with the command line
>          with something like: hugepagesz=1G hugepages=6
> 
> PAGE_SIZE is 64KB:
>  512MB - (pmds) usually allocated on bootup via command line.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
