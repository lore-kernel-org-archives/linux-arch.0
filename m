From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/11] powerpc: convert to generic helpers for IPI function calls
Date: Tue, 22 Apr 2008 20:51:12 +0200
Message-ID: <20080422185111.GS12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-4-git-send-email-jens.axboe@oracle.com> <18445.54284.194023.553595@cargo.ozlabs.ibm.com> <20080422121315.GE12774@kernel.dk> <18445.56653.957832.720681@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <18445.56653.957832.720681-UYQwCShxghk5kJ7NmlRacFaTQe2KTcn/@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org

On Tue, Apr 22 2008, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > I touched on both of these points in the initial mail, but perhaps you
> > missed it as I didn't CC everyone for the 0/11 part. I'll add the full
> > explanation to the 1/11 patch as well.
> 
> OK, that would be fine.  I didn't read right to the end of the 0/11
> mail in detail, I admit. :)

I don't blame you :-)

> Now that I have, I don't see anything about smp_send_stop trying to
> get the interrupt sent off in a panic situation when some other cpu
> might be stuck holding the lock (unless that's the "ipi_lock is a
> little muddy" part, but that only talks about cpu onlining).  That bit
> looks to be powerpc-specific, added in commit e057d985 in December
> 2007, so perhaps a mention that that has gone away now in the
> description for 3/11 would be good.

Oh that, yes I'll add a description. I didn't really think there was
much need for it anymore, but it should at least be documented. The
ipi_lock stuff was really more about stopping IPIs completely, not the
smp_send_stop() panic() you described.

-- 
Jens Axboe
