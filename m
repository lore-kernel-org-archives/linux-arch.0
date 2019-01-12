Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34024 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfALEVd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2019 23:21:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so13967271oie.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Jan 2019 20:21:32 -0800 (PST)
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header
 files
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
 <20190110235428.GA10016@roeck-us.net>
From: Rob Landley <rob@landley.net>
Message-ID: <d329d7b8-62fb-9cb0-521e-ee7887f122a1@landley.net>
Date: Fri, 11 Jan 2019 22:21:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190110235428.GA10016@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Firoz Khan <firoz.khan@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20190112042130.ZHRaA8PiPzksR4pJgkSMiCCXjj8aTQyJvKuRoHsPg7Q@z>

On 1/10/19 5:54 PM, Guenter Roeck wrote:
> On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
>> Unified system call table generation script must be run to
>> generate unistd_32.h and syscall_table.h files. This patch
>> will have changes which will invokes the script.
>>
>> This patch will generate unistd_32.h and syscall_table.h
>> files by the syscall table generation script invoked by
>> sh/Makefile and the generated files against the removed
>> files must be identical.
>>
>> The generated uapi header file will be included in uapi/-
>> asm/unistd.h and generated system call table header file
>> will be included by kernel/syscall_32.S file.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> 
> Have you tested this patch ?

I tested it at one point, but not recently. (It was before 4.20 came out...)

Rob
