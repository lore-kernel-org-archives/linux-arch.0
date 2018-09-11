From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR
 number
Date: Tue, 11 Sep 2018 14:39:34 +0800
Message-ID: <da680b5b-be9d-64c3-35f1-72f8ab02fc7d@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
 <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
 <20180910180613.GE4386@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910180613.GE4386@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/11 2:06, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 09:16:03PM +0800, Pu Wen wrote:
>> The Hygon Dhyana CPU have a special magic MSR way to force WB for
> 
>  From the last review round:
> 
> Also, it is "The ... CPU has a special..."
> 
> Please take your time and incorporate *all* review feedback - no need to
> *rush* a new revision out and drop review feedback.

Sorry for not taking much care of the usage between singular and plural.
Will fix those typos.

-- 
Regards,
Pu Wen
