From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Policy for interrupts detected whilst disable_irq() in force
Date: Wed, 19 Mar 2008 12:11:03 +0000
Message-ID: <29183.1205928663@redhat.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


What's the policy for interrupts that are detected by the interrupt controller
on a channel that has disable_irq() in force?  Should the device driver expect
the interrupts to be lost?  Or can it expect that they'll be remembered and
that the CPU will process them when the IRQ channel is enabled?

Furthermore, what about an interrupt that is already pending when
disable_irq() is called?  Is it okay for that to be discarded?  Or must that
be processed upon enable_irq()?

MEI queried me about mn10300_cpupic_disable() in the MN10300 arch.  It clears
the channel enable bit and also clears the request and detect bits, thus losing
any pending interrupt.  Possibly I should introduce a separate shutdown()
method that discards any pending interrupt and modify disable() to merely clear
the enablement flag.

I would guess, however, that some hardware may not remember interrupts that
come in on disabled channels, in which case the driver cannot assume that
interrupts won't be lost.

Any thoughts?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
