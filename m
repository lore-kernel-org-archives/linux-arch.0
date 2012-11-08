From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: RE: UAPI for new arches (was Re: [GIT PULL] User API Disintegrate:
 Preparatory patches)
Date: Thu, 8 Nov 2012 18:21:40 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750D9832@in01wembx1.internal.synopsys.com>
References: <509251CA.8050008@synopsys.com>
 <18137.1349203013@warthog.procyon.org.uk>
 <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com>
 <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>,<8419.1352387261@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:43173 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab2KHSVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Nov 2012 13:21:45 -0500
In-Reply-To: <8419.1352387261@warthog.procyon.org.uk>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: James Hogan <james@albanarts.com>, "torvalds@osdl.org" <torvalds@osdl.org>, "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "fengguang.wu@intel.com" <fengguang.wu@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

> Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

>> I'm planning to submit ARC Linux kernel port (from Synopsys) for review
>> on lkml and arch mailing lists. I already have a a 3.7-rc3 based kernel
>> (modulo the arch UAPI split). What would be the best way to get the UAPI
>> split done.
>>
>> Can you point me to the latest scripts and the best way to use them (so
>> we have consistent automated split of headers). Otherwise if you like,
>> you could take a stab at it yourself via my tree at
>>
>> git://github.com/organizations/foss-for-synopsys-dwc-arc-processors/linux.git
>> arc-3.7-rc3-newport

> If you look at:
>
>        http://git.infradead.org/users/dhowells/linux-headers.git/shortlog/refs/tags/disintegrate-arc-20121108
>
> You'll find a branch with a patch that does the UAPI disintegration for you as
> one piece.  I've merged your branch onto Linus's latest before doing the
> disintegration.  If you'd prefer it directly on your branch, that should be
> possible too.

Hi David,

Many thanks for doing this. Looking at the disintegrated headers, I have some observations, 
very likely due to shortcomings in my code, which need some clarifying.

While I'd done some of the prep work in my code such as splitting 
__KERNEL__ && __ASSEMBLY__ into two separate lines, majority of orig headers 
didn't have #ifdef __KERNEL__ guard despite the code not being meant for 
user-space ABI. Is that fundamental to UAPI split scripting because it seems to be 
causing setup.h to be in uapi despite seemingly being  kernel internal only.
OTOH the missing guards seem to be benign for several other headers (e.g. bug.h)
Also there's an empty UAPI header generated (tlb.h) - again very likely due to the 
missing guard.

Per you email from last week, When I ran the disintergrate-one.pl script myself I saw a
 whole bunch of empty UAPI files being generated with references in orig header.
I'm not sure what I'm doing wrong. 

For any ABI changes to headers per review of the new port on list (e.g. don't export pt_regs)
would mean moving the code manually from uapi to orig header - right. And if the file becomes
empty just nuke it completely.

How do you reckon we go about fixing these. I don't want to bother you multiple times
hence it would be best if I could reproduce this at my end.

thanks again for you help and time

-Vineet
