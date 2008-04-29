From: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
Date: Tue, 29 Apr 2008 12:46:08 +1000
Message-ID: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
	<20080428144332.GA17109@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080428144332.GA17109-jcswGhMUV9g@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Christoph Hellwig writes:

> Am I missing something here or does this add a branch for every normal
> syscall?

It does, but the impact is so small as to be unmeasurable with
lmbench, even on the null syscall measurement.  The overhead of the
easily-predicted not-taken branch is completely swamped by the amount
of time that the sc and rfid instructions take.  I had it under a
config option at one point but then decided not to bother with that
when I couldn't measure any difference.

Paul.
