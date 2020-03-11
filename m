From: Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
Date: Wed, 11 Mar 2020 09:12:54 +0000
Message-ID: <247ad619edf17eb266f856d937dac826@kernel.org>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200311025309.1743-1-yezhenyu2@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org, arm@kernel.org, catalin.marinas@arm.com, guohanjun@huawei.com, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, steven.price@arm.com, linux-mm@kvack.org, broonie@kernel.org, prime.zeng@hisilicon.com, aneesh.kumar@linux.ibm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Zhenyu,

On 2020-03-11 02:53, Zhenyu Ye wrote:
> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
> the level of translation table walk holding the leaf entry for the
> address that is being invalidated. Hardware can use this information
> to determine if there was a risk of splintering.
> 
> This set of patches adds TTL field to __TLBI_ADDR, and uses
> Architecture-specific MM context to pass the TTL value to tlb 
> interface.
> 
> The default value of TTL is 0, which will not have any impact on the
> TLB maintenance instructions. The last patch trys to use TTL field in
> some obviously tlb-flush interface.

I have already posted some support for ARMv8.4-TTL as part of my NV 
series [1],
patches 62, 67, 68 and 69. This only deals with Stage-2 translation so 
far.
If you intend to add Stage-1, please build on top of what I have already 
posted
(I can extract the patches on a separate branch if you want).

Thanks,

         M.

[1] 
https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/
-- 
Jazz is not dead. It just smells funny...
