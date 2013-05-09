Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61367 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab3EIIWk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2013 04:22:40 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so2801839wib.17
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2013 01:22:39 -0700 (PDT)
Date: Thu, 9 May 2013 09:22:36 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH v2 08/11] ARM64: mm: Swap PTE_FILE and
 PTE_PROT_NONE bits.
Message-ID: <20130509082235.GB28545@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
 <20130508164018.GF20820@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130508164018.GF20820@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130509082236.gjftiGGVy2Q03ZKeDJehdY5Cbhs81ofnw7wgqsjfhfU@z>

On Wed, May 08, 2013 at 05:40:19PM +0100, Will Deacon wrote:
> On Wed, May 08, 2013 at 10:52:40AM +0100, Steve Capper wrote:

 [...] 

> Can you update the comment describing swp entries too please? I *think* the
> __SWP_* defines can remain untouched, but the comment is now wrong.
> 
> Will

Ta Will, I've now changed the other comment.
The __SWP_* entries look ok to me. I'm going to run some swap tests though
to see if anything crops up.

Cheers,
-- 
Steve
