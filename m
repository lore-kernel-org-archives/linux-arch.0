From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Subject: Re: [RFC PATCH] dma: Add barrierless dma mapping/unmapping api
Date: Tue, 26 Jan 2010 12:11:34 -0800
Message-ID: <4B5F4C76.4050100@codeaurora.org>
References: <1264473346-32721-1-git-send-email-adharmap@codeaurora.org>	<1264480210.3601.118.camel@pasglop> <20100126134207T.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:42191 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0AZULi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2010 15:11:38 -0500
In-Reply-To: <20100126134207T.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dwalker@codeaurora.org, arnd@arndb.de, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com, maciej.sosnowski@intel.com, dan.j.williams@intel.com, beckyb@kernel.crashing.org, yanghy@cn.fujitsu.com, linux-arch@vger.kernel.org, adharmap@quicinc.com

FUJITA Tomonori wrote:
> On Tue, 26 Jan 2010 15:30:10 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> On Mon, 2010-01-25 at 18:35 -0800, adharmap@codeaurora.org wrote:
>>> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
>>>
  >
>> There are people nowadays putting AXI bridges and the whole ARM
>> paraphernalia of IP cores behind them on PowerPC cores for example and I
>> can see that happening with x86 as well.
>>
>> In your case, I believe your are fixing the wrong problem anyways. The
>> right approach would be instead to put all your buffer into an sglist
>> and use dma_map/unmap_sg().
> 
> Agreed again. That's exactly what I suggested before:
> 
> http://marc.info/?l=linux-kernel&m=126294076917753&w=2

I somehow missed your post, my apologies. Agreed that dma_map/unmap_sg 
would be the correct api to use here, however they still call the 
dmac_.*_range to map buffers. I could change those calls to do a barrier 
  only after mapping the last buffer. This would be much more cleaner 
than introducing a .*_nobarrier API.

Thanks for all the replies.
