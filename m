From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
	calls
Date: Tue, 22 Apr 2008 21:26:01 +0200
Message-ID: <20080422192601.GB12588@elte.hu>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804221157220.2779@woody.linux-foundation.org> <20080422191213.GA6370@elte.hu> <alpine.LFD.1.10.0804221218410.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763879AbYDVT0m@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804221218410.2779@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, npiggin@suse.de, peterz@infradead.org, sam@ravnborg.org
List-Id: linux-arch.vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > yes and i gave in - Nick and Jens wants to do some crazy stuff and 
> > they had the numbers. Here's the previous discussion:
> > 
> >   http://lkml.org/lkml/2008/2/27/125
> 
> No, the previous discussion was about single *queues* vs single 
> *vectors*.
> 
> I agree unconditionally with the decision to use a separate per-cpu 
> queue from the shared queue (in fact, I would argue that the "mask" 
> code might want to notice when the mask is just a single CPU, and turn 
> a mask request into a targeted request).
> 
> But I wonder why we want to then have two IPI target vectors, when it 
> would appear to be perfectly fine and cheap to have just a single 
> vector that can handle both the per-cpu case and the shared queue case 
> (since the thing would tend to be one or the other, not both).
> 
> A single vector is still pefectly fine, if 99% of all usage cases are 
> the targeted-to-a-single-cpu thing, because the shared queue will 
> basically be empty (and you can test that without even taking any 
> locks).

ok. In which case the reschedule vector could be consolidated into that 
as well (it's just a special single-CPU call). Then there would be no 
new vector allocations needed at all, just the renaming of 
RESCHEDULE_VECTOR to something more generic.

	Ingo
