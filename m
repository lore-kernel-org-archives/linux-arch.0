Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40150 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFRB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Dec 2018 12:01:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so726988qki.7
        for <linux-arch@vger.kernel.org>; Thu, 06 Dec 2018 09:01:27 -0800 (PST)
Subject: Re: [PATCH] asm-generic: unistd.h: fixup broken macro include.
References: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
 <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <61957990-17be-f20f-27f1-ada7a820f3ba@linaro.org>
Date: Thu, 6 Dec 2018 18:01:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Mao Han <han_mao@c-sky.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20181206170123.BtoE2RMN-hUt7TFWtV697rdiT_HCmFTkp6ufvNIWWME@z>

W dniu 06.12.2018 o 17:14, Arnd Bergmann pisze:
> On Thu, Dec 6, 2018 at 3:07 AM Guo Ren <ren_guo@c-sky.com> wrote:
>>
>> The broken macros make the glibc compile error. If there is no
>> __NR3264_fstat*, we should also removed related definitions.
>>
>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>> Signed-off-by: Mao Han <han_mao@c-sky.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
> 
> Thanks for the reminder!
> 
> Marcin had already sent me the same patch a while ago
> and I forgot to apply it. I applied your version now, which
> as a slightly better changelog, so it will be in linux-next
> tomorrow, and I plan to send it after that shows no regressions.

One patch less to keep locally ;D
