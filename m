Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 01:26:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109092647.GJ29402@holomorphy.com>
References: <20051108191057.09f57114.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108191057.09f57114.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 08, 2005 at 07:10:57PM -0800, Andrew Morton wrote:
> Is everyone OK with this?
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Some ARM platforms have the ability to program the interrupt controller to
> detect various interrupt edges and/or levels.  For some platforms, this is
> critical to setup correctly, particularly those which the setting is
> dependent on the device.
> Currently, ARM drivers do (eg) the following:
> 	err = request_irq(irq, ...);
> 	set_irq_type(irq, IRQT_RISING);
> However, if the interrupt has previously been programmed to be level
> sensitive (for whatever reason) then this will cause an interrupt storm.
> Hence, if we combine set_irq_type() with request_irq(), we can then safely
> set the type prior to unmasking the interrupt.  The unfortunate problem is
> that in order to support this, these flags need to be visible outside of
> the ARM architecture - drivers such as smc91x need these flags and they're
> cross-architecture.
> Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect the
> property that the device would like.  The IRQ controller code should do its
> best to select the most appropriate supported mode.

This seems innocuous enough to me. I anticipate that this will have no
impact on sparc32.


-- wli
