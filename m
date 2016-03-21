Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0088.outbound.protection.outlook.com ([157.56.112.88]:30080
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756578AbcCUQUH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Mar 2016 12:20:07 -0400
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321153836.GZ6344@twins.programming.kicks-ass.net>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <56F01773.8030905@mellanox.com>
Date: Mon, 21 Mar 2016 11:46:59 -0400
MIME-Version: 1.0
In-Reply-To: <20160321153836.GZ6344@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160321154659.yfPqyBQIXJH8LY4v2wrjWO80xuSCzBJ4cYELRq5vs9o@z>

On 03/21/2016 11:38 AM, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 01:02:13PM -0400, Chris Metcalf wrote:
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 48958d3cec9e..37afd721ec99 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -887,8 +887,8 @@ static void check_section(const char *modname, struct elf_info *elf,
>>   #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
>>   
>>   #define DATA_SECTIONS ".data", ".data.rel"
>> -#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
>> -		".kprobes.text"
>> +#define TEXT_SECTIONS ".text", ".text.unlikely", \
>> +		".kprobes.text", ".cpuidle.text"
> Where did .sched.text go?

Indeed!  Good catch.  I can't even speculate as to how I managed
to delete the thing on the previous line while adding something
on the following line :-)

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

