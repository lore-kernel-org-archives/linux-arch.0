From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] ptrace: arch_ptrace cleanup
Date: Thu, 27 Mar 2008 19:59:23 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803271957080.14670@woody.linux-foundation.org>
References: <20080327230623.969FF26FA1C@magilla.localdomain> <alpine.LFD.1.00.0803271612360.14670@woody.linux-foundation.org> <20080328023155.71B6626FA1C@magilla.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328023155.71B6626FA1C-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Thu, 27 Mar 2008, Roland McGrath wrote:
> 
> One of these days I will post substantial core ptrace changes.  I don't
> know what these are yet, but I know it's likely they will need to change
> what's passed between sys_ptrace and ptrace_request/ptrace_resume.  We
> can expect that there will be churn in that code while we hash out how
> it should be.  Doing this arch patch first means that none of that later
> churn will involve changing arch_ptrace back and forth while the
> non-arch code gets settled.

Why would that happen _anyway_?

I'm very much against ugly interfaces that don't seem to fix anything. 
Especially if you don't even know that it's needed. I'm not doing to apply 
something that just makes code uglier before I actually see the thing that 
it helps with. Right now it only hurts.

		Linus
