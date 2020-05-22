Return-Path: <SRS0=yLSb=7E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgEVPye (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 11:54:34 -0400
Date: Fri, 22 May 2020 16:54:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 09/29] arm64: use asm-generic/cacheflush.h
Message-ID: <20200522155426.GI26492@gaia>
References: <20200515143646.3857579-1-hch@lst.de>
 <20200515143646.3857579-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515143646.3857579-10-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>, Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200522155427.ouE2XUDsk3fkimvkAlmIKSrGAVrqX_jqNP5Zekw6kLA@z>

On Fri, May 15, 2020 at 04:36:26PM +0200, Christoph Hellwig wrote:
> ARM64 needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
