From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [patch v3 30/36] Hexagon: Add page-fault support.
Date: Mon, 12 Sep 2011 20:34:29 -0500
Message-ID: <20110913013429.GE6925@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org>
 <20110909010917.578513171@codeaurora.org>
 <1315753729.455.56.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315753729.455.56.camel@pasglop>
Sender: linux-hexagon-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Sep 11, 2011 at 12:08:49PM -0300, Benjamin Herrenschmidt wrote:
> Are you sure about enabling interrupts before going to "no_context" ?
> 
> If somebody does a user access "in atomic" with interrupt disabled (with
> the expectation that a fault would be caught by search_exception_tables
> and returned as -EFAULT), such code probably doesn't expect interrupts
> to be re-enabled implicitely.

I hadn't considered that...  I'll review this and make sure this isn't what
we intended (it probably isn't) and get it fixed.


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
