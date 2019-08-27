Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfH0OeM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 10:34:12 -0400
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190823115720.605-6-cristian.marussi@arm.com>
 <20190826153236.GA9591@infradead.org>
 <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
 <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <2f1b7e1f-5ba2-37b4-193b-133a93a3f6ea@arm.com>
Date: Tue, 27 Aug 2019 15:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190827143408.8Oxm85j5IrE9Tt2cmmeUTuHXgz-RddrjlGDwJvpX6Ck@z>

Hi

On 26/08/2019 23:26, Thomas Gleixner wrote:
> On Mon, 26 Aug 2019, Cristian Marussi wrote:
>> On 8/26/19 4:32 PM, Christoph Hellwig wrote:
>>>> +config ARCH_USE_COMMON_SMP_STOP
>>>> +	def_bool y if SMP
>>>
>>> The option belongs into common code and the arch code shoud only
>>> select it.
>>>
>>
>> In fact that was my first approach, but then I noticed that in kernel/ topdir
>> there was no generic Kconfig but only subsystem specific ones:
>>
>> Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt
> 
> arch/Kconfig
> 

Ok I'll move it there in v2.

Thanks for the review.

Cristian

> Thanks,
> 
> 	tglx
> 
