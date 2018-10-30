Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33852 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeJ3WZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2018 18:25:56 -0400
MIME-Version: 1.0
In-Reply-To: <871s87k607.wl-ysato@users.sourceforge.jp>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com> <871s87k607.wl-ysato@users.sourceforge.jp>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Oct 2018 14:32:25 +0100
Message-ID: <CAK8P3a2MGn6ugmex60Dj05aYHCjgbv9F38DRCLkGwZk2HfEFpw@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Message-ID: <20181030133225.vLpM05KhUv1Xq8yHCSStcLyxwRf6uCE3dFmwhVOg4r8@z>

On 10/30/18, Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
> On Mon, 29 Oct 2018 18:44:59 +0900, Arnd Bergmann wrote:
>> just like ARM has mostly killed off the custom vendor-specific
>> instruction
>> sets already. If we add another architecture in the future, it may
>> instead
>> be something like the LLVM bitcode or WebAssembly, who knows?
>>
>
> I have one another port.
> Now we have a build environment so we can not merge right away,
> but I'd like to update it to the latest within a few months.

Ok, cool. Which one is that?

       Arnd
