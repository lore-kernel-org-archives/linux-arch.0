From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: [patch 00/75] genirq: Overhaul for 2.6.39
Date: Thu, 10 Feb 2011 20:03:20 -0800
Message-ID: <4D54B508.8060106@am.sony.com>
References: <20110210222908.661199947@linutronix.de>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53224 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1BKED1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2011 23:03:27 -0500
In-Reply-To: <20110210222908.661199947@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Linus Torvals <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>

On 02/10/11 15:35, Thomas Gleixner wrote:
> This is a major overhaul of the generic interrupt layer.
> 
>      - Namespace cleanup
> 
>      - Further encapsulation of the core state
> 
>      - Spurious/Poll handling fixes
> 
>      - Stop setaffinity blindly manipulating affinity mask
> 
>      - Cleanups and enhancements all over the place

Hi Thomas,

You seem to have overlooked a patch from me:

Update comments to match code change in 70aedd24
The comments for enable_irq() were updated correctly, but disable_irq_nosync()
and disable_irq() were missed.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

---
 kernel/irq/manage.c |    7 	5 +	2 -	0 !
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/kernel/irq/manage.c
===================================================================
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -353,7 +353,8 @@ void __disable_irq(struct irq_desc *desc
  *	Unlike disable_irq(), this function does not ensure existing
  *	instances of the IRQ handler have completed before returning.
  *
- *	This function may be called from IRQ context.
+ *	This function may be called from IRQ context only when
+ *	desc->chip->bus_lock and desc->chip->bus_sync_unlock are NULL !
  */
 void disable_irq_nosync(unsigned int irq)
 {
@@ -381,7 +382,9 @@ EXPORT_SYMBOL(disable_irq_nosync);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	This function may be called - with care - from IRQ context only when
+ *	desc->chip->bus_lock and desc->chip->bus_sync_unlock are NULL !
+ *	See synchronize_irq() comments for explanation of "with care".
  */
 void disable_irq(unsigned int irq)
 {
