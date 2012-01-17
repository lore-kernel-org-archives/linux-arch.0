From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
Date: Tue, 17 Jan 2012 19:15:02 +0530
Message-ID: <1326807902.1540.116.camel@vkoul-udesk3>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11161 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab2AQNoV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jan 2012 08:44:21 -0500
In-Reply-To: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ravi Kumar V <kumarrav@codeaurora.org>
Cc: dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, linux@arm.linux.org.uk, tsoni@qualcomm.com, johlstei@qualcomm.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2012-01-06 at 18:17 +0530, Ravi Kumar V wrote:
<sorry for delayed review, was on vacation and now traveling >
> 
> As our ADM Scatter-gather hardware needs
> -32-bit command configuration parameter
>  apart from 
> -32-bit source address
> -32-bit destination address
> -16-bit length
> 
> So,we have added new parameter in struct scatterlist to support xfer
> descriptor
> specific private data, and for supporting ADM Box mode DMA we added
> new
> API and data structure. 
what do you mean by "ADM Box mode"?

-- 
~Vinod
