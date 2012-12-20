From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC Patch v1 45/55] ARC: unaligned access emulation
Date: Thu, 20 Dec 2012 12:29:38 +0530
Message-ID: <50D2B75A.3000208@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-15-git-send-email-vgupta@synopsys.com> <201211121400.13046.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:34046 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab2LTHAF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Dec 2012 02:00:05 -0500
In-Reply-To: <201211121400.13046.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Doug Chapman <doug.chapman@hp.com>, Tony <tony.luck@intel.com>, Kyle McMartin <kyle@redhat.com>

On Monday 12 November 2012 07:30 PM, Arnd Bergmann wrote:
> On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
>> +
>> +config ARC_MISALIGN_ACCESS
>> +       bool "Emulate unaligned memory access (userspace only)"
>> +       default N
>> +       help
>> +         This enables misaligned 16 & 32 bit memory access from user space.
>> +         Use ONLY-IF-ABS-NECESSARY as it will be very slow and also can hide
>> +         potential bugs in code
> 
> parisc and ia64 both have the same feature, and they use sysctl to configure
> it at run-time. Maybe you should pick one of the two sysctl implementations
> and hook that up to your implementation as well.

Sounds like a good idea.

Looking at your suggestion, the sysctl interface in both of those is for
slightly different semantics and ARC would possibly need a bit from
both. So to avoid duplication, I'm proposing following changes to
kernel/sysctl.c and the generic options selected by respective arches.

* no_unaligned_warning:CONFIG_IA64 => CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
*unaligned_enabled: __hppa__ => CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW

If you can think of better(smaller) names, please do let me know :-)

If we agree in principle, I'll cookup the patches and seek the ACKs from
ARCH maintainers (assuming my CC list above is right). And to keep
things simple, we can route the kernel/sysctl.c changes via the ARC
submission tree.

Thx,
Vineet
