From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 07/16] x86/pci: add Hygon PCI vendor and northbridge
 support
Date: Tue, 4 Sep 2018 23:45:02 +0800
Message-ID: <5c6b1493-ee20-ed3f-a558-331c0cb65556@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
 <20180904145255.GI32615@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904145255.GI32615@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/4 22:52, Borislav Petkov wrote:
>> Add Hygon support in amd_postcore_init(), early_root_info_init().
>
> This whole commit message needs to not say *what* the patch does.

Will rework the whole commit messages.

>> +#define PCI_DEVICE_ID_HYGON_18H_ROOT     0x1450
>> +#define PCI_DEVICE_ID_HYGON_18H_DF_F3    0x1463
>> +#define PCI_DEVICE_ID_HYGON_18H_DF_F4    0x1464
>
> Why are you adding those if you can use the AMD f17h ones? They're 
the same.

I add these definitions to indicate that there are Hygon PCI device IDs.
You are right, I can just use the AMD f17h ones here.

--
Regards,
Pu Wen
