From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
Date: Thu, 8 Feb 2018 13:58:56 +0000
Message-ID: <20180208135856.GA4360@e107981-ln.cambridge.arm.com>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
 <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
 <c2f09386-90c6-809c-127b-87bd3d80c7ca@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2f09386-90c6-809c-127b-87bd3d80c7ca@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia He <hejianet@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 08, 2018 at 10:37:54AM +0800, Jia He wrote:
> 
> 
> On 2/7/2018 7:41 PM, Lorenzo Pieralisi Wrote:
> >On Tue, Feb 06, 2018 at 08:11:34PM -0800, Jia He wrote:
> >>In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> >>probing"), iort entries was removed in vmlinux.lds.h. But in
> >>commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
> >>this line was back incorrectly.
> >>
> >>It does no harm except for adding some useless symbols, so fix it.
> >>
> >>Signed-off-by: Jia He <hejianet@gmail.com>
> forget to add another Signed-off-by line(because of my company's opensource
> rules)
> 
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> 
> >>---
> >>  include/asm-generic/vmlinux.lds.h | 1 -
> >>  1 file changed, 1 deletion(-)
> >Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >
> >Who is picking this up ?
> Sorry, do you mean who is picking up acpi/iort subsystem?

No, I meant who (as-in me or Daniel) will merge this patch.

I will take it.

Lorenzo

> I can't answer this question. I find this minor bug while doing the code
> review.
> 
> Cheers,
> Jia
> >>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >>index 1ab0e52..58b1dab 100644
> >>--- a/include/asm-generic/vmlinux.lds.h
> >>+++ b/include/asm-generic/vmlinux.lds.h
> >>@@ -589,7 +589,6 @@
> >>  	IRQCHIP_OF_MATCH_TABLE()					\
> >>  	ACPI_PROBE_TABLE(irqchip)					\
> >>  	ACPI_PROBE_TABLE(timer)						\
> >>-	ACPI_PROBE_TABLE(iort)						\
> >>  	EARLYCON_TABLE()
> >>  #define INIT_TEXT							\
> >>-- 
> >>2.7.4
> >>
