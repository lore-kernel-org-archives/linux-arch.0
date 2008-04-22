From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 08:01:22 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804220759020.2779@woody.linux-foundation.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org> <20080422145105.GJ12774@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764994AbYDVPCa@vger.kernel.org>
In-Reply-To: <20080422145105.GJ12774@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de
List-Id: linux-arch.vger.kernel.org



On Tue, 22 Apr 2008, Jens Axboe wrote:
> > 
> > You forgot to free the "data" here? The waiter must also free the object, 
> > since now the callee does not.
> 
> The ipi interrupt handler does that, see kfree() in
> generic_smp_call_function_single_interrupt() or call_func_data_free() in
> generic_smp_call_function_interrupt().

Hell no, it does *not*.

Doing that for the waiting case would be a *huge* bug, since the waiter 
needs to wait until the flag is clear - and if the waitee free's the 
allocation, that will never happen.

So the rule *must* be:
 - waiter frees
 - ipi interrupt frees non-waiting ones.
because anything else cannot work.

And you must have known that, because the code you pointed me to does 
*not* free the data at all. It just clears the FLAG_WAIT flag:

	+               if (data->csd.flags & CSD_FLAG_WAIT) {
	+                       smp_wmb();
	+                       data->csd.flags &= ~CSD_FLAG_WAIT;
	+               } else
	+                       call_func_data_free(data);

So please think about this some more. 

		Linus
