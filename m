Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:53343 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbeIFQQX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 12:16:23 -0400
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
Message-ID: <634f371e-1a2d-5b23-c9b0-5f32a8ee4cee@hygon.cn>
Date: Thu, 6 Sep 2018 19:40:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180906083924.GB10768@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180906114052.sKVhy25LJEdqyGRImFq5wHcStkNa3xGzTClFfVK3UoA@z>

On 2018/9/6 16:39, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 11:52:42AM +0800, Pu Wen wrote:
>> In most of the normal use cases MCE is necessary. Rarely in some cases
>> such as for test purpose MCE may be unselected.
>
> Test with MCE disabled? Please elaborate.

The first is the compilation test. Test the kernel with both MCE selected
and unselected to see if is the compiling process successful or not.
The other test is functionality test. For example, during the MCE BIOS
development, to see if the MCE functions OK, it may need to select and
unselect MCE in kernel for double checking.

Actually in normal use scenario and in real product the MCE should be
always selected. To ensure this, I think there are two ways as below:
- Select X86_MCE_AMD in CPU_SUP_HYGON config entry, it also cater to the
  first test scenario, but meanwhile lacks flexibility.
- The linux distros(Ubuntu, CentOS, etc) ensure that X86_MCE_AMD is
  selected to the default config file, and indeed they do.
Which way is better?

-- 
Regards,
Pu Wen
