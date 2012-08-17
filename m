From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 09/31] arm64: Cache maintenance routines
Date: Fri, 17 Aug 2012 11:07:29 +0100
Message-ID: <20120817100729.GF24389@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-10-git-send-email-catalin.marinas@arm.com>
 <502E1580.70702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:57780 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752227Ab2HQKIB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Aug 2012 06:08:01 -0400
Content-Disposition: inline
In-Reply-To: <502E1580.70702@ti.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>

On Fri, Aug 17, 2012 at 10:57:20AM +0100, Santosh Shilimkar wrote:
> On Tuesday 14 August 2012 11:22 PM, Catalin Marinas wrote:
> > +ENTRY(__cpuc_flush_dcache_all)
>
> We have discussed the need of cache maintenance by
> level kind of API for ARMv7 (A15).
> 
> Shouldn't we add such API for arm64 as well ?

Yes, at some point we'll probably add but we'll discuss it again when
actually needed. I wouldn't define new API now that's not used by any
AArch64 code.

-- 
Catalin
