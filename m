From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 10/56] microblaze_v2: Generic dts file for platforms
Date: Mon, 05 May 2008 22:07:23 +0200
Message-ID: <481F68FB.9070602@seznam.cz>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>	 <2391e49379fb6639f57d9d6e5811f3d49a4c6fda.1209897266.git.monstr@monstr.eu> <fa686aa40805050731gc29e88hdc4917041a63e12f@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:56880 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753654AbYEEUGj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 16:06:39 -0400
In-Reply-To: <fa686aa40805050731gc29e88hdc4917041a63e12f@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

Hi Grant,
>> From: Michal Simek <monstr@monstr.eu>
>>
>>
>>  Signed-off-by: Michal Simek <monstr@monstr.eu>
>>  ---
>>   arch/microblaze/platform/generic/system.dts |  137 +++++++++++++++++++++++++++
> 
> What is the purpose of the generic dts?  Will this work with custom
> microblaze designs?  The header block should contain a comment about
> what this file is for.

This file has only demonstration purpose. That's all.
This kernel has no relation with any board or design. This could be introduce
e.g. in petalogix distribution or in xilinx where you distribute this kernel
with specific hw design. That's one more reason why I want to keep system.dts in
platform specific folder too.

M
