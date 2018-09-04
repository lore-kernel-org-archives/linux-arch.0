From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Date: Tue, 4 Sep 2018 20:43:35 +0800
Message-ID: <a6895981-6c2e-f570-882d-f5a49dc7255b@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
 <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
 <20180904080241.GB32615@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904080241.GB32615@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
