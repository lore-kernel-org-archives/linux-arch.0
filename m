Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbYDKKLf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Apr 2008 06:11:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207885132.22001.85.camel@brick>
References: <1207885132.22001.85.camel@brick>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 11:11:28 +0100
Message-ID: <15208.1207908688@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411101128.mNMszVjBlYKh6BRLt7MXcTLnyHj6Vtwdse41AUHlctY@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> -#ifndef _ASM_UNALIGNED_H
> -#define _ASM_UNALIGNED_H
> -
> +#ifndef _ASM_FRV_UNALIGNED_H_
> +#define _ASM_FRV_UNALIGNED_H_

Why?

> - * impractical.  So, now we fall back to using memcpy.
> + * impractical.  So, now we fall back to using memmov.

That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
overlap with *ptr?

Also, for FRV, I think calling memmove/memcpy for MMU kernels may be the wrong
thing to do...  I'm sort of leaning towards doing the same thing as NOMMU
kernels and just using your inline ones.

The advantage of the inline ones is that they are quicker and probably involve
fewer instructions executed; whereas using memcpy/memmove may end up with
smaller, but slower code.  Hmmm...  Maybe key on CONFIG_CC_OPTIMIZE_FOR_SIZE?

David
