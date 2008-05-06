From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 38/56] microblaze_v2: atomic.h bitops.h byteorder.h
Date: Tue, 06 May 2008 10:42:13 +0200
Message-ID: <482019E5.20606@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>	 <4e20213f5f296268a24955df8c951f7fba279816.1209897266.git.monstr@monstr.eu>	 <49eccf3408b90a5ebb42635493bbeef3b584acb9.1209897266.git.monstr@monstr.eu>	 <200805042358.15131.arnd@arndb.de> <1209954519.5798.74.camel@localhost>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:62910 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755656AbYEFIlJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 04:41:09 -0400
In-Reply-To: <1209954519.5798.74.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Williams <john.williams@petalogix.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

Hi All,

have someone any idea about others names of atomic.h in asm-generic?

If not - I'll choose one but not the last(atomic-wish-we-had-it-native.h). :-)

M

> On Sun, 2008-05-04 at 23:58 +0200, Arnd Bergmann wrote:
>> On Sunday 04 May 2008, monstr@seznam.cz wrote:
>>>  include/asm-microblaze/atomic.h    |  108 ++++++++++++++++++++++++++++++++++++
>> It would be cool if you could introduce this file as 
>> asm-generic/atomic-irqdisable.h or similar (can someone please
>> think of a better name?).
> 
> atomic-nonnative.h?
> 
> atomic-emulated.h?
> 
> atomic-wish-we-had-it-native.h?
> 
> 
> 
> 
> 
