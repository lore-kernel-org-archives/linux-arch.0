From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 24/56] microblaze_v2: time support
Date: Tue, 06 May 2008 15:26:09 +0200
Message-ID: <48205C71.1000401@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <1210033811.5798.188.camel@localhost> <48202C9E.7070800@seznam.cz> <200805061338.24870.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:59188 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbYEFNZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 09:25:07 -0400
In-Reply-To: <200805061338.24870.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca

Hi Arnd,

I am not discouraged from negative comments. I got school from Wolfgang Denk on
U-BOOT project. (Thanks Wolfgang :-))

I only want to direct this to right way. That's all. And positive ACK to some
files give me better view what's wrong. :-)

Have a good day,
Michal


>> I saw a lot of comments about files but I have never seen any comments that
>> any file is OK.
>> Does it mean everything is broken??? I don't think so.
> 
> I've commented mostly on the header files defining the ABI. Since my aim
> is to have the ABI definition entirely in asm-generic/*.h, every exported
> file that has more than one line in it should be changed.
> 
> The files that implement the architecture support itself all look good
> to me, but since I'm not familiar with the architecture, I'm not trying
> to comment on them.
> 
> I think you're doing a great job on this. Any patch set of this size that
> has been maintained for a long time outside of the kernel goes through this
> phase where everyone tells you what to improve, based on their experience,
> while everything you do right about the patches is just taken for granted.
> 
> Don't let yourself get discouraged by the negative comments, we're really
> all just trying to help you do the right thing!
> 
>> I'll integrate reported bugs and send microblaze_v3 version.
> 
> Ok, thanks!
> 
> 	Arnd <><
> 
> 
