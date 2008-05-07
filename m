Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:52606 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755822AbYEGSmL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 May 2008 14:42:11 -0400
Message-ID: <4821F83C.8080608@seznam.cz>
Date: Wed, 07 May 2008 20:43:08 +0200
From: Michal Simek <monstr@seznam.cz>
Reply-To: monstr@seznam.cz
MIME-Version: 1.0
Subject: Re: [PATCH 36/56] microblaze_v2: dma support
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <48214B36.9060307@seznam.cz> <Pine.LNX.4.64.0805070917111.6341@anakin> <200805071121.43006.arnd@arndb.de>
In-Reply-To: <200805071121.43006.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca
Message-ID: <20080507184308.3izZ6zPBaEhsxr0ic-Cpj4LsdBYlqF31-Ch4IF_xCU0@z>

Hi Arnd and Geert,

I think scatterlist.h can be moved to asm-generic.

M


> On Wednesday 07 May 2008, Geert Uytterhoeven wrote:
>> On Wed, 7 May 2008, Michal Simek wrote:
>>> Is it OK now? This will moved to asm-generic too.
>> Ack.
> 
> looks good to me as well.
> 
> 	Arnd <><
> 
