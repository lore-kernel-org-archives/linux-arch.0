Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:53478 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730122AbeIFUYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 16:24:06 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
 <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
 <20180906083924.GB10768@zn.tnic>
 <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
 <20180906122956.GF10768@zn.tnic>
Message-ID: <f4bdfc6d-c8ad-16d8-c641-51db36d64e66@hygon.cn>
Date: Thu, 6 Sep 2018 23:47:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180906122956.GF10768@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180906154731.7h8Fs4QWyEom1qdKaZg20djW7ei-8rrLjP3ShK5cidU@z>

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
