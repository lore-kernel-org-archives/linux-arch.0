From: Ravi Kumar V <kumarrav@codeaurora.org>
Subject: Re: [PATCH v2 2/2] msm: DMAEngine: Add DMAEngine driver based on
 old MSM DMA APIs
Date: Tue, 17 Jan 2012 12:02:37 +0530
Message-ID: <4F151605.4050700@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org> <1325854052-21402-3-git-send-email-kumarrav@codeaurora.org> <1325901569.10425.14.camel@m0nster> <4F0ACB65.3040802@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:50356 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2AQGcm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jan 2012 01:32:42 -0500
In-Reply-To: <4F0ACB65.3040802@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dan.j.williams@intel.com
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, vinod.koul@intel.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, bryanh@codeaurora.org, tsoni@qualcomm.com, Daniel Walker <dwalker@fifo99.com>, davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org, johlstei@qualcomm.com

On 1/9/2012 4:41 PM, Ravi Kumar V wrote:
> On 1/7/2012 7:29 AM, Daniel Walker wrote:
>> On Fri, 2012-01-06 at 18:17 +0530, Ravi Kumar V wrote:
>>> Add DMAEngine based driver using the old MSM DMA APIs internally.
>>> The benefit of this approach is that not all the drivers
>>> have to get converted to DMAEngine APIs simultaneosly while
>>> both the drivers can stay enabled in the kernel. The client
>>> drivers using the old MSM APIs directly can now convert to
>>> DMAEngine one by one.
>>>
>>> Change-Id: I3647ed7b8c73b3078dfa8877a3560db3cb0a2373
>>> Signed-off-by: Ravi Kumar V<kumarrav@codeaurora.org>
>>> ---
>
> I will address the comments in next patch release, i will wait for
> sometime for vinod comments and release new patch v3.
>
> Ravi

Dan please can you review my patches and let me know your comments.

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
