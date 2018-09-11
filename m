From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 01/16] x86/cpu: Create Hygon Dhyana architecture
 support file
Date: Tue, 11 Sep 2018 14:33:20 +0800
Message-ID: <258a65ec-177e-fdc8-3f40-c5b748a6f0d1@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
 <d99e831f739308221798c9939efc6e6fc1648e0c.1536550550.git.puwen@hygon.cn>
 <20180910163821.GD4386@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910163821.GD4386@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/11 0:38, Borislav Petkov wrote:
> That sentence is not needed for the same reason as above.
> 
>> And select CPU_SUP_AMD
>> to solve the dependency issues in kernel.
> 
> No, this should say: "Since Dhyana uses AMD functionality to a large
> degree, select CPU_SUP_AMD which provides that functionality."

Thanks for the detailed correction. Will improve the description and
remove unneeded sentences in next version of patch.

-- 
Regards,
Pu Wen
