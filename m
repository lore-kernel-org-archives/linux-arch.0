Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD635979;
	Mon, 20 Apr 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688277; cv=none; b=ZR8NASyBhg8+c2G46+ypcxokIm8WddG2gGaupPGHGPx7CzcY9qU+qr56r9/zxGx7vtKqswfkB8pJEkG4RoBDXNMlBivCQVisz72wABBHDQScV54V4vUiENon4lS9xgIQITk4WtTukOuE/JTbPpRL5WZuP7IijlXFLbwa46BU4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688277; c=relaxed/simple;
	bh=LE0vaRQAG+IRXoUEPNsC61qZxi9tJzcKFIED7xELOX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R+gMVs2x9fcSdLokJHisGS/PDWoK/QOxGcyN6cppNqQ0TLDwUYcKPdhjEBsBhTkDG8rVu23BVrpRfryNtub7tfoGOUoOjTt8XehEy5fpy76fhJ7oAWUniYgPbKmOLEdKRhHAVpPQ8VUeLC+f9BgECBn6dToCStcluD9wEC9pdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MZNpiZDR; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MZNpiZDR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vsRgUrnf7fJOqmTMZfqROi6TIW3yoVHHyUrTYkgkC24=;
	b=MZNpiZDR7AGlh6bttuh/Yox6OWkMj/Mu2gxyyjfllnPCEdIUxfP5SCIEw4nupIA0CD/V6hjBo
	wX7NKlDYkq3GhzVv/paiw3Aba0u7sR/IQi0AAJx7cm87H6RY2yYpOUGSg3FJ7tdaAZEAdrfQ7gg
	UrTbuZR+fCWnFQi9lYOKgXY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fzl6K05X7zcZyv;
	Mon, 20 Apr 2026 20:24:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 787364056D;
	Mon, 20 Apr 2026 20:31:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 20:31:03 +0800
Message-ID: <08481a75-c294-4558-93d5-00a013f07010@huawei.com>
Date: Mon, 20 Apr 2026 20:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
To: David Laight <david.laight.linux@gmail.com>, Yury Norov
	<ynorov@nvidia.com>
CC: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <nathan@kernel.org>
References: <20260417093102.3812978-1-ruanjinjie@huawei.com>
 <aeJbH7vfRpPuOGB0@yury> <20260417194259.0c48d7ef@pumpkin>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260417194259.0c48d7ef@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 4/18/2026 2:42 AM, David Laight wrote:
> On Fri, 17 Apr 2026 12:09:03 -0400
> Yury Norov <ynorov@nvidia.com> wrote:
> 
>> On Fri, Apr 17, 2026 at 05:31:00PM +0800, Jinjie Ruan wrote:
>>> Add bitrev.h file to support rev8 and brev8 for riscv.
>>>
>>> Tested functionally on riscv64 QEMU with:
>>> 	"-M virt,acpi=on,zbkb=true,zbb=true"
>>>
>>> Changes in v3:
>>> - Fix the build issue by remving the CONFIG_HAVE_ARCH_BITREVERSE macro
>>>   for byte_rev_table.  
>>
>> No arch needs byte_rev_table, except risc-v under a very certain
>> configuration. Please find a better approach that wouldn't bloat
>> random victims' .data section.
> 
> Eh?
> x86 doesn't have a bit-reverse instruction.
> The only arch that 'select HAVE_ARCH_BITREVERSE' are arm64, arm32 (some cpu),
> loongarch and mips (for CPU_MIPSR6).
> 
> I think you mean that no arch that sets CONFIG_HAVE_ARCH_BITREVERSE needs it
> except riscv.
> 
> Could you globally have:
> 	select NEED_BYTE_REV_TABLE if !HAVE_ARCH_BITREVERSE
> and then riscv could also select it?

Thanks, David. I will follow your suggestion to introduce a
NEED_BYTE_REVERSE_TABLE Kconfig option.

This way, byte_rev_table is only compiled when !HAVE_ARCH_BITREVERSE or
when an architecture (like RISC-V) explicitly selects it as a fallback.
This avoids bloating the .data section for architectures that have full
hardware bit-reverse support and don't need the table."

> (And isn't there a method of including files in the build based on
> kconfig options rather than unconditionally compiling it and getting cpp
> to throw the contents away?)

> 
> 	David
> 
>>
>>> - Update the riscv implementation as David suggested.
>>> - Add Reviwed-by.
>>>
>>> Changes in v2:
>>> - Define generic __bitrev8/16/32 for reuse in riscv.
>>>
>>> Jinjie Ruan (2):
>>>   bitops: Define generic __bitrev8/16/32 for reuse
>>>   arch/riscv: Add bitrev.h file to support rev8 and brev8
>>>
>>>  arch/riscv/Kconfig                    |  1 +
>>>  arch/riscv/include/asm/bitrev.h       | 55 +++++++++++++++++++++++++++
>>>  include/asm-generic/bitops/__bitrev.h | 22 +++++++++++
>>>  include/linux/bitrev.h                | 20 ++--------
>>>  lib/bitrev.c                          |  3 --
>>>  5 files changed, 82 insertions(+), 19 deletions(-)
>>>  create mode 100644 arch/riscv/include/asm/bitrev.h
>>>  create mode 100644 include/asm-generic/bitops/__bitrev.h
>>>
>>> -- 
>>> 2.34.1  
> 

