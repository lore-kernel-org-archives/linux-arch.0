From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: io: Fix ioread16/32be and iowrite16/32be
Date: Thu, 07 Feb 2013 15:20:15 +0100
Message-ID: <3630909.tYHO9HKPet@wuerfel>
References: <1360246728-3490-1-git-send-email-michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63513 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124Ab3BGOU3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2013 09:20:29 -0500
In-Reply-To: <1360246728-3490-1-git-send-email-michal.simek@xilinx.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org

On Thursday 07 February 2013 15:18:48 Michal Simek wrote:
> Fix ioreadXXbe and iowriteXXbe functions which did
> additional little endian conversion on native big endian systems.
> Using be_to_cpu (cpu_to_be) conversions with __raw_read/write
> functions have resolved it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: linux-arch@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
