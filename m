From: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Sat, 26 Apr 2008 09:13:56 -0500
Message-ID: <1209219236.3113.6.camel@localhost.localdomain>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com>
	 <1208890227-24808-2-git-send-email-jens.axboe@oracle.com>
	 <20080425231100.b93a1601.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080425231100.b93a1601.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, "Paul E. McKenney" <paulmck-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On Fri, 2008-04-25 at 23:11 -0700, Andrew Morton wrote:
> Also, init_call_single_data() is __cpuinit but isn't declared that way. 
> There have been rare occasions (FRV was one) where this matters - iirc the
> compiler was emitting a short-relative-addressing-form instruction which
> which wasn't able to branch far enough once things were linked.  We hae
> this problem in eight zillion other places, of course.  And it's a pita to
> go adding __cpunit etc to the declaration because the compiler usually
> won't tell us when it gets out of sync with reality.  So we could leave he
> code as-is and wait for stuff to break :(

Erm, that's a bug in the frv toolchain, isn't it?  The linker should
*never* rely on C code annotation for jump lengths ... mainly because
you can screw it all up again in the linker script, so the sectional
annotations should only be in the function body (think
-ffunction-sections)

We have exactly this problem on parisc: our standard relocation jumps
are only 17 bits (on ILP32). The linker actually lays down special
sandwich sections between individual functions (places where we jump to
as a 17 bit relative and then do another absolute jump via a pointer).
The sandwich sections should be added at final link time every place the
linker sees the relative jump is out of range.

James
