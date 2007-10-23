Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:62756 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbXJWB3X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 21:29:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: USB HCD: avoid duplicate local_irq_disable()
Date: Tue, 23 Oct 2007 03:28:31 +0200
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <alpine.LFD.0.9999.0710222344580.3167@localhost.localdomain> <200710230306.51606.arnd@arndb.de>
In-Reply-To: <200710230306.51606.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710230328.33915.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: gregkh@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, matthew@wil.cx, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-usb-devel@lists.sourceforge.net
List-ID: <linux-arch.vger.kernel.org>

usb_hcd_flush_endpoint() has a retry loop that starts with a spin_lock_irq(),
but only gives up the spinlock, not the irq_disable before jumping to the
rescan label.

Split the spin_lock_irq into the retryable part and the local_irq_disable()
that is only done once as a micro-optimization and slight cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

On Tuesday 23 October 2007, I wrote:
> I tried the trivial annotation below and (with lockdep enabled) got a few
> warnings at boot time, but only one that I could still find in the log
> buffer:

One more such example that was not found by lockdep. I guess this counts
as a false positive, as it is clearly harmless, but working around
it is a small optimization for the case where local_irq_disable()
is a hypervisor call.

Should we try to fix this class of (non-)problem in other places?
Will this patch cause a different warning with lockdep since now we
are pairing spin_lock() with spin_unlock_irq()?

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1312,8 +1312,9 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
 	hcd = bus_to_hcd(udev->bus);
 
 	/* No more submits can occur */
+	local_irq_disable();
 rescan:
-	spin_lock_irq(&hcd_urb_list_lock);
+	spin_lock(&hcd_urb_list_lock);
 	list_for_each_entry (urb, &ep->urb_list, urb_list) {
 		int	is_in;
 
