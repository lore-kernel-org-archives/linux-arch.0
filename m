From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
Date: Sat, 26 Apr 2008 01:59:55 -0700
Message-ID: <4812EF0B.4060109@goop.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422084738.GB2388@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422084738.GB2388-X9Un+BFzKDI@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>

Ingo Molnar wrote:
> * Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>
>   
>> This converts x86 and x86-64 to use the new helpers for 
>> smp_call_function() and friends, and adds support for 
>> smp_call_function_single().
>>     
>
> nice stuff. The x86 and generic bits:
>
>  Acked-by: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
>
> this has been brewing for months, what is the testing/confidence status 
> of it? Could we still merge it into v2.6.26? (i think we should)
>   

I commented on an earlier version of this patch, but it looks like it 
will break Xen.  If you enable CONFIG_XEN, it will try to define both 
native and Xen versions of arch_send_call_function[_single]_ipi().  It 
needs to vector them via smp_ops.

    J
