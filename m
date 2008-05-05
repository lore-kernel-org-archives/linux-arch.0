From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 49/56] microblaze_v2: fcntl.h sockios.h ucontext.h
Date: Mon, 05 May 2008 16:08:10 +0200
Message-ID: <481F14CA.8070402@seznam.cz>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <643084ee3819dd169cad3c4e3565c5ff20dd3429.1209897267.git.monstr@monstr.eu> <231ae415bf52de25c69f727fd13c50d201f8ecd8.1209897267.git.monstr@monstr.eu> <200805050043.43125.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:59126 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759319AbYEEOG6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 10:06:58 -0400
In-Reply-To: <200805050043.43125.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

FIXED


> On Sunday 04 May 2008, monstr@seznam.cz wrote:
>>  include/asm-microblaze/fcntl.h    |  104 +++++++++++++++++++++++++++++++++++++
> 
> Use the existing asm-generic version for this.
> 
>>  include/asm-microblaze/sockios.h  |   25 +++++++++
>>  include/asm-microblaze/ucontext.h |   24 +++++++++
> 
> turn these into asm-generic versions.
> 
> 	Arnd <><
> 
> 
