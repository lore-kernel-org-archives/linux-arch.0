From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 14:51:43 -0400
Message-ID: <20090602185143.GA8655@zod.rchland.ibm.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net> <1243967132.4280.11.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:49773 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbZFBSvz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 14:51:55 -0400
Content-Disposition: inline
In-Reply-To: <1243967132.4280.11.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David VomLehn <dvomlehn@cisco.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 02, 2009 at 01:25:32PM -0500, James Bottomley wrote:
>On Tue, 2009-06-02 at 10:52 -0700, David VomLehn wrote:
>> On Tue, Jun 02, 2009 at 12:42:57PM -0500, James Bottomley wrote:
>> > On Tue, 2009-06-02 at 13:29 -0400, Josh Boyer wrote:
>> > > Which leads me to suggest that it is at least worth having someone with an
>> > > embedded focus at KS to simply keep an eye out for impacts of generic changes.
>> > > "Feature parity" is something I often deal with in trying to keep ppc4xx up to
>> > > speed with the rest of the archs in the kernel.
>> > 
>> > We're fine with this, if that's how the embedded guys would like to do
>> > it ... how do you want to nominate the "someone with an embedded focus"?
>> > We chose the topic driven approach because that's the one it's easiest
>> > for the Kernel Summit Programme Committee to look at and make attendance
>> > decisions based upon.  However, if all the embedded people want to
>> > choose their own representatives, that's fine by us too ... as long as
>> > you can devise a fair process.
>> 
>> Now, James, I think you haven't been paying attention to the embedded Linux
>> world...asking us to devise *any* process is much more chaotic than herding
>> cats. Expecting something everyone agrees is fair would probably take until
>> at least KS 2010. That being said, we have three people who are listed in
>> MAINTAINERS under embedded Linux. We might start by seeing which of them
>> might take up the mantle and vote on the linux-embedded mailing list.
>
>Even for someone as inattentive as me, the general problems of getting
>embedded people to agree the sky is blue did impinge on the peripheral
>consciousness.  Thus: If you can come up with such a process in a timely
>fashion then fine ... if not, we'll do the topic based one suggested by
>the PC.

Most of these are probably tired and old, but some possible topic suggestions:

1) Kernel binary bloat (again)

2) Encouraging upstream participation of "Embedded" distros

Things like Moblin and Android are getting a lot of press these days, but
embedded distros have been around for a while.  Are we getting good
participation from these vendors?  Is there something we could be doing to
encourage such participation?  Has CELF helped with this at all?  etc

3) Netbooks - the bridge between embedded and desktop?

Is the flourish of low cost netbooks, some pre-installed with Linux, having any
impact on how we review and develop general kernel code?

One of the problems I struggle with is coming up with embedded topics general
enough to be of interest to a broader set of both upstream kernel developers
and the embedded community.  Those that are general enough have either been
discussed quite a bit already, or are already on the list of topics.

Maybe I'm just not trying hard enough.

josh
