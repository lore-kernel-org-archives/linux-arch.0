From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 03:16:42 -0700 (PDT)
Message-ID: <20080411.031642.193716019.davem@davemloft.net>
References: <1207885132.22001.85.camel@brick>
	<15208.1207908688@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <15208.1207908688-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Fri, 11 Apr 2008 11:11:28 +0100

> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > - * impractical.  So, now we fall back to using memcpy.
> > + * impractical.  So, now we fall back to using memmov.
> 
> That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
> overlap with *ptr?

No, I think it has something to do with what cases GCC is allowed to
optimize the call inline and what cases it cannot wrt.  alignment of
datums.
