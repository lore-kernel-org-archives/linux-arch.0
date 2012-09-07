From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 14/31] arm64: DMA mapping API
Date: Fri, 7 Sep 2012 19:38:44 +0000
Message-ID: <201209071938.44894.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-15-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54491 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665Ab2IGTit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:38:49 -0400
In-Reply-To: <1347035226-18649-15-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch adds support for the DMA mapping API. It uses dma_map_ops for
> flexibility and it currently supports swiotlb. This patch could be
> simplified further if the DMA accesses are coherent (not mandated by the
> architecture) or if corresponding hooks are placed in the generic
> swiotlb code to deal with cache maintenance.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
