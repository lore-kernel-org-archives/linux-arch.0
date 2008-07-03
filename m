From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] relay: Add buffer-only channels; useful for early
 logging.
Date: Wed, 2 Jul 2008 23:06:36 -0700
Message-ID: <20080702230636.66e484bb.akpm@linux-foundation.org>
References: <20080623153104.50549291@linux360.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34037 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755154AbYGCGHG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 02:07:06 -0400
In-Reply-To: <20080623153104.50549291@linux360.ro>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Cc: tzanussi@gmail.com, penberg@cs.helsinki.fi, torvalds@linux-foundation.org, compudj@krystal.dyndns.org, vegard.nossum@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 23 Jun 2008 15:31:04 +0300 Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro> wrote:

> Allows one to create and use a channel with no associated files. Files
> can be initialized later. This is useful in scenarios such as logging
> in early code, before VFS is up. Therefore, such channels can be
> created and used as soon as kmem_cache_init() completed.
> 
> This is needed by kmemtrace to do tracing in early kernel code.

This breaks on sparc64.

> +			err = smp_call_function_single(i,
> +						       __relay_set_buf_dentry,
> +						       &disp, 0, 1);

Because that ain't implemented.

There's a call in net/iucv/iucv.c, but that's s390-only.

There's a call in virt/kvm/kvm_main.c.

There's a call in kernel/time/tick-broadcast.c, so I assume that the
intersection between CONFIG_GENERIC_CLOCKEVENTS_BROADCAST and
non-smp_call_function_single() architectures is presently empty.


I guess all SMP-capable architectures should now implement this,
please.  It is presently defined on all architectures for CONFIG_SMP=n
and it is declared in include/linux/smp.h.
