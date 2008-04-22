From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
Date: Tue, 22 Apr 2008 12:50:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804221244350.2779@woody.linux-foundation.org>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804221157220.2779@woody.linux-foundation.org> <20080422191213.GA6370@elte.hu> <alpine.LFD.1.10.0804221218410.2779@woody.linux-foundation.org>
 <20080422192601.GB12588@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422192601.GB12588-X9Un+BFzKDI@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, npiggin-l3A5Bk7waGM@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org



On Tue, 22 Apr 2008, Ingo Molnar wrote:
> 
> ok. In which case the reschedule vector could be consolidated into that 
> as well (it's just a special single-CPU call). Then there would be no 
> new vector allocations needed at all, just the renaming of 
> RESCHEDULE_VECTOR to something more generic.

Yes.

Btw, don't get me wrong - I'm not against multiple vectors per se. I just 
wonder if there is any real reason for the code duplication. 

And there certainly *can* be tons of valid reasons for it. For example, 
some of the LAPIC can only have something like two pending interrupts per 
vector, and after that IPI's would get lost.

However, since the queuing is actually done with the data structures, I 
don't think it matters for the IPI's - they don't need any hardware 
queuing at all, afaik, since even if two IPI's would be merged into one 
(due to lack of hw queueing) the IPI handling code still has its list of 
events, so it doesn't matter.

And performance can be a valid reason ("too expensive to check the shared 
queue if we only have per-cpu events"), although I$ issues can cause that 
argument to go both ways.

I was also wondering whether there are deadlock issues (ie one type of IPI 
has to complete even if a lock is held for the other type). 

So I don't dislike the patch per se, I just wanted to understand _why_ the 
IPI's wanted separate vectors.

		Linus
