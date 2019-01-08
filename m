From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Date: Wed, 9 Jan 2019 00:32:28 +0900
Message-ID: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com> <20190108111032.GP3235@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108111032.GP3235@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, linux-arch <linux-arch@vger.kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k <linux-m68k@lists.linux-m>
List-Id: linux-arch.vger.kernel.org

Hi Stafford,



On Tue, Jan 8, 2019 at 8:12 PM Stafford Horne <shorne@gmail.com> wrote:
>
> What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
> issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.


Based on Linus' latest tree.
(commit 3bd6e94be)

v5.0-rc1 is NOT the latest.



> It seems shmparam.h is not there. It was removed with the others in your
> ("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
> days ago.
>
> Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
> get it merged asap :)


I notice the breakage of several arches after v5.0-rc1 release,
so I asked Linus to pick up 3d6e94be.

I had already noticed
having shmparam.h in uapi is werid,
but I decided to fix the build errors first.


-- 
Best Regards
Masahiro Yamada
