From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 22:43:21 +0100
Message-ID: <11527.1207863801@redhat.com>
References: <1207856646.22001.25.camel@brick>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207856646.22001.25.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> +static inline u16 __get_unaligned_le16(const u8 *p)
> +{
> +	return (u16)(p[0] | p[1] << 8);
> +}

You shouldn't need these casts.  return is going to cast it anyway.

Actually, you probably _ought_ to have casts, but it should look like this:

	return (u16)p[0] | (u16)p[1] << 8;

You are shifting an 8-bit value left by 8 bits, so the compiler may be at
liberty to instruct the RHS to end up zero.

I presume the compiler is guaranteed not to merge the two memory accesses?  It
can't seem to make it do so, though I seem to remember there were cases where
it did, though I can't reproduce them.  I assume that's why you're passing in
a u8 pointer and not a u16/u32/u64 pointer.

David
