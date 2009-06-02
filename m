From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 02 Jun 2009 16:16:36 -0500
Message-ID: <4A2596B4.3020309@billgatliff.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com> <20090602211057.GA10800@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:30336 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZFBVQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 17:16:36 -0400
In-Reply-To: <20090602211057.GA10800@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-e

Russell King wrote:
> The big problem we have is that the only commonality between different
> SoCs is that the CPU executes ARM instructions.  Everything else is
> entirely up to the SoC designer - eg location of memory, spacing of
> memory banks, type of interrupt controller, etc is all highly SoC
> specific.  Nothing outside of the ARM CPU itself is standardized.
>
>   

And that diversity is precisely because of the diversity in ARM-based 
embedded platforms.

Such diversity means that kernel/driver development is a constant 
activity, which suggests that we shouldn't bother the effort to come up 
with a comprehensive solution because none will exist.  Rather, we 
should maintain and improve the ability to rapidly prototype and adapt.  
Things like furthering the deployment of platform_device, 
clocksource/clockdevice, and so on.

ARM diversity is already a LOT easier to deal with than it was under 
2.4, so we're making progress.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
