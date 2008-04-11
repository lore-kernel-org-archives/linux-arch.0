Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:20636 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760581AbYDKPTX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2008 11:19:23 -0400
Received: by wa-out-1112.google.com with SMTP id m16so438950waf.23
        for <linux-arch@vger.kernel.org>; Fri, 11 Apr 2008 08:19:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <15208.1207908688@redhat.com>
References: <1207885132.22001.85.camel@brick>  <15208.1207908688@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 08:19:26 -0700
Message-ID: <1207927166.22001.91.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411151926.EAZ2EX4hjUGFu_qDCqPpyQr-NpUGAjinYSDxwsI2qWE@z>

On Fri, 2008-04-11 at 11:11 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > -
> > +#ifndef _ASM_FRV_UNALIGNED_H_
> > +#define _ASM_FRV_UNALIGNED_H_
> 
> Why?

Consistency with every other arch..no other reason.

> 
> > - * impractical.  So, now we fall back to using memcpy.
> > + * impractical.  So, now we fall back to using memmov.
> 
> That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
> overlap with *ptr?
> 
> Also, for FRV, I think calling memmove/memcpy for MMU kernels may be the wrong
> thing to do...  I'm sort of leaning towards doing the same thing as NOMMU
> kernels and just using your inline ones.

OK, just let me know what you decide.  I'm stil open to bringing back
the frv asm versions if the do end up being faster.

> 
> The advantage of the inline ones is that they are quicker and probably involve
> fewer instructions executed; whereas using memcpy/memmove may end up with
> smaller, but slower code.  Hmmm...  Maybe key on CONFIG_CC_OPTIMIZE_FOR_SIZE?
> 

I suppose an out-of-line version could be easily added to accomplish
this.  It would be identical to the byteshifting implementation-wise.

Let me know if you'd like me to spin such a patch.

Harvey

