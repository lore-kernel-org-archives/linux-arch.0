From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] mm: Introduce HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date: Wed, 12 Sep 2012 19:10:20 +0100
Message-ID: <20120912181020.GH32234@mudshark.cambridge.arm.com>
References: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
 <1347382036-18455-4-git-send-email-will.deacon@arm.com>
 <20120912153206.GT21579@dhcp22.suse.cz>
 <5050CF33.4000909@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46294 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753508Ab2ILSKh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Sep 2012 14:10:37 -0400
Content-Disposition: inline
In-Reply-To: <5050CF33.4000909@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Michal Hocko <mhocko@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>

On Wed, Sep 12, 2012 at 07:06:43PM +0100, Chris Metcalf wrote:
> On 9/12/2012 11:32 AM, Michal Hocko wrote:
> > Makes sense if there are going to be more archs to support THP.
> 
> The tile architecture currently supports it in our in-house tree,
> though we haven't returned it to the community yet.

That's a similar situation for AArch64. We hope to post the arm patches
pretty soon though, just ironing out some issues with the thp code.

Unfortunately, it looks like there might be one more change to the core
code as we don't have hardware page aging and need to manipulate the YOUNG
bit explicitly.

Will
