From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH -tip 2/4] arm: Cleanup in_exception_text() and move it in
 asm/sections.h
Date: Sun, 3 Sep 2017 23:21:52 +0100
Message-ID: <20170903222152.GA25743@n2100.armlinux.org.uk>
References: <150295395797.14424.968407208436624832.stgit@devbox>
 <150295409062.14424.11976553130089631456.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <150295409062.14424.11976553130089631456.stgit@devbox>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <treding@nvidia.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 17, 2017 at 04:15:00PM +0900, Masami Hiramatsu wrote:
> Cleanup in_exception_text() using memory_contains() and
> move it in asm/sections.h from asm/trap.h because
> section symbols and memory_contains() are defined in
> asm/sections.h.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/include/asm/sections.h |   17 +++++++++++++++++
>  arch/arm/include/asm/traps.h    |   22 +---------------------
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
> index 803bbf2b20b8..76791cfc7619 100644
> --- a/arch/arm/include/asm/sections.h
> +++ b/arch/arm/include/asm/sections.h
> @@ -4,5 +4,22 @@
>  #include <asm-generic/sections.h>
>  
>  extern char _exiprom[];
> +extern char __exception_text_start[], __exception_text_end[];
> +
> +/**
> + * in_exception_text - check if an address is in exception_text or
> + *			irqentry_text
> + * @addr: virtual address to be checked
> + *
> + * Returns: true if the address specified by @addr is in the exception_text or
> + * irqentry_text, false otherwise.
> + */
> +static inline bool in_exception_text(unsigned long addr)
> +{
> +	return memory_contains(__exception_text_start, __exception_text_end,
> +			       (void *)addr, 0) ||
> +		memory_contains(__irqentry_text_start, __irqentry_text_end,
> +				(void *)addr, 0);

Patch looks buggy - where is __irqentry_text_start and __irqentry_text_end
declared?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
