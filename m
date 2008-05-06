From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 24/56] microblaze_v2: time support
Date: Wed, 07 May 2008 08:50:15 +1000
Message-ID: <1210114215.5798.194.camel@localhost>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <1210033811.5798.188.camel@localhost> <48202C9E.7070800@seznam.cz>
	 <200805061338.24870.arnd@arndb.de>  <48205C71.1000401@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:50513 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331AbYEFWvI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 18:51:08 -0400
In-Reply-To: <48205C71.1000401@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca

Hi Michal,

On Tue, 2008-05-06 at 15:26 +0200, Michal Simek wrote:

> I am not discouraged from negative comments. I got school from Wolfgang Denk on
> U-BOOT project. (Thanks Wolfgang :-))
> 
> I only want to direct this to right way. That's all. And positive ACK to some
> files give me better view what's wrong. :-)

I'd like to echo the other comments so far -you are doing a great job.
I'd take silence on a patch as cautious agreement - like Steve I'm
waiting for the dust to settle to do a build and boot test (probably on
v3 of your patchset).

Most of this code has been running happily for >18 months in the
PetaLogix 2.6.20 kernel, and you tested your OF changes pretty well over
Oct-Jan.  So, I'm happy enough with the underlying implementation, it's
really just a case of meeting the kernel.org gatekeeper's standards.

The syscall interface is the last prickly one, but we'll get there.

Cheers,

John
