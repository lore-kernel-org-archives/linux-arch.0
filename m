From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Date: Wed, 5 Sep 2018 21:03:12 +0800
Message-ID: <03835d0f-225a-f7b9-dedb-5d474193181a@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <47e08d8bab1cef667be3955941e7eedc23187ae1.1535459013.git.puwen@hygon.cn>
 <20180905104405.GG2237@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905104405.GG2237@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/5 18:44, Borislav Petkov wrote:
> Subject should be:
> 
> EDAC, amd64: Add Hygon Dhyana support

Thanks for the correction.

>> +	case 0x18:
>> +		fam_type	= &family_types[HYGON_F18_CPUS];
>> +		pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
>> +		break;
>> +
> 
> You can use the F17_CPUS array element here and overwrite the ->ctl_name
> string only. No need to define [HYGON_F18_CPUS] above... yet.

All right, the way reusing F17_CPUS will also minimize the code
modification.

>> +#define PCI_DEVICE_ID_HYGON_18H_DF_F0	0x1460
>> +#define PCI_DEVICE_ID_HYGON_18H_DF_F6	0x1466
> 
> As in the previous patch - use the AMD defines.

Will remove them in next version of patches.

-- 
Regards,
Pu Wen
