From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/4] arm64: use generic dma-contiguous.h
Date: Thu, 17 Jul 2014 11:23:19 +0100
Message-ID: <20140717102318.GC18203@arm.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:34482 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755474AbaGQKXh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jul 2014 06:23:37 -0400
Content-Disposition: inline
In-Reply-To: <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: "ralf@linux-mips.org" <ralf@linux-mips.org>, Will Deacon <Will.Deacon@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "mina86@mina86.com" <mina86@mina86.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, Jul 16, 2014 at 04:51:30PM +0100, Zubair Lutfullah Kakakhel wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in arm64.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/arm64/include/asm/Kbuild           |  1 +
>  arch/arm64/include/asm/dma-contiguous.h | 28 ----------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-contiguous.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
