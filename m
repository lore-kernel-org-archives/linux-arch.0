Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268798AbUHTX0h@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:10385 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268802AbUHTX0P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 19:26:15 -0400
Subject: Re: copy_mount_options()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040820130110.07f7c23c.davem@redhat.com>
References: <20040820130110.07f7c23c.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1093043745.9529.254.camel@gaston>
Mime-Version: 1.0
Date: Sat, 21 Aug 2004 09:15:46 +1000
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2004-08-21 at 06:01, David S. Miller wrote:
> So the sparc64 user copy bug I fixed recently is pretty
> much present on every platform.
> 
> Basically, copy_mount_options() requires exact byte granularity
> to exception reporting from copy_from_user().  If you don't
> do this it can break things like busybox's mount().

Yup, old problem, reported before several times. Another issue
that pops up with it and busybox is that copy_mount_options will
touch an entire page from the passed pointer. If the pointer you
pass is near the end of your data/bss area, you end up touching
the area between stack and bss, and potentially cause the stack
to grow all the way down to the bss.

We have saveguards against that now on ppc, I suppose x86 has too,
but it may be worth reminding other archs to have a look.

> Even reporting on a word boundary is illegal.  On sparc64
> it was quite poignant because we can report on a 64-byte
> boundary for large copies because that is the granularity
> of the load/store we use.
> 
> Other platforms will need to fix this.  I recommend a two
> stage exception handling scheme.  Basically, on the first
> exception, you merely note that an exception occurred
> and you retry the user copy a byte at a time until you
> hit the exact address that fails.  You cannot optimize
> this to just check a page at a time, because copy_mount_options
> wants all the data to be there.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
