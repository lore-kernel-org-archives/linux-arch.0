From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 2/3] ARM: Use include/asm-generic/io.h
Date: Thu, 17 Jul 2014 13:03:51 +0100
Message-ID: <20140717120351.GH18203@arm.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <1405508484-18303-2-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:21539 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754868AbaGQMEI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jul 2014 08:04:08 -0400
Content-Disposition: inline
In-Reply-To: <1405508484-18303-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 16, 2014 at 12:01:23PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Include the generic I/O header file so that duplicate implementations
> can be removed. This will also help to establish consistency across more
> architectures regarding which accessors they support.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
