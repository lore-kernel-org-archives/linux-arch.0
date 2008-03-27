From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] ptrace: arch_ptrace cleanup
Date: Thu, 27 Mar 2008 16:14:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803271612360.14670@woody.linux-foundation.org>
References: <20080327230623.969FF26FA1C@magilla.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080327230623.969FF26FA1C-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Thu, 27 Mar 2008, Roland McGrath wrote:
>
> This intends to remove the last bit of entanglement with core ptrace
> implementation details in arch code's arch_ptrace and arch_compat_ptrace.

So I think this has a nicer calling convention, but you never answered the 
question about what the *point* of this all is.

This is _still_ uglier than what we already have, which is to just have 
the code call "[compat_]ptrace_request()" for any cases they don't 
recognize.

I wanted to know if there was some actual technical point to it, and never 
got a reply to that. 

			Linus
