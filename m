Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4683 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbYE3NPi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 09:15:38 -0400
Message-ID: <483FFDF8.1070607@rtr.ca>
Date: Fri, 30 May 2008 09:15:36 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
References: <1212092282.28403.107.camel@brick>	<483F65CA.4050507@rtr.ca>	<20080529195225.5665ae9c.akpm@linux-foundation.org>	<18495.32327.521211.508818@cargo.ozlabs.ibm.com> <20080529220450.2f701d93.akpm@linux-foundation.org>
In-Reply-To: <20080529220450.2f701d93.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, Harvey Harrison <harvey.harrison@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
Message-ID: <20080530131536.NTAeETdS1B8e1SWG1oibqNZDMy0N7xMRV45ofK6ujgg@z>

Andrew Morton wrote:
> On Fri, 30 May 2008 14:10:47 +1000 Paul Mackerras <paulus@samba.org> wrote:
> 
>>>> What's the point here?
>>> Readability and maintainability.  Once one becomes familar with a
>>> particular idion like this you can read it and say "ah, I know what
>>> that's doing" rather than having to peer at every character and work it
>>> out at each site where it happens.
>>>
>>> As usual: a PITA now, but better long-term.
>>>
>>> otoh,
>>>
>>> - I think the args are backwards
>> I think you just admitted that the new version is less readable.  At
>> least with an '=' operator you know which side is the thing that's
>> being modified.  With a put_XXX function, I would have to go look up
>> the definition (particularly since outb et al. are also the wrong way
>> around, i.e. have the destination as the second argument).
> 
> Well yes, but you don't have to worry about that when reviewing because
> you know the compiler will catch reversals.
> 
> Still not terribly keen about it all, but geeze the code which it is
> trying to clarify is godawful:
> 
> 	*(__le32 *)(buf + i) = cpu_to_le32(addr);
> 
> wtf?
> 
> Then again the replacement
> 
> 	put_le32(addr, (__le32 *)(buf + i));
> 
> is still wtf.
..

Exactly my point.  With the "improved" version, I now have to go
hunting for yet another macro in yet another header file in order
to see what the code is doing and to verify correctness.
And I (and other reviewers) are just a teensy bit less likely to
follow through with that every time, meaning we'll miss bugs.

This is somewhat akin to Linus's dislike of typedefs for structs.
It just hides what's really going on, for no obvious gain.  Sorry.  :)

Cheers
