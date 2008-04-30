From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function
 calls
Date: Wed, 30 Apr 2008 07:51:50 -0700
Message-ID: <48188786.7020609@goop.org>
References: <1209453990-7735-1-git-send-email-jens.axboe@oracle.com> <1209453990-7735-3-git-send-email-jens.axboe@oracle.com> <481786A5.7010604@goop.org> <20080430113542.GZ12774@kernel.dk> <20080430122001.GS11126@linux.vnet.ibm.com> <20080430123136.GB12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080430123136.GB12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org

Jens Axboe wrote:
> Xen could just stuff that bit into its arch_send_call_function_ipi(),
> something like the below should be fine. My question to Jeremy was more
> of the order of whether it should be kept or not, I guess it's safer to
> just keep it and retain the existing behaviour (and let Jeremy/others
> evaluate it at will later on). Note that I got rid of the yield bool and
> break when we called the hypervisor.
>   

Yes, it's a nice cleanup.

> Jeremy, shall I add this?
>   

Hold off for now.  Given that its effects are unmeasured, I'm not even 
sure its the right thing to do.  For example, it will yield if you're 
sending an IPI to a vcpu which wants to run but can't, but does nothing 
for an idle vcpu.  And always yielding may be a performance problem if 
the IPI doesn't involve any cpu contention.

It's easy to add back if it turns out to be useful.

    J
