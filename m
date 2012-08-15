From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 22/31] arm64: Floating point and SIMD
Date: Wed, 15 Aug 2012 14:35:30 +0000
Message-ID: <201208151435.30646.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-23-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56410 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2HOOfk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 10:35:40 -0400
In-Reply-To: <1344966752-16102-23-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch adds support for FP/ASIMD register bank saving and restoring
> during context switch and FP exception handling to generate SIGFPE.
> There are 32 128-bit registers and the context switching is currently
> done non-lazily. Benchmarks on real hardware are required before
> implementing lazy FP state saving/restoring.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
