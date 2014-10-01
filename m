Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:39994 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaJALLj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Oct 2014 07:11:39 -0400
Date: Wed, 1 Oct 2014 12:11:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
Message-ID: <20141001111127.GG12702@e104818-lin.cambridge.arm.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
 <alpine.LSU.2.11.1409291443210.2800@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1409291443210.2800@eggly.anvils>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Steve Capper <steve.capper@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
Message-ID: <20141001111128.ggOgtLuyLGdx7dlZgjvasNaSxTPLjpFFkWGbjJDdXa0@z>

On Mon, Sep 29, 2014 at 10:51:25PM +0100, Hugh Dickins wrote:
> On Fri, 26 Sep 2014, Steve Capper wrote:
> > This patch provides a general RCU implementation of get_user_pages_fast
> > that can be used by architectures that perform hardware broadcast of
> > TLB invalidations.
> >
> > It is based heavily on the PowerPC implementation by Nick Piggin.
> >
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > Tested-by: Dann Frazier <dann.frazier@canonical.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Thanks for making all those clarifications, Steve: this looks very
> good to me now.  I'm not sure which tree you're hoping will take this
> and the arm+arm64 patches 2-6: although this one would normally go
> through akpm, I expect it's easier for you to synchronize if it goes
> in along with the arm+arm64 2-6 - would that be okay with you, Andrew?
> I see no clash with what's currently in mmotm.
