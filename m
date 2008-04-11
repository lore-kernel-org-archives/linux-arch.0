From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 10:31:39 -0700
Message-ID: <1207935099.22001.94.camel@brick>
References: <1207927166.22001.91.camel@brick>
	 <1207885132.22001.85.camel@brick> <15208.1207908688@redhat.com>
	 <2225.1207929050@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2225.1207929050-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Fri, 2008-04-11 at 16:50 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > Consistency with every other arch..no other reason.
> 
> But not M68K(NOMMU), Alpha, Blackfin, Cris, H8300, MN10300, ..., but generally
> consistent with the other FRV headers (some other people have added differ).
> 
> Hmmm...  It looks like MIPS is weird.  That says __ASM_GENERIC_UNALIGNED_H,
> which is probably wrong.
> 
> David

Well, now's the time to decide on something as I'm changing every arch.

What is the general pattern used for this kind of thing?  Or am I just
asking what color to paint this bikeshed?

Harvey
