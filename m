From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [rfc][patch] x86-64 new smp_call_function design
Date: Sun, 16 Mar 2008 16:33:37 +0200
Message-ID: <47DD2FC1.8040106@qumranet.com>
References: <20080227124217.GA1340@wotan.suse.de> <47C55FD2.8030809@suse.de> <20080227130716.GB1340@wotan.suse.de> <47C5668C.6040906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <47C5668C.6040906-l3A5Bk7waGM@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Andi Kleen wrote:
>
>>>> As far as I understand, calling a subset of online CPUs that is not all or
>>>> one, is used quite infrequently, so this might be OK.
>>>>         
>>> With cpusets and isolation etc. it is the normal case.
>>>       
>> Oh really? Coming from what callers?
>>     
>
> The isolation work is not merged yet, but it will essentially need
> to turn a lot of the _call_function()s into _call_function_mask()
>   

kvm is also a heavy user of smp_call_function_mask(); if you run 
multiple smp guests you'll see plenty of disjoint smp_call_function_mask()s.

-- 
error compiling committee.c: too many arguments to function

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
