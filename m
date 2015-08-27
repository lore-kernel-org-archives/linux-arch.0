From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [arc-linux-dev] Re: [PATCH v3 0/6] ARCv2 port to Linux - (C) perf
Date: Thu, 27 Aug 2015 11:18:22 +0200
Message-ID: <20150827091822.GM3161@worktop.event.rightround.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440590824.15478.38.camel@synopsys.com>
 <1440658683.15478.59.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075CFB864CB@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51847 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbbH0JSZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2015 05:18:25 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075CFB864CB@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Thu, Aug 27, 2015 at 07:14:52AM +0000, Vineet Gupta wrote:
> On Thursday 27 August 2015 12:28 PM, Alexey Brodkin wrote:
> > I'm wondering if you have any other comments on this series,
> > otherwise please consider it for applying.
> 
> IMO it is better if this goes via ARC tree !
> 

I agree, please take it through the ARC tree.

The code looks good and the issues that I found were concious choices
that I see no real problems with.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
