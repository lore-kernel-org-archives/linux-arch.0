Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:34736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfHZT6G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:06 -0400
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
 <20190826153236.GA9591@infradead.org>
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
Date: Mon, 26 Aug 2019 20:58:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190826153236.GA9591@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190826195801.lrFBZZSfOEmo9lLIwI_LEfNNuGwC3mWsgUyrkz5OWH0@z>

Hi

On 8/26/19 4:32 PM, Christoph Hellwig wrote:
>> +config ARCH_USE_COMMON_SMP_STOP
>> +	def_bool y if SMP
> 
> The option belongs into common code and the arch code shoud only
> select it.
>

In fact that was my first approach, but then I noticed that in kernel/ topdir
there was no generic Kconfig but only subsystem specific ones:

Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt

while instead looking into archs top level Kconfig, beside the usual arch/Kconfig selects,
I could find this similar sort of "reversed" approach in which the arch defined and
selected a CONFIG which was indeed then used only in common code like in:

20:37 $ egrep -R ARCH_HAS_CACHE_LINE_SIZE .
./arch/arc/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./arch/x86/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./arch/arm64/Kconfig:config ARCH_HAS_CACHE_LINE_SIZE
./include/linux/cache.h:#ifndef CONFIG_ARCH_HAS_CACHE_LINE_SIZE

20:39 $ egrep -R ARCH_HAS_KEXEC_PURGATORY .
./arch/powerpc/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/x86/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/s390/Kconfig:config ARCH_HAS_KEXEC_PURGATORY
./arch/s390/purgatory/Makefile:obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
./arch/s390/Kbuild:obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
./kernel/kexec_file.c:	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))

so I thought it was an acceptable option and I went for it, not to introduce a new kernel/Kconfig.smp
just for this new config option; but in fact I could have missed the real reason underlying these two
different choices.

Thanks

Cristian
