From: Ravi Kumar V <kumarrav@codeaurora.org>
Subject: Re: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
Date: Wed, 01 Feb 2012 11:46:02 +0530
Message-ID: <4F28D8A2.9050605@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
 <1326807902.1540.116.camel@vkoul-udesk3> <4F195E4C.6080805@codeaurora.org>
 <1327066287.517.4.camel@vkoul-udesk3> <4F1D4052.3070701@codeaurora.org>
 <1327326713.517.32.camel@vkoul-udesk3> <4F1FFF7E.3000802@codeaurora.org>
 <1327911315.1527.8.camel@vkoul-udesk3> <4F278341.4020600@codeaurora.org>
 <1327990151.1527.80.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1327990151.1527.80.camel@vkoul-udesk3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-arch@vger.kernel.org, tsoni@codeaurora.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, bryanh@codeaurora.org, johlstei@codeaurora.org, Daniel Walker <dwalker@fifo99.com>, dan.j.williams@intel.com, davidb@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 1/31/2012 11:39 AM, Vinod Koul wrote:
> On Tue, 2012-01-31 at 11:29 +0530, Ravi Kumar V wrote:
>>> [1]: https://lkml.org/lkml/2011/10/24/275
>>> [2]: https://lkml.org/lkml/2012/1/26/405
>>>
>>
>> Yes if we follow the above RFC and add extra context parameter also
>> in
>> device_prep_dma_sg()&  device_prep_interleaved_dma() then it supports
>> our hardware and our work will be completed.
>>
>> can we follow above RFC and implement our driver.
>> Is above RFC finalized and included in mainline?
> Alexandre will post an updated one soon, but the idea is same
>

Can we add extra parameter context to device_prep_dma_sg() & 
device_prep_interleaved_dma() API's and implement our driver.

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
