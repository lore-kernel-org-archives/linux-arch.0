From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 05/16] perf/x86: Add Hygon Dhyana support to PMU
 infrastructure
Date: Tue, 11 Sep 2018 15:00:08 +0800
Message-ID: <ae6c1c18-f503-2172-279b-5920e7fdb19a@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
 <1e7b20df2bb5ebca6d72339f8b4e1453325cef10.1536550550.git.puwen@hygon.cn>
 <20180910181730.GF4386@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910181730.GF4386@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/11 2:17, Borislav Petkov wrote:
>> The Hygon Dhyana CPU support both legacy and extension PMC MSRs(perf
> 
> I don't know but for some reason, you are writing "Hygon Dhyana CPU" as
> being plural. But it is singular:
> 
> "The Hygon Dhyna CPU supports both ..."
> 			    ^
> 			   |||

Will take more care of the usage between singular and plural and fix
the typo.

>> counter registers and event selection registers), so add Hygon Dhyana
>> support to get bit offset in the similar way as AMD does.
> 
> "to get bit offset"?

These words are used with the tendency to explain what the patch do,
actually they are not needed and will be removed.

-- 
Regards,
Pu Wen
