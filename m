Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:45128 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbeIDRI4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 13:08:56 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
 <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
 <20180904080241.GB32615@zn.tnic>
Message-ID: <a6895981-6c2e-f570-882d-f5a49dc7255b@hygon.cn>
Date: Tue, 4 Sep 2018 20:43:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180904080241.GB32615@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180904124335.HKQmomSjcJvQs1khgn7NcOxYuIvBy2kkQzmhg_CbRn8@z>

On 2018/9/4 16:02, Borislav Petkov wrote:
> shows only old mails so I'm going to assume this got fixed, finally! And
> you probably have received a *fixed* BIOS even, allegedly.
>
> So what's up?

I tested the function on Hygon Dhyana platforms with the latest BIOS,
found that this problem is indeed fixed. So the workaround is not
needed for Hygon Dhyana platforms any more, and the vendor checking
for Hygon will be removed in next version of patch.

Thanks,
Pu Wen
