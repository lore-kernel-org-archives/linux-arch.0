From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
Date: Tue, 29 Apr 2008 20:46:23 +0200
Message-ID: <20080429184623.GA23654@lst.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com> <20080429184047.47CB7247B4@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080429184047.47CB7247B4-C2Gvrrd9BC/j/ljBK/0BTg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On Tue, Apr 29, 2008 at 08:40:47PM +0200, Wolfgang Denk wrote:
> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

You got a 64bit kernel to run on a MPC850? wow :)

Not sure what the slowest supported 64bit cpu is (RS64-II?), but Paul
might be right and in this case it really doesn't matter.
