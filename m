Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268890AbUHUHvi@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:55177 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268886AbUHUHvV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Aug 2004 03:51:21 -0400
Subject: Re: copy_mount_options()
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20040820170712.68e4cda9.akpm@osdl.org>
References: <20040820130110.07f7c23c.davem@redhat.com>
	 <20040820131053.3d5e0f9b.akpm@osdl.org>
	 <20040820141137.646c349f.davem@redhat.com>
	 <20040820143111.3fd0070e.akpm@osdl.org>
	 <20040820144052.14413a4f.davem@redhat.com>
	 <20040820154736.166b66ec.akpm@osdl.org> <20040820231833.GH1945@krispykreme>
	 <20040820165133.67df8d1b.davem@redhat.com>
	 <20040820170712.68e4cda9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1093074189.4883.89.camel@bach>
Mime-Version: 1.0
Date: Sat, 21 Aug 2004 17:50:58 +1000
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, Anton Blanchard <anton@samba.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2004-08-21 at 10:07, Andrew Morton wrote:
> I'm all for it.  I'll sneak the below patch into -mm, see what breaks.

You should zero out the whole buffer in copy_from_user() if you return
-EFAULT.  We had bugs where people didn't check the returns and you
could read random junk.

As to who uses the value, generic file read and write still use it, as
did some of the serial code last I checked.  Linus was of the belief
that they should do a short read/write up to the fault boundary rather
than return -EFAULT.

There's evidence that noone relies on such behaviour, though, since at
the time of the debate, doing such a thing would cause an OOPS on ppc. 
Also, this behaviour silently changed after 2.0 and noone noticed. 
Finally, other unixes are varied in their approaches in this case (some
downright buggy, lying about how much they'd written).

I would humbly suggest an additional option which sent a SEGV to the
process, as well.  If you were playing mprotect games you'd expect them,
and if you weren't, you're probably buggy.  After a while, we can simply
forget about checking returns from copy_to/from_user, which would be a
blissful simplification of kernel code.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell
