Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268719AbUHTUMr@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:45486 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268692AbUHTUMr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 16:12:47 -0400
Date: Fri, 20 Aug 2004 13:10:53 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: copy_mount_options()
Message-Id: <20040820131053.3d5e0f9b.akpm@osdl.org>
In-Reply-To: <20040820130110.07f7c23c.davem@redhat.com>
References: <20040820130110.07f7c23c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> 
> So the sparc64 user copy bug I fixed recently is pretty
> much present on every platform.
> 
> Basically, copy_mount_options() requires exact byte granularity
> to exception reporting from copy_from_user().  If you don't
> do this it can break things like busybox's mount().
> 
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

For some reason, copy_mount_options() is a continual pain in the ass.  It
just comes up again and again.

For this problem I'd suggest we just rip the copy_from_user() out of there
and rewrite the function to use byte-at-a-time get_user()s.
