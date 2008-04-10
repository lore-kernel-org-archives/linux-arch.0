From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned
	access
Date: Thu, 10 Apr 2008 15:20:46 -0700
Message-ID: <1207866046.22001.53.camel@brick>
References: <1207865183.22001.49.camel@brick>
	 <1207864537.22001.47.camel@brick> <1207856646.22001.25.camel@brick>
	 <11527.1207863801@redhat.com> <11814.1207864864@redhat.com>
	 <11907.1207865758@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11907.1207865758-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2008-04-10 at 23:15 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > Expands to int, not unsigned int, I think that cast is still needed?
> 
> What for?  The return is going to do the same cast anyway because of the
> function return type.
> 
> David

Well, for the u16 case, won't the compiler warn about truncating the
return if I return an int when the function returns u16?

In the u64 case, I need the cast to ensure it expands to u64 rather than
int from the shift.  Agreed in the u32 case, but then it looks different
than the u16/u64 case (cargo-cult I know, but nice for consistency).

Harvey
