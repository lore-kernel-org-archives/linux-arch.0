From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 17:47:38 +0300
Message-ID: <480DFA8A.1050003@qumranet.com>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com>	 <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>	 <480DACDD.7040108@qumranet.com> <20080422092230.GW12774@kernel.dk>	 <20080422111403.GX12774@kernel.dk> <1208869254.7115.258.camel@twins>	 <20080422142543.GG12774@kernel.dk>  <480DF861.6000705@qumranet.com> <1208875437.7115.271.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208875437.7115.271.camel@twins>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

Peter Zijlstra wrote:
>> Perhaps we need a new flag for failable async IPIs (or better, API).  
>> I'm pretty sure no one uses s_c_f_s() from irq disabled context on x86, 
>> since it will WARN_ON(irqs_disabled()).
>>     
>
> Yeah, no current users, but that doesn't say I don't want to add new
> ones ;-

I suggest having a new API for that, I dislike long tails of flag arguments.

smp_call_function_single_async()?

-- 
error compiling committee.c: too many arguments to function
