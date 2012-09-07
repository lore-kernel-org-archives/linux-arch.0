From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 03/31] arm64: Exception handling
Date: Fri, 7 Sep 2012 19:09:30 +0000
Message-ID: <201209071909.30852.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-4-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IGTJk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:09:40 -0400
In-Reply-To: <1347035226-18649-4-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> The patch contains the exception entry code (kernel/entry.S), pt_regs
> structure and related accessors, undefined instruction trapping and
> stack tracing.
> 
> AArch64 Linux kernel (including kernel threads) runs in EL1 mode using
> the SP1 stack. The vectors don't have a fixed address, only alignment
> (2^11) requirements.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
