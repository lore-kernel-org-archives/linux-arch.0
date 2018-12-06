From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH] asm-generic: unistd.h: fixup broken macro include.
Date: Thu, 6 Dec 2018 18:01:23 +0100
Message-ID: <61957990-17be-f20f-27f1-ada7a820f3ba@linaro.org>
References: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
 <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Mao Han <han_mao@c-sky.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
