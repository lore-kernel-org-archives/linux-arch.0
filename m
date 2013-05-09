From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH v2 08/11] ARM64: mm: Swap PTE_FILE and
 PTE_PROT_NONE bits.
Date: Thu, 9 May 2013 09:15:05 +0100
Message-ID: <20130509081504.GA28545@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
 <518A7A9F.9080105@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:54911 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3EIIPM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2013 04:15:12 -0400
Received: by mail-we0-f180.google.com with SMTP id n5so2609211wev.11
        for <linux-arch@vger.kernel.org>; Thu, 09 May 2013 01:15:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <518A7A9F.9080105@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>

On Wed, May 08, 2013 at 12:17:35PM -0400, Christopher Covington wrote:
> Hi Steve,
> 
> On 05/08/2013 05:52 AM, Steve Capper wrote:
 
 [...]
> 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> 
 [...]
> 
> > @@ -306,8 +306,8 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> >  
> >  /*
> >   * Encode and decode a file entry:
> > - *	bits 0-1:	present (must be zero)
> > - *	bit  2:		PTE_FILE
> > + *	bits 0 & 2:	present (must be zero)
> 
> Consider using punctuation like "bits 0, 2" here to disambiguate from the
> binary and operation.
> 

Hi Christopher,
Thanks, I now have:
       bits 0, 2:      present (must both be zero)

Cheers,
-- 
Steve
