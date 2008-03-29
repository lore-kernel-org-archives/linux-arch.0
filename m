From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Fri, 28 Mar 2008 17:53:16 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
References: <20080329001230.D013726FA1D@magilla.localdomain> <20080329001341.7F93826FA1D@magilla.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080329001341.7F93826FA1D-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Fri, 28 Mar 2008, Roland McGrath wrote:
>
> Set TIF_SIGPENDING in set_restore_sigmask.  This lets arch code take
> TIF_RESTORE_SIGMASK out of the set of bits that will be noticed on
> return to user mode.  On some machines those bits are scarce, and we
> can free this unneeded one up for other uses.

Hmm. That probably means that TIF_RESTORE_SIGMASK shouldn't be a "TIF" 
flag at all, but a "TS" ("thread status") flag.

The TS flags are faster, because they are thread-synchronous and do not 
need atomic accesses (ie they are purely thread-local in setting, testing 
and clearing).

Of course, it may well not be worth it. Unlike the TIF flags, the TS flags 
have been architecture-specific and I don't think all architectures even 
do them (x86 uses them for FP state bits and stuff like that).

I guess TIF_RESTORE_SIGMASK is never *so* performance-critical that we'd 
care about the difference between a single cycle (approx) for a non-atomic 
"or" into memory and an atomic bitop (~50 cycles or so). 

			Linus
