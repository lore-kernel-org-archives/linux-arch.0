From: David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH 2/23] Make register values available to Alpha panic	notifiers
Date: Wed, 14 Apr 2010 17:10:58 -0400
Message-ID: <4BC62F62.40500@cisco.com>
References: <20100412060613.GA25303@dvomlehn-lnx2.corp.sa.net> <20100412190509.GA17147@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100412190509.GA17147@merkur.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Apr 11, 2010 at 11:06:13PM -0700, David VomLehn wrote:
>   
>> The save_ptregs() function has not been tested or even built. I will need
>> help to complete this.
>>
>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
>> ---
>>  arch/alpha/include/asm/ptrace.h |  124 +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 124 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
>> index 65cf3e2..952d177 100644
>> --- a/arch/alpha/include/asm/ptrace.h
>> +++ b/arch/alpha/include/asm/ptrace.h
>> @@ -79,6 +79,130 @@ extern void show_regs(struct pt_regs *);
>>  
>>  #define force_successful_syscall_return() (task_pt_regs(current)->r0 = 0)
>>  
>> +/* Macros for saving the contents of registers and for the output constraint
>> + * for those registers */
>> +#include "/home/vomlehn/git/kernel.org/linux/ptreg.h"
>>     
> The above include needs fixing.
>
> 	Sam
>   
Definitely, thanks!
