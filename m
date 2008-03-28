From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ptrace: arch_ptrace cleanup
Date: Thu, 27 Mar 2008 19:31:55 -0700 (PDT)
Message-ID: <20080328023155.71B6626FA1C@magilla.localdomain>
References: <20080327230623.969FF26FA1C@magilla.localdomain>
	<alpine.LFD.1.00.0803271612360.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Linus Torvalds's message of  Thursday, 27 March 2008 16:14:14 -0700 <alpine.LFD.1.00.0803271612360.14670-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> I wanted to know if there was some actual technical point to it, and never 
> got a reply to that. 

I thought I did answer that.  But I will again.  Yes, it's preemptive.
You won't gain anything right now.  That doesn't make it "churn for
churn's sake".  (For Pete's sake, you think I do this for fun?)

One of these days I will post substantial core ptrace changes.  I don't
know what these are yet, but I know it's likely they will need to change
what's passed between sys_ptrace and ptrace_request/ptrace_resume.  We
can expect that there will be churn in that code while we hash out how
it should be.  Doing this arch patch first means that none of that later
churn will involve changing arch_ptrace back and forth while the
non-arch code gets settled.

If this goes in early after 2.6.25, there will be ample opportunity to
hack on and hash out core changes with lots of flux and not worry about
arch conflicts.  Different people's versions can fall in and out of -mm
without juggling arch fixups in each variant, etc.  It's really for the
benefit of those of us who are exchanging lots of patches in this area
before they are ready for you to merge.

In short, it is cleaner if the arch calls only deal with the cases they
know how to handle, including knowing what the control flow or state
shared between pieces of non-arch code might be.  If you don't buy it,
fine.  Take it or don't.  The first time I have new code to submit that
is cleanest if it can break every ptrace_request caller, I'll make the
first patch in that series (maybe identical to this one) take arch_ptrace
out of the call graph for non-arch cases with the comment "so we never
have to break every arch_ptrace for arch-irrelevant changes *again*".


Thanks,
Roland
