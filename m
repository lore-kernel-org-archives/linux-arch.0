Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:52050 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754343AbXDXSDD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2007 14:03:03 -0400
Message-ID: <462E4654.4030405@sgi.com>
Date: Tue, 24 Apr 2007 20:03:00 +0200
From: Jes Sorensen <jes@sgi.com>
MIME-Version: 1.0
Subject: Re: larger per cpu data
References: <617E1C2C70743745A92448908E030B2A0162DEC4@scsmsx411.amr.corp.intel.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A0162DEC4@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Luck, Tony wrote:
>> 256KB * 1024 CPUs (or more) == verymightyhuge ..... I certainly
>> wouldn't like to see this.
> 
> "Only" 256M :-)  That 1024 cpu system probably has 1TB of memory or
> more ... so this isn't quite as terrible as it sounds (at least in
> terms of percentage of memory used).
> 
> Are there customers buying high cpu count, low memory systems?

I doubt it, but I don't have numbers. However 256M is still a good chunk
of memory that could be put to better use.

> But unless these are some fabulously useful counters that Andi
> wants to add ... I'd prefer to keep the ia64 percpu area at 64K
> for a while longer.

Nod, my thoughts exactly.

Cheers,
Jes
