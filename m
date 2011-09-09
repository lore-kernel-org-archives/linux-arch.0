From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Re: [patch v3 24/36] Hexagon: Provide basic implementation and/or
 stubs for I/O routines.
Date: Fri, 9 Sep 2011 14:14:13 -0500
Message-ID: <20110909191412.GB2034@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org>
 <20110909010916.993872033@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110909010916.993872033@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 08, 2011 at 08:09:11PM -0500, Richard Kuo wrote:
> +	asm volatile(
> +		"memb(%0) = %1;"
> +		:
> +		: "r" (addr), "r" (data)
> +	);

I'm kind-of vague on this, but I think that this also needs a
: "memory" at the end (to indicate that the asm snippet clobbers
memory), as otherwise the compiler may be tempted to reorder
these around other memory accesses. That is, the "volatile"
keyword is not enough (well, I'm not sure...), but I think
"volatile" only prevents the compiler from optimizing these
away completely, but is not enough to prevent unwanted
re-ordering.

--linas

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
