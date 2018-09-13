Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44618 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINCvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2018 22:51:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id l9-v6so1808374ywc.11
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2018 14:40:16 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 201-v6sm1796121ywn.103.2018.09.13.14.40.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:40:14 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m123-v6so3954815ybm.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Sep 2018 14:40:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
 <20180704075923.GF3701@osiris> <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 13 Sep 2018 14:40:12 -0700
Message-ID: <CAGXu5jJ9hD8-2ioAKdXKc8uV+OjRSJVUftd9rY9RfW7Tkor=kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180913214012.bEYtnYFSfR0-rSlume2KNHe_NNg5vmSdgE5MPkzoRKE@z>

On Wed, Jul 4, 2018 at 1:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 July 2018 at 09:59, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>> On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
>>> This series implements support for emitting the data structures associated
>>> with jump tables as 32-bit relative references instead of absolute
>>> references, which take up more space on builds that target 64-bit
>>> architectures, or implement self relocation [or both].
>>>
>>> This series enables it for arm64 and x86, although other architectures
>>> might benefit as well.
>>
>> Hello Ard,
>>
>> feel free to add the patch below which adds support for s390 to your series.
>>
>
> Thanks, I will incorporate it into v3 and beyond.

Just a quick status check! :) What're your plans for this series? I'd
still love to see it.

-Kees

-- 
Kees Cook
Pixel Security
