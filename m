From: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
Date: Wed, 30 Apr 2008 07:16:34 +1000
Message-ID: <18455.36914.506429.279177@cargo.ozlabs.ibm.com>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
	<20080429184047.47CB7247B4@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080429184047.47CB7247B4-C2Gvrrd9BC/j/ljBK/0BTg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Wolfgang Denk writes:

> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

The patch only affects arch/powerpc/kernel/entry_64.S.  So no, I
didn't measure it on a 50MHz MPC850, or indeed any 32-bit system. :)

Paul.
