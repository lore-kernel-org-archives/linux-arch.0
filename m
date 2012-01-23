Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab2AWNu5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2012 08:50:57 -0500
Subject: Re: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
From: Vinod Koul <vinod.koul@intel.com>
In-Reply-To: <4F1D4052.3070701@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
	 <1326807902.1540.116.camel@vkoul-udesk3>  <4F195E4C.6080805@codeaurora.org>
	 <1327066287.517.4.camel@vkoul-udesk3>  <4F1D4052.3070701@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Jan 2012 19:21:53 +0530
Message-ID: <1327326713.517.32.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ravi Kumar V <kumarrav@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, bryanh@codeaurora.org, tsoni@codeaurora.org, Daniel Walker <dwalker@fifo99.com>, dan.j.williams@intel.com, davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org, johlstei@codeaurora.org
Message-ID: <20120123135153.LbYjcmmQ7nJaPUeKKGM56muatYFjDjBEFhhzLkxRvR0@z>

On Mon, 2012-01-23 at 16:41 +0530, Ravi Kumar V wrote:
> 
> If some changes are made in interleave API then it can support our BOX 
> mode. Here in interleaved template he is assuming destination pattern as 
> can be contiguous or same as source pattern, but in our case destination 
> pattern is different from source pattern.
> So if a new parameter destination data chunk is added in "struct 
> dma_interleaved_template" structure then it can support different 
> destination pattern.
do you mean you have cases where you are doing a "memcpy" from one
interleaved memory to another?
Can you provide me with a scenario where this maybe helpful?

The reason why the API was designed like this was to give ability to
take these kind of interleaved memory and copy them to peripheral
(constant addr) or memory (typically contagious). 

In case it is just a pattern I wonder why it cannot be described in
standard scatter gather definitions as you can split the block further
down to copy from one respective block to somewhere else in memory.
> Also it will good if you can provide another parameter for passing 
> private data to dma driver.
1. what does this parameter do?
2. is this parameter static for a channel or it changes per transfer?

-- 
~Vinod

