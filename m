Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfIQKpY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 06:45:24 -0400
Date: Tue, 17 Sep 2019 11:45:19 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [breakage] panic() does not halt arm64 systems under certain
 conditions
Message-ID: <20190917104518.ovg6ivadyst7h76o@willie-the-truck>
References: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BX1W47JXPMR8.58IYW53H6M5N@dragonstone>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Xogium <contact@xogium.me>
Cc: linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk
Message-ID: <20190917104519.qhPTdHSLxj7ocqvP2dsYRYkZ73LDqZ_ElC_UBGCXf4o@z>

Hi,

[Expanding CC list; original message is here:
 https://lore.kernel.org/linux-arm-kernel/BX1W47JXPMR8.58IYW53H6M5N@dragonstone/]

On Mon, Sep 16, 2019 at 09:35:36PM -0400, Xogium wrote:
> On arm64 in some situations userspace will continue running even after a
> panic. This means any userspace watchdog daemon will continue pinging,
> that service managers will keep running and displaying messages in certain
> cases, and that it is possible to enter via ssh in the now unstable system
> and to do almost anything except reboot/power off and etc. If
> CONFIG_PREEMPT=n is set in the kernel's configuration, the issue is fixed.
> I have reproduced the very same behavior with linux 4.19, 5.2 and 5.3. On
> x86/x86_64 the issue does not seem to be present at all.

I've managed to reproduce this under both 32-bit and 64-bit ARM kernels.
The issue is that the infinite loop at the end of panic() can run with
preemption enabled (particularly when invoking by echoing 'c' to
/proc/sysrq-trigger), so we end up rescheduling user tasks. On x86, this
doesn't happen because smp_send_stop() disables the local APIC in
native_stop_other_cpus() and so interrupts are effectively masked while
spinning.

A straightforward fix is to disable preemption explicitly on the panic()
path (diff below), but I've expanded the cc list to see both what others
think, but also in case smp_send_stop() is supposed to have the side-effect
of disabling interrupt delivery for the local CPU.

Will

--->8

diff --git a/kernel/panic.c b/kernel/panic.c
index 057540b6eee9..02d0de31c42d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -179,6 +179,7 @@ void panic(const char *fmt, ...)
	 * after setting panic_cpu) from invoking panic() again.
	 */
	local_irq_disable();
+	preempt_disable_notrace();
 
	/*
	 * It's possible to come here directly from a panic-assertion and
