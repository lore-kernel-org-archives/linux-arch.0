From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
Date: Thu, 29 Aug 2019 14:21:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-6-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829111843.41003-6-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 29 Aug 2019, Vincenzo Frascino wrote:

> As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove

-ENOSUCH commit ....

Just say:

VDSO_HAS_32BIT_FALLBACK has been removed from the core ....

Thanks,

	tglx
