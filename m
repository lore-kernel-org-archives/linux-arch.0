From: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 3/11] powerpc: convert to generic helpers for IPI function calls
Date: Tue, 22 Apr 2008 22:42:53 +1000
Message-ID: <18445.56653.957832.720681@cargo.ozlabs.ibm.com>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com>
	<1208851058-8500-4-git-send-email-jens.axboe@oracle.com>
	<18445.54284.194023.553595@cargo.ozlabs.ibm.com>
	<20080422121315.GE12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422121315.GE12774-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org

Jens Axboe writes:

> I touched on both of these points in the initial mail, but perhaps you
> missed it as I didn't CC everyone for the 0/11 part. I'll add the full
> explanation to the 1/11 patch as well.

OK, that would be fine.  I didn't read right to the end of the 0/11
mail in detail, I admit. :)

Now that I have, I don't see anything about smp_send_stop trying to
get the interrupt sent off in a panic situation when some other cpu
might be stuck holding the lock (unless that's the "ipi_lock is a
little muddy" part, but that only talks about cpu onlining).  That bit
looks to be powerpc-specific, added in commit e057d985 in December
2007, so perhaps a mention that that has gone away now in the
description for 3/11 would be good.

Regards,
Paul.
