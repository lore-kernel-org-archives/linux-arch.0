From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/31] arm64: Assembly macros and definitions
Date: Wed, 15 Aug 2012 12:57:33 +0000
Message-ID: <201208151257.33405.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-2-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62962 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383Ab2HOM5g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 08:57:36 -0400
In-Reply-To: <1344966752-16102-2-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch introduces several assembly macros and definitions used in
> the .S files across arch/arm64/ like IRQ disabling/enabling, together
> with asm-offsets.c.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
