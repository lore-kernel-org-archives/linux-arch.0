Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31239 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262254AbUC1UsX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 15:48:23 -0500
Date: Sun, 28 Mar 2004 21:48:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Future of linux-arch
Message-ID: <20040328214819.F10358@flint.arm.linux.org.uk>
References: <20040328120133.D2825@flint.arm.linux.org.uk> <20040328122920.404e5b37.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328122920.404e5b37.davem@redhat.com>; from davem@redhat.com on Sun, Mar 28, 2004 at 12:29:20PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 28, 2004 at 12:29:20PM -0800, David S. Miller wrote:
> See, because this patch goes beyond arch issues, driver folks have to use
> these interfaces, so logically it appears that folks outside of the arch
> community should contribute to the design and review of said interfaces.

So this is the thanks for taking hold of an issue which someone else
raised and trying to get it sorted.  Fine.

But that's no good if we can't even present what we think is a good
interface from the architecture side.  Which it appears we still
can't.

Remember that it was Andrea who raised it on lkml and it moved to
to linux-arch because all the architecture people needed to be
involved?

Well, I'm sick to death with this issue.  Someone else can sort out
this problem.  I'm going to just do what's necessary to sort it on
ARM and leave it at that.  If that screws someone else, tough shit.
I've made the effort and done my best to find a reasonable solution.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
