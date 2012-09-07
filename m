From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 21/31] arm64: 32-bit (compat) applications support
Date: Fri, 7 Sep 2012 19:47:45 +0000
Message-ID: <201209071947.45313.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-22-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57188 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2IGTrv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:47:51 -0400
In-Reply-To: <1347035226-18649-22-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds support for 32-bit applications. The vectors page is a
> binary blob mapped into the application user space at 0xffff0000 (the
> AArch64 toolchain does not support compilation of AArch32 code). Full
> compatibility with ARMv7 user space is supported. The use of deprecated
> ARMv7 functionality (SWP, CP15 barriers) has been disabled by default on
> AArch64 kernels and unaligned LDM/STM is not supported.
> 
> Please note that only the ARM 32-bit EABI is supported, so no OABI
> compatibility.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

I guess you haven't had time to turn any of these into architecture
independent functions as discussed last time?

	Arnd
