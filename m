Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266670AbUHVLuo@vger.kernel.org>
Received: from p508B7531.dip.t-dialin.net ([80.139.117.49]:44838 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S266669AbUHVLuo
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 22 Aug 2004 07:50:44 -0400
Date: Sun, 22 Aug 2004 13:50:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: copy_mount_options()
Message-ID: <20040822115014.GA29005@linux-mips.org>
References: <20040820130110.07f7c23c.davem@redhat.com> <1093043745.9529.254.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093043745.9529.254.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, Aug 21, 2004 at 09:15:46AM +1000, Benjamin Herrenschmidt wrote:

> > Basically, copy_mount_options() requires exact byte granularity
> > to exception reporting from copy_from_user().  If you don't
> > do this it can break things like busybox's mount().
> 
> Yup, old problem, reported before several times. Another issue
> that pops up with it and busybox is that copy_mount_options will
> touch an entire page from the passed pointer. If the pointer you
> pass is near the end of your data/bss area, you end up touching
> the area between stack and bss, and potentially cause the stack
> to grow all the way down to the bss.

On MIPS it's been triggering a special case in verify_area which make
it return -EFAULT if the arguments area includes the last byte of the
2GB userspace as busybox does.  A proper fix of verify_area would have
inflated the verify_area() code by one instruction so I reduced
TASK_SIZE a bit ...

  Ralf
