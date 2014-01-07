From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/5] mm: create generic early_ioremap() support
Date: Tue, 7 Jan 2014 15:25:56 +0000
Message-ID: <20140107152555.GB16947@localhost>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-2-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1389062120-31896-2-git-send-email-msalter@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Mark Salter <msalter@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 07, 2014 at 02:35:16AM +0000, Mark Salter wrote:
> This patch creates a generic implementation of early_ioremap() support
> based on the existing x86 implementation. early_ioremp() is useful for
> early boot code which needs to temporarily map I/O or memory regions
> before normal mapping functions such as ioremap() are available.
> 
> There is one difference from the existing x86 implementation which
> should be noted. The generic early_memremap() function does not return
> an __iomem pointer and a new early_memunmap() function has been added
> to act as a wrapper for early_iounmap() but with a non __iomem pointer
> passed in. This is in line with the first patch of this series:
> 
>   https://lkml.org/lkml/2013/12/22/69
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: x86@kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
