From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 38/56] microblaze_v2: atomic.h bitops.h byteorder.h
Date: Mon, 05 May 2008 12:28:39 +1000
Message-ID: <1209954519.5798.74.camel@localhost>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <4e20213f5f296268a24955df8c951f7fba279816.1209897266.git.monstr@monstr.eu>
	 <49eccf3408b90a5ebb42635493bbeef3b584acb9.1209897266.git.monstr@monstr.eu>
	 <200805042358.15131.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:49601 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbYEEC3V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 22:29:21 -0400
In-Reply-To: <200805042358.15131.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sun, 2008-05-04 at 23:58 +0200, Arnd Bergmann wrote:
> On Sunday 04 May 2008, monstr@seznam.cz wrote:
> >  include/asm-microblaze/atomic.h    |  108 ++++++++++++++++++++++++++++++++++++
> 
> It would be cool if you could introduce this file as 
> asm-generic/atomic-irqdisable.h or similar (can someone please
> think of a better name?).

atomic-nonnative.h?

atomic-emulated.h?

atomic-wish-we-had-it-native.h?
