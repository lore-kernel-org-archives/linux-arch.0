Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:45214 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeIKLhe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Sep 2018 07:37:34 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR
 number
References: <cover.1536550549.git.puwen@hygon.cn>
 <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
 <20180910180613.GE4386@zn.tnic>
Message-ID: <da680b5b-be9d-64c3-35f1-72f8ab02fc7d@hygon.cn>
Date: Tue, 11 Sep 2018 14:39:34 +0800
MIME-Version: 1.0
In-Reply-To: <20180910180613.GE4386@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180911063934.Stx4QhRmIaYtW1Khu-NJdnpDgab6jUpyuL3dyVTvim8@z>

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
