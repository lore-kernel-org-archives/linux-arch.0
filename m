From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [URGENT FIX PATCH] arch: restore generic-y += shmparam.h for some architectures
Date: Sun, 6 Jan 2019 18:15:31 -0800
Message-ID: <CAHk-=wiHNj59B9BJww2u-4mPERp5=EKCWtn4ZQC0TSiX47gYiw@mail.gmail.com>
References: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Stafford Horne <shorne@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Guan Xuetao <gxt@pku.edu.cn>, linux-c6x-dev@linux-c6x.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 6, 2019 at 6:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Could you pick up this directly?
> Apology for breakage.

Oops. I just made rc1.

But sure, I'll pick it up. Everybody is likely using the git tree
anyway, rather than some random release patches and tarballs.

             Linus
