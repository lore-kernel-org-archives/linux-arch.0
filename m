From: Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] kernel: add common infrastructure for unaligned
	access
Date: Sat, 12 Apr 2008 00:22:38 +0400
Message-ID: <20080411202238.GB9108@cvg>
References: <1207885137.22001.86.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1207885137.22001.86.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

[Harvey Harrison - Thu, Apr 10, 2008 at 08:38:57PM -0700]
[...]
| +
| +static inline void __put_unaligned_be16(u16 val, u8 *p)
| +{
| +	*p++ = val >> 8;
| +	*p++ = val;
| +}
| +
[...]
| +static inline void __put_unaligned_le16(u16 val, u8 *p)
| +{
| +	*p++ = val;
| +	*p++ = val >> 8;
| +}
[...]

Hi Harvey, do we really need second increments? I mean, wouldn't
be better to use *p = val >> 8 and *p << 8?

		- Cyrill -
