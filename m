From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 3/5] arm: add early_ioremap support
Date: Tue, 7 Jan 2014 17:23:38 +0000
Message-ID: <20140107172338.GB6234@arm.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-4-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:38209 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752085AbaAGRYH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jan 2014 12:24:07 -0500
Content-Disposition: inline
In-Reply-To: <1389062120-31896-4-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>

On Tue, Jan 07, 2014 at 02:35:18AM +0000, Mark Salter wrote:
> This patch uses the generic early_ioremap code to implement
> early_ioremap for ARM. The ARM-specific bits come mostly from
> an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
> here:
> 
>   https://lkml.org/lkml/2013/10/3/279
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
