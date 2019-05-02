Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBNyf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 09:54:35 -0400
Date: Thu, 2 May 2019 14:54:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] arm64: don't use asm-generic/ptrace.h
Message-ID: <20190502135430.GB25142@arrakis.emea.arm.com>
References: <20190501173943.5688-1-hch@lst.de>
 <20190501173943.5688-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501173943.5688-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20190502135430.MJe9HvfWmUF54bAeVPS8hr-2YqbjULLlrABotXdRmmI@z>

On Wed, May 01, 2019 at 01:39:39PM -0400, Christoph Hellwig wrote:
> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
