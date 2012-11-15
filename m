Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:35243 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993178Ab2KOKXT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 05:23:19 -0500
Message-ID: <50A4C273.10102@synopsys.com>
Date: Thu, 15 Nov 2012 15:52:43 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [RFC Patch v1 32/55] ARC: [optim] Cache "current" in Register
 r25
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-2-git-send-email-vgupta@synopsys.com> <201211121350.12810.arnd@arndb.de>
In-Reply-To: <201211121350.12810.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Message-ID: <20121115102243.e40B55hgbGO0fN2UvSFXuWDinCUkh_hSfqjtxGgMU5I@z>

On Monday 12 November 2012 07:20 PM, Arnd Bergmann wrote:
> On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
>>  endmenu # "Platform Board Configuration"
>>  
>> +config ARC_CURR_IN_REG
>> +       bool "Dedicate Register r25 for current_task pointer"
>> +       default y
>> +       help
>> +         This reserved Register R25 to point to Current Task in
>> +         kernel mode. This saves memory access for each such access
>> +
> This looks like a useful feature if you have 32 GPRs, but why make it
> optional? Are there cases where you would disable it?

Since it touched the low level guts of port, it made sense to start with
a config option in initial implementation. But I've kept it that way
since it annotates the code nicely and implicitly documents how to do
this for any other register + data structure.

> Another alternative to caching "current" would be to cache the per-cpu
> offset, and calculate current from that one.

Good tip - I'll add this to my TODO list -

> 	Arnd

