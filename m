From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 05/31] arm64: MMU initialisation
Date: Wed, 15 Aug 2012 13:45:08 +0000
Message-ID: <201208151345.08961.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-6-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51036 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab2HONpP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 09:45:15 -0400
In-Reply-To: <1344966752-16102-6-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch contains the initialisation of the memory blocks, MMU
> attributes and the memory map. Only five memory types are defined:
> Device nGnRnE (equivalent to Strongly Ordered), Device nGnRE (classic
> Device memory), Device GRE, Normal Non-cacheable and Normal Cacheable.
> Cache policies are supported via the memory attributes register
> (MAIR_EL1) and only affect the Normal Cacheable mappings.

It looks like you've managed to eliminate bootmem as I suggested earlier,
very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
