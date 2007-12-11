Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:26738 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbXLKMbq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Dec 2007 07:31:46 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBBCViBF088222
	for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2007 12:31:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lBBCVhE52871332
	for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2007 13:31:43 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lBBCVg07008843
	for <linux-arch@vger.kernel.org>; Tue, 11 Dec 2007 13:31:43 +0100
Message-ID: <475E832C.2010601@fr.ibm.com>
Date: Tue, 11 Dec 2007 13:31:40 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] freezer : add the TIF_FREEZE flag to all archs
References: <47594F8C.7070900@fr.ibm.com> <200712101736.29676.rjw@sisk.pl> <475D6C6D.5010903@sw.ru>
In-Reply-To: <475D6C6D.5010903@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arch@vger.kernel.org, Linux Containers <containers@lists.osdl.org>, linux-pm@lists.linux-foundation.org

Kirill Korotaev wrote:
>>> From: Cedric Le Goater <clg@fr.ibm.com>
>>
>> Sorry for the delay, I somehow managed to overlook your message.
>>
>>
>>> This patch is the first step in making the refrigerator() available 
>>> to all architectures, even for those without power management. 
>>>
>>> The purpose of such a change is to be able to use the refrigerator() 
>>> in a new control group subsystem which will implement a control group
>>> freezer.
>>
>> Hm, sounds interesting, but ...
>>  
>>
>>> If you think this is safe and not utterly stupid, I'll send the rest
>>> of the patchset exporting the refrigerator to all arches.
>>
>> ... you will need to provide some details, I think.
>>
>> I also think that it's safe to define TIF_FREEZE for all architectures, but
>> the usefulness of it will very much depend on the purpose. :-)

I'm sending the full patchset, asap

> refrigerator() can be used (and is actually used in OpenVZ containers) to freeze
> container processes for checkpointing (live migration).
> So this can be used regardless system suspend and on all archs.

Exactly !

Thanks,

C.
