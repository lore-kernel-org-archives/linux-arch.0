From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Tue, 20 Nov 2012 16:15:30 +0000
Message-ID: <201211201615.30481.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091412.58733.arnd@arndb.de> <50ABAAE8.6070108@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60714 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2KTQPc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2012 11:15:32 -0500
In-Reply-To: <50ABAAE8.6070108@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Tuesday 20 November 2012, James Hogan wrote:
> On 09/11/12 14:12, Arnd Bergmann wrote:
> > On Wednesday 31 October 2012, James Hogan wrote:
> > 
> >> diff --git a/arch/metag/include/asm/irq.h b/arch/metag/include/asm/irq.h
> >> new file mode 100644
> >> index 0000000..da24886
> >> --- /dev/null
> >> +++ b/arch/metag/include/asm/irq.h
> >> +#ifndef HW_IRQS
> >> +#define HW_IRQS  (HWSTATMETA_OFFSET_MAX + HWSTATEXT_OFFSET_MAX + \
> >> +		HWSTATEXT2_OFFSET_MAX + HWSTATEXT4_OFFSET_MAX + \
> >> +		HWSTATEXT6_OFFSET_MAX)
> >> +#endif
> >> +
> >> +#define META_IRQS 32
> >> +
> >> +#define NR_IRQS (META_IRQS + HW_IRQS)
> > 
> > I think you should use sparse IRQs right from the start and avoid
> > hardcoding interrupt numbers from the start.
> 
> I presume core irq numbers need hard coding (e.g. those required by core
> code like cross-hardware-thread irqs and perf counters)? Or would the
> recommended way be to have a function which is given the core hw irq
> number and converts/maps a virtual irq for it using the irq domain?

Anything that is probed as a platform device can get the interrupt numbers
using the device resources that are filled in by the device tree probe.

If you need something earlier, you can call irq_of_parse_and_map()
manually.

	Arnd
