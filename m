From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 15/31] arm64: SMP support
Date: Wed, 15 Aug 2012 13:04:14 +0000
Message-ID: <201208151304.14585.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64202 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab2HONES (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 09:04:18 -0400
In-Reply-To: <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch adds SMP initialisation and spinlocks implementation for
> AArch64. The spinlock support uses the new load-acquire/store-release
> instructions to avoid explicit barriers. The architecture also specifies
> that an event is automatically generated when clearing the exclusive
> monitor state to wake up processors in WFE, so there is no need for an
> explicit DSB/SEV instruction sequence. The SEVL instruction is used to
> set the exclusive monitor locally as there is no conditional WFE and a
> branch is more expensive.
> 
> For the SMP booting protocol, see Documentation/arm64/booting.txt.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
