From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] ia64: fix barrier placement for write* / dma mapping
Date: Wed, 1 Aug 2018 01:00:32 -0700
Message-ID: <6ac80566-be1b-3dfc-e6b7-3c38131673ef@kernel.org>
References: <20180731172031.4447-1-hch@lst.de>
 <20180731172031.4447-2-hch@lst.de>
 <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
 <20180801072947.GD20224@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801072947.GD20224@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, okaya@codeaurora.org
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On 8/1/2018 12:29 AM, Christoph Hellwig wrote:
>> I asked this question to Tony Luck before. If I remember right,
>> his answer was:
>>
>> CPU guarantees outstanding writes to be flushed when a register write
>> instruction is executed and an additional barrier instruction is not
>> needed.
> That would be great.  It still doesn't explain the barriers in the
> dma sync routines.  Those have been there since the following commit
> in the history tree:

Yeah, I'll let Tony confirm my understanding.
