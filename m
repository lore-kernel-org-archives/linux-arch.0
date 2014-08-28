From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V3 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Date: Thu, 28 Aug 2014 16:23:20 +0100
Message-ID: <20140828152320.GN22580@arm.com>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37463 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751787AbaH1PXD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Aug 2014 11:23:03 -0400
Content-Disposition: inline
In-Reply-To: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>

On Thu, Aug 28, 2014 at 03:45:01PM +0100, Steve Capper wrote:
> I would like to get this series into 3.18 as it fixes quite a big problem
> with THP on arm and arm64. This series is split into a core mm part, an
> arm part and an arm64 part.
> 
> Could somebody please take patch #1 (if it looks okay)?
> Russell, would you be happy with patches #2, #3, #4? (if we get #1 merged)
> Catalin, would you be happy taking patches #5, #6? (if we get #1 merged)

Pretty sure we're happy to take the arm64 bits once you've got the core
changes sorted out. Failing that, Catalin's acked them so they could go via
an mm tree if it's easier.

Will
