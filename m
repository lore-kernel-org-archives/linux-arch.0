From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/31] arm64: MMU initialisation
Date: Fri, 7 Sep 2012 19:10:56 +0000
Message-ID: <201209071910.57084.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-6-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56099 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab2IGTLC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:11:02 -0400
In-Reply-To: <1347035226-18649-6-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> This patch contains the initialisation of the memory blocks, MMU
> attributes and the memory map. Only five memory types are defined:
> Device nGnRnE (equivalent to Strongly Ordered), Device nGnRE (classic
> Device memory), Device GRE, Normal Non-cacheable and Normal Cacheable.
> Cache policies are supported via the memory attributes register
> (MAIR_EL1) and only affect the Normal Cacheable mappings.
> 
> This patch also adds the SPARSEMEM_VMEMMAP initialisation.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
