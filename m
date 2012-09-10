From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 09/31] arm64: Cache maintenance routines
Date: Mon, 10 Sep 2012 17:48:15 +0100
Message-ID: <20120910164815.GB8238@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-10-git-send-email-catalin.marinas@arm.com>
 <201209071928.09999.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47106 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752361Ab2IJQsz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 Sep 2012 12:48:55 -0400
Content-Disposition: inline
In-Reply-To: <201209071928.09999.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Sep 07, 2012 at 08:28:09PM +0100, Arnd Bergmann wrote:
> On Friday 07 September 2012, Catalin Marinas wrote:
> > +
> > +/*
> > + *	dmac_inv_range(start,end)
> 
> all of these appear to be unused now. Can you remove them?

They aren't currently used but I expect some partners to make use of
them on their private development. I could drop them from the upstream
branch temporarily.

-- 
Catalin
