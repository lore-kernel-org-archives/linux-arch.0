Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:12038 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfHTK6w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 06:58:52 -0400
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
Date: Tue, 20 Aug 2019 12:58:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190820100638.GK2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190820105849.YeyIoRNRX9dE6ZDrU3aggGyWwhhZJAW4EiaixK3a5t0@z>



Le 20/08/2019 à 12:06, Peter Zijlstra a écrit :
> On Mon, Aug 19, 2019 at 04:41:11PM -0700, Kees Cook wrote:
> 
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index 588dd59a5b72..da471fcc5487 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -10,6 +10,7 @@
>>   #define BUGFLAG_WARNING		(1 << 0)
>>   #define BUGFLAG_ONCE		(1 << 1)
>>   #define BUGFLAG_DONE		(1 << 2)
>> +#define BUGFLAG_PRINTK		(1 << 3)
>>   #define BUGFLAG_TAINT(taint)	((taint) << 8)
>>   #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
>>   #endif
> 
>> diff --git a/lib/bug.c b/lib/bug.c
>> index 1077366f496b..6c22e8a6f9de 100644
>> --- a/lib/bug.c
>> +++ b/lib/bug.c
>> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * BUG() and WARN_ON() families don't print a custom debug message
>> +	 * before triggering the exception handler, so we must add the
>> +	 * "cut here" line now. WARN() issues its own "cut here" before the
>> +	 * extra debugging message it writes before triggering the handler.
>> +	 */
>> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
>> +		printk(KERN_DEFAULT CUT_HERE);
> 
> I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> sense to me.
> 

Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
using the generic macros will have to add the flag to get the "cut here" 
line.

Christophe
