Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:44801 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728881AbeIYTFI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Sep 2018 15:05:08 -0400
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180924152448.GE20187@zn.tnic>
 <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
 <20180925123035.GC23986@zn.tnic>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <d565ef8a-6d53-4490-2cba-1f237b0aa9d5@hygon.cn>
Date: Tue, 25 Sep 2018 20:57:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180925123035.GC23986@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <20180925125720.baiJih1R0hXpwBRCHDz3i37xPS4LHpnzzrPgJAwFLLs@z>

On 2018/9/25 20:30, Borislav Petkov wrote:
> On Tue, Sep 25, 2018 at 08:27:15PM +0800, Pu Wen wrote:
>> All right, I will change these in the next version patch set.
> 
> Just send two patches as a reply to this thread here:
> 
> 1. add the vendor check to both amd_gart_present() and early_is_amd_nb()
> 2. redo 7/16 ontop of the first patch.
> 
> I don't think you need to resend the whole patchset as the rest is still
> good.

OK, I got the point. :)
I'll just send the two patches.

Thx.

-- 
Regards,
Pu Wen
