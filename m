From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Mon, 20 Sep 2010 11:30:57 +0200
Message-ID: <201009201130.57834.arnd@arndb.de>
References: <4C95324B.2030707@mcgary.org> <20100919040635.GE25139@parisc-linux.org> <4C964014.4090005@mcgary.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54319 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959Ab0ITJbH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2010 05:31:07 -0400
In-Reply-To: <4C964014.4090005@mcgary.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg McGary <greg@mcgary.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org

On Sunday 19 September 2010, Greg McGary wrote:
> > Essentially, you're asking us to take on a huge number of changes in
> > order to make your new processor's performance not suck.  I don't think
> > it likely you're going to find much sympathy here.
> 
> I propose this because (a) there is no impact on generated code for other ports,
> and (b) it benefits code quality, flexibility, portability and self-documentation.
> If the kernel is so ossified that avoiding changes has become the cardinal virtue,
> then I guess I'm hosed.  8^)  As stated before, I'm prepared to submit changes
> slowly over time in order to moderate the impact.

We make a lot of changes everywhere in the kernel that directly benefit only
a small subset of the community, like the RT work. I would think that the
only important requirements are that your proposed changes do not become
a burden for maintainance and that you minimise the risk for regressions.

Having proper types for opaque scalars that can be used for both pointer
and long values is a reasonable thing to do in general, and seems to fit
that requirement. Right now, we use 'unsigned long' to mean a number of
different things and from reading code it's not clear which one you want.
Not sure of intptr_t is the best name, so we might come up with something
better for this purpose, but it's a standard C99 type and the meaning
is pretty much what we want anyway.

Another possible alternative might be to add a kernel mode to your compiler
that defines long as 64 bits, but with only 48 significant bits, like you
have for your pointers. Does that work with your hardware?
It seems that this would be fast and means fewer changes to the kernel,
but opens a completely different can of worms in that it breaks code assuming
that "ULONG_MAX == (1ul << (sizeof (unsigned long) * 8)) - 1", and might
require many more changes to gcc.

	Arnd
