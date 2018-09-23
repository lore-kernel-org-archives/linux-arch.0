From: Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
Date: Sun, 23 Sep 2018 18:05:06 +0800
Message-ID: <17475050-594c-0037-52d4-25bb631da141@hygon.cn>
References: <20180919031923.GC8820@shao2-debian>
 <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
 <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
 <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
 <alpine.DEB.2.21.1809201138230.3243@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1809201138230.3243@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rong Chen <rong.a.chen@intel.com>, bp@alien8.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, lkp@01.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/20 17:39, Thomas Gleixner wrote:
>> I reproduced the PANIC by running lkp-tests with a Intel machine.
>>
>> The reason is that the function early_is_amd_nb is called even if
>> running on Intel machine. At this case the misc_ids is NULL so the
>> PANIC occur.
>>
>> I'll rework a patch to solve this problem, either restore the default
>> value of misc_ids with the original AMD one or not call early_is_amd_nb
>> on Intel platform.
> 
> Return when !AMD and !HYGON is the right thing to do. No point in checking
> device ids which cannot happen in the first place.

All right, I reworked a new reversion which will return if it's Intel.

Thanks,
Pu Wen
