Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:62869 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab3EBKFS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2013 06:05:18 -0400
Received: by mail-we0-f169.google.com with SMTP id x51so333019wey.14
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2013 03:05:17 -0700 (PDT)
Date: Thu, 2 May 2013 11:05:08 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH 8/9] ARM64: mm: Introduce MAX_ZONE_ORDER for 64K
 and THP.
Message-ID: <20130502100507.GA19880@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-9-git-send-email-steve.capper@linaro.org>
 <20130502100000.GB20730@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130502100000.GB20730@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20130502100508.haU09e5R8uTnza1xNYXmVVI4ZMbwOsiqufFmEbLso-I@z>

On Thu, May 02, 2013 at 11:00:00AM +0100, Catalin Marinas wrote:
> On Tue, Apr 30, 2013 at 05:30:47PM +0100, Steve Capper wrote:
 
> Can we just keep some sane defaults here without giving too much choice
> to the user? Something like:
> 
> config FORCE_MAX_ZONEORDER
> 	int
> 	default "13" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> 	default "11"
> 
> We can extend it later if people need this but I'm aiming for a single
> config on a multitude of boards.
> 
> -- 
> Catalin

Thanks, that does look a lot neater :-).

-- 
Steve
