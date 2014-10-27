From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v5 04/29] nios2: Exception handling
Date: Mon, 27 Oct 2014 17:43:50 +0800
Message-ID: <CAFiDJ5_mwgtqsXN1oQ=FGNWZbB+escVFqEPYkuOPOVDTuWev2A@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
	<1414139071-3818-5-git-send-email-lftan@altera.com>
	<CAMuHMdVb8k_6zHm0deAWUKcKNfTpt2VL3RkJuv-99SCRwtUQEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVb8k_6zHm0deAWUKcKNfTpt2VL3RkJuv-99SCRwtUQEQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 24, 2014 at 5:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Oct 24, 2014 at 10:24 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> --- /dev/null
>> +++ b/arch/nios2/kernel/entry.S
>> @@ -0,0 +1,559 @@
>> +/*
>> + * linux/arch/nios2/kernel/entry.S
>> + *
>> + * Copyright (C) 2013-2014  Altera Corporation
>> + * Copyright (C) 2009, Wind River Systems Inc
>> + *
>> + * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
>> + *
>> + * Based on:
>> + *
>> + * linux/arch/nios2/kernel/entry.S
>
> And here you did one s/m68k/nios2/ too much ;-)
>
> As this doesn't seem to come from a single file
> "Based on the various m68k entry.S files"?
Good catch. Will remove this line.

Regards
Ley Foon
