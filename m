Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:41878 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeIWSw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Sep 2018 14:52:26 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180923111046.GA20575@zn.tnic>
Message-ID: <f20743b0-cad2-4eb4-ac6d-f1aa7b34ce16@hygon.cn>
Date: Sun, 23 Sep 2018 20:54:47 +0800
MIME-Version: 1.0
In-Reply-To: <20180923111046.GA20575@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <20180923125447.9bz4nmzOKz4XHEVojmKNwj2_W6K0sCv9UDOYAQNnH7g@z>

On 2018/9/23 19:10, Borislav Petkov wrote:
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
>> Reviewed-by: Borislav Petkov <bp@suse.de>
>
> A note for your future submissions: if you rework a patch in a
> non-trivial way, you *must* drop Reviewed-by/Acked-by tags because they
> are not valid anymore.
>
> In this case I guess Bjorn's tag can stay because he's acking the
> pci_ids.h addition but mine definitely must go.

Thanks for the note. I'm sorry for not removing the Reviewed-by tag.
Is this revision still OK by you? :)

-- 
Regards,
Pu Wen
