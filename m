From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCHv4 1/2] kernel: add common infrastructure for unaligned
 access
Date: Mon, 14 Apr 2008 15:14:17 -0700
Message-ID: <20080414151417.f8ab4365.akpm@linux-foundation.org>
References: <1208195406.5721.47.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208195406.5721.47.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org

On Mon, 14 Apr 2008 10:50:06 -0700
Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Create a linux/unaligned folder similar in spirit to the linux/byteorder
> folder to hold generic implementations collected from various arches.

ooh, there's a cultural faux pas.  I changed it to "directory" ;)

> [Andrew: I think we're getting close to something that could go into -mm]

I queued them up, thanks.
