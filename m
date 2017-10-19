From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: Re: [PATCH 3/4][PoC][RFC] Connect rlimit-events with process life
 cycle
Date: Thu, 19 Oct 2017 20:19:16 +0200
Message-ID: <d3e172e9-1382-f790-2c16-15e43458a635@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203337epcas2p22bc3a5ac063486c9c7906fe6e88277bb@epcas2p2.samsung.com>
        <20171018203230.29871-4-k.opasiak@samsung.com>
        <20171019074141.GE20787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38871 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdJSSTY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2017 14:19:24 -0400
In-reply-to: <20171019074141.GE20787@kroah.com>
Content-language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com



On 10/19/2017 09:41 AM, Greg KH wrote:
> On Wed, Oct 18, 2017 at 10:32:29PM +0200, Krzysztof Opasiak wrote:
>> Add rlimit-events call to process lifecycle to ensure that
>> we get notified whenever process dies (to cleanup our watch
>> levels) or forks (to implement watch levels inheritance).
>>
>> Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
>> ---
>>   kernel/exit.c |  4 ++++
>>   kernel/fork.c | 16 +++++++++++++++-
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 516acdb0e0ec..c7e435ac4428 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -62,6 +62,7 @@
>>   #include <linux/kcov.h>
>>   #include <linux/random.h>
>>   #include <linux/rcuwait.h>
>> +#include <linux/rlimit_noti.h>
>>   
>>   #include <linux/uaccess.h>
>>   #include <asm/unistd.h>
>> @@ -858,6 +859,9 @@ void __noreturn do_exit(long code)
>>   	if (group_dead)
>>   		tty_audit_exit();
>>   	audit_free(tsk);
>> +#ifdef CONFIG_RLIMIT_NOTIFICATION
>> +	rlimit_noti_task_exit(tsk);
>> +#endif
> 
> #ifdef should not be needed in a .c file :(
> 

Yeah, I should have dropped them as it's solved in header by defining 
this function as empty when rlimit-events are disabled.

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
