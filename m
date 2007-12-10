Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:16754 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbXLJQgr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 Dec 2007 11:36:47 -0500
Message-ID: <475D6C6D.5010903@sw.ru>
Date: Mon, 10 Dec 2007 19:42:21 +0300
From: Kirill Korotaev <dev@sw.ru>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] freezer : add the TIF_FREEZE flag to all archs
References: <47594F8C.7070900@fr.ibm.com> <200712101736.29676.rjw@sisk.pl>
In-Reply-To: <200712101736.29676.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-arch@vger.kernel.org, Linux Containers <containers@lists.osdl.org>, linux-pm@lists.linux-foundation.org

>>From: Cedric Le Goater <clg@fr.ibm.com>
> 
> 
> Sorry for the delay, I somehow managed to overlook your message.
> 
> 
>>This patch is the first step in making the refrigerator() available 
>>to all architectures, even for those without power management. 
>>
>>The purpose of such a change is to be able to use the refrigerator() 
>>in a new control group subsystem which will implement a control group
>>freezer.
> 
> 
> Hm, sounds interesting, but ...
>  
> 
>>If you think this is safe and not utterly stupid, I'll send the rest
>>of the patchset exporting the refrigerator to all arches.
> 
> 
> ... you will need to provide some details, I think.
> 
> I also think that it's safe to define TIF_FREEZE for all architectures, but
> the usefulness of it will very much depend on the purpose. :-)

refrigerator() can be used (and is actually used in OpenVZ containers) to freeze
container processes for checkpointing (live migration).
So this can be used regardless system suspend and on all archs.

Thanks,
Kirill
