From: David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH 6/23] Make register values available to CRIS panic	notifiers
Date: Wed, 14 Apr 2010 17:13:05 -0400
Message-ID: <4BC62FE1.2020703@cisco.com>
References: <20100412060625.GA25426@dvomlehn-lnx2.corp.sa.net> <20100412190840.GB17147@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:19012 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0DNVNM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2010 17:13:12 -0400
In-Reply-To: <20100412190840.GB17147@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Apr 11, 2010 at 11:06:25PM -0700, David VomLehn wrote:
>   
>> The save_ptregs() function has not been tested or even built. I will need
>> help to complete this.
>>
>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
>> ---
>>  arch/cris/include/arch-v10/arch/ptrace.h |   80 ++++++++++++++++++++++++++++
>>  arch/cris/include/arch-v32/arch/ptrace.h |   84 ++++++++++++++++++++++++++++++
>>  2 files changed, 164 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/cris/include/arch-v10/arch/ptrace.h b/arch/cris/include/arch-v10/arch/ptrace.h
>> index 2f464ea..28be57c 100644
>> --- a/arch/cris/include/arch-v10/arch/ptrace.h
>> +++ b/arch/cris/include/arch-v10/arch/ptrace.h
>> @@ -114,6 +114,86 @@ struct switch_stack {
>>  #define profile_pc(regs) instruction_pointer(regs)
>>  extern void show_regs(struct pt_regs *);
>>  
>> +/* Macros for saving the contents of registers and for the output constraint
>> + * for those registers */
>> +#include "/home/vomlehn/git/kernel.org/ptreg.h"
>>     
>
> The above include needs fixing.
> I did not look at the rest of your patches - they may suffer the same.
>
> PS: Your To: is seriously broken, I have to hand-edit Cc:s to send the mail
>   
Yes;, and I apologize for this. I've got to track down the reason for 
this. before send more
patches.
> 	Sam
>   
