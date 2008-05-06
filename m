From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 04/56] microblaze_v2: Open firmware files
Date: Tue, 06 May 2008 09:27:23 +0200
Message-ID: <4820085B.5010205@seznam.cz>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu> <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu> <20080505215613.A5B3D18D004F@mail151-sin.bigfish.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:62847 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753785AbYEFH0f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 03:26:35 -0400
In-Reply-To: <20080505215613.A5B3D18D004F@mail151-sin.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

In prom.h is it. prom_parse.c of_device.c and of_platform.c will be in drivers/of/

M

> Michal,
> 
> You're missing some of the stuff implemented in powerpc/prom_parse.c, in
> particular this:
> 
> Steve
> 
>> +/**
>> + * of_irq_map_one - Resolve an interrupt for a device
>> + * @device:	the device whose interrupt is to be resolved
>> + * @index:	index of the interrupt to resolve
>> + * @out_irq:	structure of_irq filled by this function
>> + *
>> + * This function resolves an interrupt, walking the tree, for a given
>> + * device-tree node. It's the high level pendant to of_irq_map_raw().
>> + * It also implements the workarounds for OldWolrd Macs.
>> + */
>> +extern int of_irq_map_one(struct device_node *device, int index,
>> +			struct of_irq *out_irq);
>> +
> 
> 
> 
> 
> 
