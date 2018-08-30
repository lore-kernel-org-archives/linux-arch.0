Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:52855 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeH3VoO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Aug 2018 17:44:14 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
 <87mut52cf4.fsf@linux.intel.com>
Message-ID: <65c91fb2-4b57-8ddb-3363-ac6fe69957b9@hygon.cn>
Date: Fri, 31 Aug 2018 01:40:43 +0800
MIME-Version: 1.0
In-Reply-To: <87mut52cf4.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180830174043.KMHIG93ZXcS9fC-1DE-mwQZmVZA2gDhgb7WvLFi9y6c@z>

On 2018-08-30 03:35, Andi Kleen wrote:
>Pu Wen <puwen@hygon.cn> writes:
>> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
>> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
>> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU.
>
>Standard approach would be to move the shared code into a different
>file and call it from both amd.c and hygon.c instead of duplicating.

Hi Andi, Thanks for your feedback.

As Hygon Dhyana arch originate from AMD, we share most arch codes with
AMD. In our first patch v1, we direct reuse AMD's init codes in amd.c,
which can work out a minimal patch. But the code mixture between AMD
and Hygon occur, which might cause problem in long term.

To reduce long term maintaining effort, we reworked the patch and do the
arch code duplication and removed unnecessary old arch support code/family
condition check, which reduce code size to 37%, and give a clear view for
hygon arch initialize flow. For long term, it also remove code modification
interference between AMD and Hygon, make hygon code easy to modify for it's
further products. That's the patch since v2.

We did try the standard approach as you suggested between v1 and v2
internally, and found out it's hard to find a clear version. Because amd.c
has many family checking to support it's multiple family products, which
make the common function strip difficult. Also based on the consideration
of common functions also might interference with each other, we finally
choose the patch v2 style.

It's hard to find a best way between code duplication and code reuse.
Any suggestion please let us know.

Regards,
Pu Wen
