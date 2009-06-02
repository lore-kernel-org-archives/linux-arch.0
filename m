From: Tim Bird <tim.bird@am.sony.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 12:30:56 -0700
Message-ID: <4A257DF0.6040607@am.sony.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net> <1243967132.4280.11 <20090602185143.GA8655@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wa4ehsobe005.messaging.microsoft.com ([216.32.181.15]:29002
	"EHLO WA4EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751553AbZFBTcP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 15:32:15 -0400
In-Reply-To: <20090602185143.GA8655@zod.rchland.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, David VomLehn <dvomlehn@cisco.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

Josh Boyer wrote:
> 2) Encouraging upstream participation of "Embedded" distros
> 
> Things like Moblin and Android are getting a lot of press these days, but
> embedded distros have been around for a while.  Are we getting good
> participation from these vendors?  Is there something we could be doing to
> encourage such participation?  Has CELF helped with this at all?  etc

CELF tries, but the progress is exceedingly slow.  Recently
we've been more focused on contracting specific feature work.
(E.g. Squashfs mainlining).

James Bottomley wrote:
> Even for someone as inattentive as me, the general problems of getting
> embedded people to agree the sky is blue did impinge on the peripheral
> consciousness.  Thus: If you can come up with such a process in a timely
> fashion then fine ... if not, we'll do the topic based one suggested by
> the PC.

With regard to a process to determine representatives, I'm not
sure we need one.  Based on participation and inclusion in
MAINTAINERS, either Matt Mackall or David Woodhouse can
represent most embedded issues just fine.  And I can say that
officially on behalf of CELF and it's members, which would
account for a large fraction of the overall embedded community.

With regard to topics, do topics drive attendee invitations,
or vice-versa?

Here's my own issue list:

tracing - already well (over?) represented

bloat - tracing will help identify performance bloat.
As for size bloat, a smaller kernel is always desirable, but we
are seeing signs that Moore's law is catching up and making
this less an issue (for the kernel - apps still have big
problems here.)

power management - Use cases for products that spend most
of their time off (even while appearing to be running) are
of interest. I don't know what the status 'wakelock-like'
solutions is.

fast boot - kernel is almost done? (!!!)  The new target for
kernel boot time is 300 milliseconds.  Once there, almost
all problems are then user space issues.  It is interesting
how much of a differentiator fast boot became for Linux
in netbooks and dual-boot configurations, in just the last
2 years - which just shows that sometimes it pays off to
optimize something. ;-)

participation - talking about this is like beating a dead horse
(for me at least).  I've been working on this for 5 years now,
making baby steps forward.  The issues are, by now, well understood
(I hope).  I'm not sure what a KS discussion is going to do
to drive issues here.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Corporation of America
=============================
