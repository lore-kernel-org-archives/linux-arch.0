From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 4/6] arm: mm: Enable RCU fast_gup
Date: Wed, 27 Aug 2014 14:01:08 +0100
Message-ID: <20140827130107.GA8210@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
 <20140827115137.GK6968@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140827115137.GK6968@arm.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 27, 2014 at 12:51:37PM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:30PM +0100, Steve Capper wrote:
> > Activate the RCU fast_gup for ARM. We also need to force THP splits to
> > broadcast an IPI s.t. we block in the fast_gup page walker. As THP
> > splits are comparatively rare, this should not lead to a noticeable
> > performance degradation.
> > 
> > Some pre-requisite functions pud_write and pud_page are also added.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
