From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 25/31] arm64: Performance counters support
Date: Wed, 15 Aug 2012 15:11:11 +0000
Message-ID: <201208151511.11612.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-26-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52400 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2HOPLO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:11:14 -0400
In-Reply-To: <1344966752-16102-26-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds support for the AArch64 performance counters.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/perf_event.h |   22 +
>  arch/arm64/include/asm/pmu.h        |   82 +++
>  arch/arm64/kernel/perf_event.c      | 1368 +++++++++++++++++++++++++++++++++++
>  tools/perf/perf.h                   |    6 +

Can you explain how AArch64 performance counters differ from the 32
bit ones? Do they work for AArch32 user space under AArch64 kernels?
Is it possible to share parts of the implementation with arch/arm?

	Arnd
