Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:58701 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbeH3WGY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Aug 2018 18:06:24 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
 <20180830123559.GF20005@nazgul.tnic>
Message-ID: <c22c3058-6a0b-f043-0263-e9767a54c2f2@hygon.cn>
Date: Fri, 31 Aug 2018 02:02:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180830123559.GF20005@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180830180255.0vklzqSJ50VzlkAIermibstAUwyaZWJu5ogrbyIFmS0@z>

On 2018-08-30 20:35, Borislav Petkov wrote:
>> +HYGON PROCESSOR SUPPORT
>> +M:	Pu Wen <puwen@hygon.cn>
>> +L:	linux-arch@vger.kernel.org
>
>This is probably the wrong ML. You either have your own or use lkml,
>I'd say.

That's all right, I'll use linux-kernel@vger.kernel.org instead.

>> +++ b/arch/x86/kernel/cpu/hygon.c
>> @@ -0,0 +1,408 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hygon Processor Support for Linux
>> + *
>> + * Copyright (c) Chengdu Haiguang IC Design Co., Ltd.
>> + *
>> + * Author: 2018 Pu Wen <puwen@hygon.cn>
>
>Year goes with the copyright.

OK, will change it as below: (in next version of patches)
+ * Copyright (c) 2018 Chengdu Haiguang IC Design Co., Ltd.
+ * Author: Pu Wen <puwen@hygon.cn>

Thanks,
Pu Wen

>Otherwise looks ok.
