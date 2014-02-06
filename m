From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 4/5] arch: Generic atomic.h cleanup
Date: Thu, 6 Feb 2014 17:49:45 +0000
Message-ID: <20140206174945.GC27276@mudshark.cambridge.arm.com>
References: <20140206134825.305510953@infradead.org>
 <20140206135001.256758416@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39078 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbaBFRuX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2014 12:50:23 -0500
Content-Disposition: inline
In-Reply-To: <20140206135001.256758416@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Thu, Feb 06, 2014 at 01:48:29PM +0000, Peter Zijlstra wrote:
> XXX: split up in per arch patches?

Yes please -- I have a bunch of changes in this area pending for both arm
and arm64.

Cheers,

Will
