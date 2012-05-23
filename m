From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 10:40:25 +0100
Message-ID: <1337766025.3013.3.camel@dabdike.int.hansenpartnership.com>
References: <CA+55aFzm5v2JXNOEp=VmJ22FOdo77L_TsDKbou6S=AtAJB-+Hg@mail.gmail.com>
	 <20120523.014627.497058725671088241.davem@davemloft.net>
	 <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50670 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409Ab2EWJka (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 May 2012 05:40:30 -0400
In-Reply-To: <CAMuHMdUdxrGqn9sRgwrNgX4teV_ivHSeBn3hKnvgxZRxQE_krQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Wed, 2012-05-23 at 10:02 +0200, Geert Uytterhoeven wrote:
> On Wed, May 23, 2012 at 7:46 AM, David Miller <davem@davemloft.net> wrote:
> > [PATCH] sparc: Add full proper error handling to strncpy_from_user().
> >
> > Linus removed the end-of-address-space hackery from
> > fs/namei.c:do_getname() so we really have to validate these edge
> > conditions and cannot cheat any more (as x86 used to as well).
> >
> > Move to a common C implementation like x86 did.  And if both
> > src and dst are sufficiently aligned we'll do word at a time
> > copies and checks as well.
> 
> Now everybody is rewriting this in plain C, perhaps it make sense to
> have it in lib/, so I don't have to write anything myself?

I think the sparc version will work for everybody (it will certainly
work on parisc).  The only thing that might be necessary is to add these
guards:


#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
       if (((long) dst | (long) src) & (sizeof(long) - 1))
               goto byte_at_a_time;
#endif

Dave, did you want to add it to lib/ ?

James
