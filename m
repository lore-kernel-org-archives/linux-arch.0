Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:56516 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab2KAKu2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 06:50:28 -0400
Message-ID: <509251CA.8050008@synopsys.com>
Date: Thu, 1 Nov 2012 16:11:14 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: UAPI for new arches (was Re: [GIT PULL] User API Disintegrate: Preparatory
 patches)
References: <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>
In-Reply-To: <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: James Hogan <james@albanarts.com>, torvalds@osdl.org, arnd@arndb.de, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20121101104114.y8ZdseXrOGSyYOk7tDRtpmmuva4_Gy-e98CwhoF9jVo@z>

On Monday 22 October 2012 05:20 PM, James Hogan wrote:
> On 17 October 2012 09:42, James Hogan <james@albanarts.com> wrote:
>> On 2 October 2012 19:36, David Howells <dhowells@redhat.com> wrote:
>>> The patches herein prepare for the extraction of the Userspace API bits from
>>> the various header files named in the Kbuild files.
>>>
>>> [IMPORTANT NOTE!  These patches may need regenerating if the header files
>>>  change too much.  This doesn't normally take very long to do as the
>>>  disintegration procedure is almost entirely scripted.]
>>
>> Hi David,
>>
>> Any chance you (or somebody else) can point me towards your latest
>> scripts for all this UAPI disintegration work? They don't seem to be
>> in the kernel tree, and the only scripts I can find are from 2011 so I
>> guess they're probably a bit out of date.
> 
> Ping... Please can you point me to the scripts you've been using David?
> 
> Thanks
> James Hogan
> 

Hi David,

I'm planning to submit ARC Linux kernel port (from Synopsys) for review
on lkml and arch mailing lists. I already have a a 3.7-rc3 based kernel
(modulo the arch UAPI split). What would be the best way to get the UAPI
split done.

Can you point me to the latest scripts and the best way to use them (so
we have consistent automated split of headers). Otherwise if you like,
you could take a stab at it yourself via my tree at

git://github.com/organizations/foss-for-synopsys-dwc-arc-processors/linux.git
arc-3.7-rc3-newport

TIA,
-Vineet
