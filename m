Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935035AbdCVOPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2017 10:15:19 -0400
Subject: Re: [PATCH 17/17] arm64: Do not expose PCI mmap through procfs
References: <cover.1490188942.git.dwmw2@infradead.org>
 <4281f8e01b9fc5628cbf4a5c77abd642801e23c7.1490188942.git.dwmw2@infradead.org>
 <cd878fb7-86f1-50cc-d394-364cb8bde344@codeaurora.org>
 <1490191473.28249.9.camel@infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5362b452-8526-1a97-ebf7-7052f1af56f7@codeaurora.org>
Date: Wed, 22 Mar 2017 10:15:04 -0400
MIME-Version: 1.0
In-Reply-To: <1490191473.28249.9.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Message-ID: <20170322141504.9KSF32jbaPbLvnYRYjOmY147tr_J-wR3S37J7pGGMwU@z>

On 3/22/2017 10:04 AM, David Woodhouse wrote:
> On Wed, 2017-03-22 at 09:54 -0400, Sinan Kaya wrote:
>> On 3/22/2017 9:25 AM, David Woodhouse wrote:
>>>
>>>  
>>> +#ifdef __aarch64__
>>> +/* ARM64 wants to be special and not expose this through /proc
>>> like everyone else */
>>> +#undef HAVE_PCI_MMAP
>>> +#endif
>>> +
>> Where is this ARM64 special requirement coming from?
> 
> The idea is that as a new platform, ARM64 shouldn't need to implement
> legacy userspace interfaces.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422571.html
> 

Aren't we breaking an ABI for userspace? I know DPDK relies on this feature.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
