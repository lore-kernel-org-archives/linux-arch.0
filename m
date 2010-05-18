From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 1/3] Reduce get_current() to the asm-generic implementation where possible
Date: Tue, 18 May 2010 20:47:53 +0100
Message-ID: <20100518194753.GA2318@shareable.org>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:53702 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758094Ab0ERTry (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2010 15:47:54 -0400
Content-Disposition: inline
In-Reply-To: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: oleg@redhat.com, linux-arch@vger.kernel.org

David Howells wrote:
> Reduce get_current() to the asm-generic implementation where
> possible to remove duplicate cases.
> 
> Note that this will lose the const attribute on get_current() for ARM and
> MN10300.  This will be added back in a later patch for all architectures.
[...]
> -static inline struct task_struct *get_current(void) __attribute_const__;
> -
> -static inline struct task_struct *get_current(void)
> -{
> -	return current_thread_info()->task;
> -}


Last time I looked, GCC didn't seem to do anything useful with the
const attribute on inline functions.  I.e. no elimination of duplicate calls.

(It does eliminate them when out-of-line.)

So there is probably no point putting the const attribute back, unless
GCC has changed at this.

It might be able to eliminate some duplicates if the asm inside
current_thread_info() is consty enough, and duplicate ->task
dereferences might be eliminated by strict-aliasing in some cases.

-- Jamie
