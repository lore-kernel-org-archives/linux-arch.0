From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing commands
Date: Thu, 10 Jun 2010 18:43:03 -0600
Message-ID: <4C118697.9090305@gmail.com>
References: <20100610160212.18091.29856.stgit@e102109-lin.cambridge.arm.com>	 <4C110EDD.2010409@kernel.org> <1276187002.24535.88.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1276187002.24535.88.camel@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 06/10/2010 10:23 AM, Catalin Marinas wrote:
> On Thu, 2010-06-10 at 17:12 +0100, Tejun Heo wrote:
>> On 06/10/2010 06:02 PM, Catalin Marinas wrote:
>>> The data in the cmd_block buffers may reach the main memory after the
>>> writel() to the device ports. This patch introduces two calls to wmb()
>>> to ensure the relative ordering.
>>>
>>> Signed-off-by: Catalin Marinas<catalin.marinas@arm.com>
>>> Tested-by: Colin Tuckley<colin.tuckley@arm.com>
>>> Cc: Tejun Heo<tj@kernel.org>
>>> Cc: Jeff Garzik<jeff@garzik.org>
>>
>> I suppose you have tested and verified that this is actually
>> necessary, right?
>
> Yes, otherwise we get random failures with this device on ARM.
>
>> I've been looking through the docs but couldn't
>> find anything which described the ordering between writes to main
>> memory and write[bwl]()'s.  One thing that kind of bothers me is that
>> r/wmb()'s are for ordering memory accesses among CPUs which
>> participate in cache coherency protocol and although it may work right
>> in the above case I'm not really sure whether this is the right thing
>> to do.  Do you have more information on the subject?
>
> The mb() are not for ordering accesses among CPUs (though they would
> cover this case as well). For inter-CPU ordering, we have smp_mb() and
> friends. For all other cases, we have the mandatory barriers mb() and
> friends and DMA is one of them.
>
> Apart from the memory-barriers.txt document, there is the Device I/O
> docbook which mentions something about DMA buffers, though not very
> clear on which barriers to use (something like just make sure that the
> writes to the buffer reached the memory).
>
> There were some past discussions on linux-arch before and I'm cc'ing
> this list again (ARM is not the only architecture with a weakly memory
> ordering model).
>
> I'm copying the patch below again for the linux-arch people that haven't
> seen the beginning of the thread:

My memory is fuzzy but I thought this came up before on PPC and I also 
thought the conclusion was that the platform code (for writel, etc.) 
should enforce ordering of MMIO accesses with respect to normal RAM 
accesses. (Or maybe it was just MMIO accesses with respect to each 
other?) I don't think the answer to that question has been clearly 
documented anywhere, which is somewhat unfortunate.

If the answer is that this is needed then there are likely a lot of 
other drivers in libata and elsewhere which need to be fixed as well. 
For example, I don't see any such barriers in libahci.c when I presume 
it would need them.

IMHO, it would be better for the platform code to ensure that MMIO 
access was strongly ordered with respect to each other and to RAM 
access. Drivers are just too likely to get this wrong, especially when 
x86, the most tested platform, doesn't have such issues.

>
>
>> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
>> index e925051..a5d5aff 100644
>> --- a/drivers/ata/sata_sil24.c
>> +++ b/drivers/ata/sata_sil24.c
>> @@ -622,6 +622,11 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
>>   	irq_enabled = readl(port + PORT_IRQ_ENABLE_SET);
>>   	writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR, port + PORT_IRQ_ENABLE_CLR);
>>
>> +	/*
>> +	 * The barrier is required to ensure that writes to cmd_block reach
>> +	 * the memory before the write to PORT_CMD_ACTIVATE.
>> +	 */
>> +	wmb();
>>   	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
>>   	writel((u64)paddr>>  32, port + PORT_CMD_ACTIVATE + 4);
>>
>> @@ -895,6 +900,11 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
>>   	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
>>   	activate = port + PORT_CMD_ACTIVATE + tag * 8;
>>
>> +	/*
>> +	 * The barrier is required to ensure that writes to cmd_block reach
>> +	 * the memory before the write to PORT_CMD_ACTIVATE.
>> +	 */
>> +	wmb();
>>   	writel((u32)paddr, activate);
>>   	writel((u64)paddr>>  32, activate + 4);
>>
>
> Thanks.
>

