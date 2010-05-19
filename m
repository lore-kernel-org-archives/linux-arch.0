From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/3] Reduce get_current() to the asm-generic
	implementation where possible
Date: Wed, 19 May 2010 13:02:04 +0200
Message-ID: <20100519110204.GB10040@redhat.com>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk> <20100518194753.GA2318@shareable.org> <20100519062112.GQ2516@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab0ESLEi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2010 07:04:38 -0400
Content-Disposition: inline
In-Reply-To: <20100519062112.GQ2516@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org

On 05/19, Nick Piggin wrote:
>
> On Tue, May 18, 2010 at 08:47:53PM +0100, Jamie Lokier wrote:
> >
> > So there is probably no point putting the const attribute back, unless
> > GCC has changed at this.
> >
> > It might be able to eliminate some duplicates if the asm inside
> > current_thread_info() is consty enough, and duplicate ->task
> > dereferences might be eliminated by strict-aliasing in some cases.
>
> I don't think it hurts to give more information even if the compiler
> does not use it yet.

Completely agreed.

Personally, I think this patch makes sense even as documentation. And
hopefully some time later gcc will be improved.

Oleg.
