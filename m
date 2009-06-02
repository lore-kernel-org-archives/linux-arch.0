From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Tue, 02 Jun 2009 15:37:44 -0500
Message-ID: <1243975064.6342.10.camel@mulgrave.site>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <20090602172941.GL3095@hansolo.jdub.homelinux.org>
	 <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com>
	 <20090602175244.GB10973@cuplxvomd02.corp.sa.net>
	 <1243967132.4280.11 <20090602185143.GA8655@zod.rchland.ibm.com>
	 <4A257DF0.6040607@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51522 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbZFBUhs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 16:37:48 -0400
In-Reply-To: <4A257DF0.6040607@am.sony.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org, linux-embedded@vger.kernel.org, David VomLehn <dvomlehn@cisco.com>

On Tue, 2009-06-02 at 12:30 -0700, Tim Bird wrote:
> Josh Boyer wrote:
> > 2) Encouraging upstream participation of "Embedded" distros
> > 
> > Things like Moblin and Android are getting a lot of press these days, but
> > embedded distros have been around for a while.  Are we getting good
> > participation from these vendors?  Is there something we could be doing to
> > encourage such participation?  Has CELF helped with this at all?  etc
> 
> CELF tries, but the progress is exceedingly slow.  Recently
> we've been more focused on contracting specific feature work.
> (E.g. Squashfs mainlining).
> 
> James Bottomley wrote:
> > Even for someone as inattentive as me, the general problems of getting
> > embedded people to agree the sky is blue did impinge on the peripheral
> > consciousness.  Thus: If you can come up with such a process in a timely
> > fashion then fine ... if not, we'll do the topic based one suggested by
> > the PC.
> 
> With regard to a process to determine representatives, I'm not
> sure we need one.  Based on participation and inclusion in
> MAINTAINERS, either Matt Mackall or David Woodhouse can
> represent most embedded issues just fine.  And I can say that
> officially on behalf of CELF and it's members, which would
> account for a large fraction of the overall embedded community.
> 
> With regard to topics, do topics drive attendee invitations,
> or vice-versa?
> 
> Here's my own issue list:
> 
> tracing - already well (over?) represented
> 
> bloat - tracing will help identify performance bloat.
> As for size bloat, a smaller kernel is always desirable, but we
> are seeing signs that Moore's law is catching up and making
> this less an issue (for the kernel - apps still have big
> problems here.)
> 
> power management - Use cases for products that spend most
> of their time off (even while appearing to be running) are
> of interest. I don't know what the status 'wakelock-like'
> solutions is.
> 
> fast boot - kernel is almost done? (!!!)  The new target for
> kernel boot time is 300 milliseconds.  Once there, almost
> all problems are then user space issues.  It is interesting
> how much of a differentiator fast boot became for Linux
> in netbooks and dual-boot configurations, in just the last
> 2 years - which just shows that sometimes it pays off to
> optimize something. ;-)

OK, if that's what you all want, that's what we can do ... however, it
would likely be the same people discussing the same issues.

> participation - talking about this is like beating a dead horse
> (for me at least).  I've been working on this for 5 years now,
> making baby steps forward.  The issues are, by now, well understood
> (I hope).  I'm not sure what a KS discussion is going to do
> to drive issues here.

This is what made us suggest the presentation driven approach.  We can
send people who understand how the kernel development process out
anointed as embedded maintainers.  However, looking at the arch
directory, you have a ton of new kids on the block.  We wondered if,
perhaps, rather than having seasoned kernel developers reach out to the
embedded community, we might try giving the embedded community the
opportunity to reach out to us.  The topic of "flattened device tree"
look interesting to me (perhaps because I'm a hardened device driver
person and things like that always look interesting to me) ... if we can
get a few more like that out of the woodwork, this approach might end up
being successful.

James
