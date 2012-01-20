From: Ravi Kumar V <kumarrav@codeaurora.org>
Subject: Re: [PATCH v2 2/2] msm: DMAEngine: Add DMAEngine driver based on
 old MSM DMA APIs
Date: Fri, 20 Jan 2012 18:17:26 +0530
Message-ID: <4F19625E.2070103@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org> <1325854052-21402-3-git-send-email-kumarrav@codeaurora.org> <1325901569.10425.14.camel@m0nster> <1326810935.1540.162.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1326810935.1540.162.camel@vkoul-udesk3>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, bryanh@codeaurora.org, tsoni@qualcomm.com, dan.j.williams@intel.com, davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org, johlstei@qualcomm.com
List-Id: linux-arch.vger.kernel.org

On 1/17/2012 8:05 PM, Vinod Koul wrote:
> On Fri, 2012-01-06 at 17:59 -0800, Daniel Walker wrote:
>>> +
>>> +#define FORCED_FLUSH         0
>>> +#define GRACEFUL_FLUSH          1
>>
>> Could be an enum ..
> Along with proper namespace...
I will update in next patch release
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
