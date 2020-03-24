From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v3 0/4] arm64: tlb: add support for TTL field
Date: Tue, 24 Mar 2020 20:41:44 +0800
Message-ID: <20200324124144.1492-1-yezhenyu2@huawei.com>
References: <4e3d42d9-7c57-3659-edbe-1e59ca5b04ea@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <4e3d42d9-7c57-3659-edbe-1e59ca5b04ea@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: yuzenghui@huawei.com
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, arm@kernel.org, yezhenyu2@huawei.com, aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, steven.price@arm.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, broonie@kernel.org, maz@kernel.org, prime.zeng@hisilicon.com, guohanjun@huawei.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Zenghui,

On 2020/3/24 19:31, Zenghui Yu wrote:
>Hi Zhenyu,
>
>On 2020/3/21 20:16, Zhenyu Ye wrote:
>> --
>> ChangeList:
>> v3:
>> use vma->vm_flags to replace mm->context.flags.
>> 
>> v2:
>> build the patch on Marc's NV series[1].
>> 
>> v1:
>> add support for TTL field in arm64.
>> 
>> --
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated. Hardware can use this information
>> to determine if there was a risk of splintering.
>> 
>> Marc has provided basic support for ARM64-TTL features on his
>> NV series[1] patches. NV is a large feature, however, only
>> patches 62[2] and 67[3] are need by this patch set.
>> ** You only need read those two patches before review this patch. **
>
>It'd be good if you can put the whole thing into a series, otherwise
>people will have difficulty when reviewing and testing it...
>
>I haven't tracked the previous versions. If Marc is OK to share the
>two patches below [2][3], I'd suggest you to pick them up, add them
>in your series, rebase on top of mainline and resend it.
>
>
>Thanks,
>Zenghui
>

Thanks for your review.  I'd take your suggestion and resend a new set
right now.

Thanks,
Zhenyu

>> 
>> Some of this patch depends on a feature powered by @Will Deacon
>> two years ago, which tracking the level of page tables in mm_gather.
>> See more in commit a6d60245.
>> 
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-5.6-rc1
>> [2] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-63-maz@kernel.org/
>> [3] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-68-maz@kernel.org/
>> 
>> Zhenyu Ye (4):
>>    arm64: Add level-hinted TLB invalidation helper to tlbi_user
>>    mm: Add page table level flags to vm_flags
>>    arm64: tlb: Use translation level hint in vm_flags
>>    mm: Set VM_LEVEL flags in some tlb_flush functions
>> 
>>   arch/arm64/include/asm/mmu.h      |  2 ++
>>   arch/arm64/include/asm/tlb.h      | 12 +++++++++
>>   arch/arm64/include/asm/tlbflush.h | 44 ++++++++++++++++++++++++++-----
>>   arch/arm64/mm/hugetlbpage.c       |  4 +--
>>   arch/arm64/mm/mmu.c               | 14 ++++++++++
>>   include/asm-generic/pgtable.h     | 16 +++++++++--
>>   include/linux/mm.h                | 10 +++++++
>>   include/trace/events/mmflags.h    | 15 ++++++++++-
>>   mm/huge_memory.c                  |  8 +++++-
>>   9 files changed, 113 insertions(+), 12 deletions(-)
>> 
>
