From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Date: Thu, 6 Sep 2018 23:47:31 +0800
Message-ID: <f4bdfc6d-c8ad-16d8-c641-51db36d64e66@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
 <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
 <20180906083924.GB10768@zn.tnic>
 <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
 <20180906122956.GF10768@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906122956.GF10768@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/6 20:29, Borislav Petkov wrote:
> Say what now?! What testing do you do if you boot a kernel which doesn't
> even use the functionality you're testing?!

I'm sorry, this case is not good to demonstrate the useage. And I think
there are no other people will do the test without MCE in kernel. So
with MCE enabled in kernel is the main case to support.

> The first way but change that dependency to CPU_SUP_AMD because there
> are people building their own kernels and don't run distro configs. And
> you need CPU_SUP_AMD because you're using their code.

That's good, will select CPU_SUP_AMD for CPU_SUP_HYGON to solve the
dependency issues in kernel.

-- 
Regards,
Pu Wen
