From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 23:01:04 +0100
Message-ID: <11814.1207864864@redhat.com>
References: <1207864537.22001.47.camel@brick> <1207856646.22001.25.camel@brick> <11527.1207863801@redhat.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207864537.22001.47.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > Actually, you probably _ought_ to have casts, but it should look like this:
> > 
> > 	return (u16)p[0] | (u16)p[1] << 8;
> 
> I've been looking at that thinking I needed something different, I
> believe it is ok as u8 will expand to int when shifted... correct?  Or
> do I actually need the cast on each p[] term...anyone?

Hmmm... I think you may be right:

	#include <stdio.h>

	int main()
	{
		unsigned char x;
		printf("%u, %u\n", sizeof(x), sizeof(x << 8));
		return 0;
	}

Says:

	1, 4

In which case, the cast you do have is superfluous, and casting the retrievals
is unnecessary.

David
