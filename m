From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 06/40] of/vendor-prefixes: add Imagination Technologies
Date: Thu, 1 Nov 2012 09:20:08 +0000
Message-ID: <50923EC8.9040408@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-7-git-send-email-james.hogan@imgtec.com> <5091D29F.1050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:63095 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757305Ab2KAJUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 05:20:30 -0400
In-Reply-To: <5091D29F.1050100@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org

On 01/11/12 01:38, Rob Herring wrote:
> On 10/31/2012 11:13 AM, James Hogan wrote:
>> @@ -34,7 +35,7 @@ nintendo	Nintendo
>>  nvidia	NVIDIA
>>  nxp	NXP Semiconductors
>>  picochip	Picochip Ltd
>> -powervr	Imagination Technologies
>> +powervr	PowerVR (Imagination Technologies Ltd.)
> 
> Perhaps you should add "deprecated, use img"

Yes, that sounds reasonable, I'll change to something like this:
powervr		PowerVR (deprecated, use img)

> Otherwise, looks fine and I assume you are going to merge with the rest
> of the series:

Yeh, I'm happy either way.

> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks
James
