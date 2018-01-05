From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: [RFC PATCH 1/4] asm-generic/barrier: add generic nospec helpers
Date: Thu, 4 Jan 2018 20:21:56 -0800
Message-ID: <CAA9_cmcWHc_068kHEDQ2DNcTZNFBAypmkhznnVODKccnuLFFOg@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <20180103223827.39601-2-mark.rutland@arm.com>
 <20180104120021.lilczus6qv7e4vcw@salmiak>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35027 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbeAEEV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 23:21:57 -0500
In-Reply-To: <20180104120021.lilczus6qv7e4vcw@salmiak>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jan 4, 2018 at 4:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 03, 2018 at 10:38:24PM +0000, Mark Rutland wrote:
>> +#define nospec_array_load(arr, idx, sz)                                      \
>> +({                                                                   \
>> +     typeof(*(arr)) *__arr = arr;                                    \
>> +     typeof(idx) __idx = idx;                                        \
>> +     typeof(sz) __sz = __sz;                                         \
>
> Whoops. The second __sz should be sz here.

Those should all have parenthesis on the args too, right?
