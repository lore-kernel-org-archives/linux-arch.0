Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:62534 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3EII1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2013 04:27:20 -0400
Received: by mail-we0-f173.google.com with SMTP id q54so2615087wes.32
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2013 01:27:19 -0700 (PDT)
Date: Thu, 9 May 2013 09:27:13 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH v2 07/11] ARM64: mm: Make PAGE_NONE pages read only
 and no-execute.
Message-ID: <20130509082712.GA28801@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-8-git-send-email-steve.capper@linaro.org>
 <20130508164341.GG20820@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130508164341.GG20820@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130509082713.hdHoLX3dEPulP3FZbFAOqPJoS1Cl-j58ua1iNQcUtYU@z>

On Wed, May 08, 2013 at 05:43:41PM +0100, Will Deacon wrote:
> On Wed, May 08, 2013 at 10:52:39AM +0100, Steve Capper wrote:
 
> Whilst it's not strictly needed for pte_exec to work, I think you should
> include PTE_PXN in the PAGE_NONE definitions as well.

Agreed, it does look a little weird without it.

Cheers,
-- 
Steve
