Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268724AbUHTXwG@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:13969 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268720AbUHTXwG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 19:52:06 -0400
Date: Fri, 20 Aug 2004 16:51:33 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_mount_options()
Message-Id: <20040820165133.67df8d1b.davem@redhat.com>
In-Reply-To: <20040820231833.GH1945@krispykreme>
References: <20040820130110.07f7c23c.davem@redhat.com>
	<20040820131053.3d5e0f9b.akpm@osdl.org>
	<20040820141137.646c349f.davem@redhat.com>
	<20040820143111.3fd0070e.akpm@osdl.org>
	<20040820144052.14413a4f.davem@redhat.com>
	<20040820154736.166b66ec.akpm@osdl.org>
	<20040820231833.GH1945@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

On Sat, 21 Aug 2004 09:18:33 +1000
Anton Blanchard <anton@samba.org> wrote:

> I too hate that interface, Im continually getting it wrong. It would be
> nice to remove the possibility of having similar such subtle bugs.

I agree.

There used to be clever code that would truncate the pipe write
and stuff like that, and TCP even used to do something similar
at one point.  But I go look now and neither of them do that
any more.

It would even make the kernel smaller because all of these silly:

	return copy_*_user(...) ? -EFAULT : 0;

would just expand to a direct use of the return value.

So many arch user copy routines would have enormous amounts
of complexity removed, and I saw this quite well when doing
the sparc64 stuff I did yesterday.
