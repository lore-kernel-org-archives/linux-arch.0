From: Jacek Luczak <difrost.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
  calls
Date: Tue, 22 Apr 2008 11:04:52 +0200
Message-ID: <480DAA34.7010709@gmail.com>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422084738.GB2388@elte.hu> <480DA670.4060707@gmail.com> <20080422085629.GV12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422085629.GV12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>

Jens Axboe pisze:
> On Tue, Apr 22 2008, Jacek Luczak wrote:
>> Ingo Molnar pisze:
>>> * Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>>>
>>>> This converts x86 and x86-64 to use the new helpers for 
>>>> smp_call_function() and friends, and adds support for 
>>>> smp_call_function_single().
>>> nice stuff. The x86 and generic bits:
>>>
>>>  Acked-by: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
>>>
>>> this has been brewing for months, what is the testing/confidence status 
>> A'propos testing: Jens did you placed all patches (latest versions)
>> somewhere on net, so I can grab it and test?
> 
> It's in git as well, generic-ipi branch. So you can pull it into current
> linus by doing:
> 
> $ git pull git://git.kernel.dk/linux-2.6-block.git generic-ipi

OK, thanks. I've got number of unused x86 boxes, so I will give it a spin.

Jacek
