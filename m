From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 21/44] metag: Time keeping
Date: Mon, 28 Jan 2013 12:59:10 +0000
Message-ID: <5106761E.5070001@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-22-git-send-email-james.hogan@imgtec.com> <201301260003.43854.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:9551 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab3A1M7U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jan 2013 07:59:20 -0500
In-Reply-To: <201301260003.43854.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 26/01/13 00:03, Arnd Bergmann wrote:
> On Thursday 10 January 2013, James Hogan wrote:
>> Add time keeping code for metag. Meta hardware threads have 2 timers.
>> The background timer (TXTIMER) is used as a free-running time base, and
>> the interrupt timer (TXTIMERI) is used for the timer interrupt. Both
>> counters traditionally count at approximately 1MHz.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>  arch/metag/include/asm/clock.h     |   51 +++++++++++
>>  arch/metag/include/asm/delay.h     |   29 +++++++
>>  arch/metag/include/asm/mach/arch.h |    4 +
>>  arch/metag/kernel/clock.c          |   53 ++++++++++++
>>  arch/metag/kernel/time.c           |  163 ++++++++++++++++++++++++++++++++++++
> 
> We are actually moving clocksource drivers to drivers/clocksource
> now, maybe you can move this one too.

Yes, will do.

Thanks
James
