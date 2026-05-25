Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6B23E325;
	Mon, 25 May 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700827; cv=none; b=bAyw6DzWXMgsDyir/X7WItrZjqud2tiS7gI4l0uYVCyojD2Um3AFXvSDKUXx82rtOUdkrpj3tflSpevONsvmY9STymaFc4hIRtBfPzVjEFh+rZLBXArT1us3oHdVxbOgS99XJO6D9iBxChR2q2dSFfIUdNXSXzjKGRZ5ayD+v34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700827; c=relaxed/simple;
	bh=wHwa05q3X0M7pHuwoK/fW6VsqGUz/U6qLAauhlJxAbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=golXmYcJF7Y11schphPcRofJq4Rmi8BhJ/d1F9dCIk4zS0tvV+QiFRiecZ5RAminMF4qjvHo2Ocd/B3Jl66UqtJNsS4FZ689hJoyJ5skIEGlPkrPEu9QdpRMsmaMRN6Q/yO7PTPbX6RSwIKI86mKL7aSO4k/zTkbHqmq6dQjvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gP9Lk3hZzzYQttb;
	Mon, 25 May 2026 17:19:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3349E4056E;
	Mon, 25 May 2026 17:20:19 +0800 (CST)
Received: from [10.174.179.37] (unknown [10.174.179.37])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1tOFBRqJtpJDg--.2213S3;
	Mon, 25 May 2026 17:20:16 +0800 (CST)
Message-ID: <f5b7460a-5719-bdb2-c53b-413468857f57@huaweicloud.com>
Date: Mon, 25 May 2026 17:20:14 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 akpm@linux-foundation.org, npiggin@gmail.com, aneesh.kumar@kernel.org,
 peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, zengheng4@huawei.com, sunnanyong@huawei.com,
 blingxue@tencent.com
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <177944657885.252010.9796978866224637120.b4-ty@arm.com>
From: Zeng Heng <zengheng@huaweicloud.com>
In-Reply-To: <177944657885.252010.9796978866224637120.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXX1tOFBRqJtpJDg--.2213S3
X-Coremail-Antispam: 1UD129KBjvdXoWrury7ur13Cr4kKFyUJw1fJFb_yoWDKrX_XF
	WDA34Duws8Jw4UGa9IyrsrJr9Yga1jqF98Ar15ZayfAF9xXa93JrZ2gw4fCa15WaykWFZ2
	kwn5Z3Wagr4IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: p2hqwxhhqjqx5xdzvxpfor3voofrz/

Hi Catalin,


On 2026/5/22 18:42, Catalin Marinas wrote:
> On Thu, 21 May 2026 15:30:11 +0800, Zeng Heng wrote:
>> When huge_pmd_unshare() is called to unshare a PMD table, the
>> tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
>> but the aarch64 tlb_flush() only checked tlb->freed_tables to
>> determine whether to use TLBF_NONE (vae1is, invalidates walk
>> cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
>>
>> This caused the stale PMD page table entry to remain in the walk cache
>> after unshare, potentially leading to incorrect page table walks.
>>
>> [...]
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] arm64: tlb: Flush walk cache when unsharing PMD tables
>        https://git.kernel.org/arm64/c/c2ff4764e03e

This original issue was reported by our customer, who also participated
in the root cause analysis and resolution.

Could you please help add the below tags:

Co-developed-by: Xue Xiaowei <blingxue@tencent.com>
Signed-off-by: Xue Xiaowei <blingxue@tencent.com>

Thank you in advance.


Best regards,
Zeng Heng

