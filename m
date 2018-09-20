From: Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
Date: Thu, 20 Sep 2018 16:47:19 +0800
Message-ID: <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
References: <20180919031923.GC8820@shao2-debian>
 <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
 <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rong Chen <rong.a.chen@intel.com>
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, lkp@01.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/20 8:26, Rong Chen wrote:
> On 09/19/2018 09:53 PM, Pu Wen wrote:
>> I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
>> both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
>> What kind of host do you use to run the qemu? A Intel one or AMD one?
> It's a Intel one,
> 
> model: Nehalem-EX
> memory: 224G
> nr_node: 4
> nr_cpu: 64
> nr_socket: 4
> brand: Intel(R) Xeon(R) CPU X7560 @ 2.27GHz

I reproduced the PANIC by running lkp-tests with a Intel machine.

The reason is that the function early_is_amd_nb is called even if
running on Intel machine. At this case the misc_ids is NULL so the
PANIC occur.

I'll rework a patch to solve this problem, either restore the default
value of misc_ids with the original AMD one or not call early_is_amd_nb
on Intel platform.

-- 
Regards,
Pu Wen
