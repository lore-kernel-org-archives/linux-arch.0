From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/31] arm64: TLB maintenance functionality
Date: Fri, 7 Sep 2012 19:28:52 +0000
Message-ID: <201209071928.52417.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-11-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54234 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2IGT24 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:28:56 -0400
In-Reply-To: <1347035226-18649-11-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> This patch adds the TLB maintenance functions. There is no distinction
> made between the I and D TLBs. TLB maintenance operations are
> automatically broadcast between CPUs in hardware. The inner-shareable
> operations are always present, even on UP systems.
> 
> NOTE: Large part of this patch to be dropped once Peter Z's generic
> mmu_gather patches are merged.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
