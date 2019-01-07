Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35242 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfAGCVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jan 2019 21:21:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so36816103ljb.2
        for <linux-arch@vger.kernel.org>; Sun, 06 Jan 2019 18:21:11 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p67sm12427301lfe.14.2019.01.06.18.21.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:21:09 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id q2-v6so36789515lji.10
        for <linux-arch@vger.kernel.org>; Sun, 06 Jan 2019 18:21:09 -0800 (PST)
MIME-Version: 1.0
References: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546826888-29197-1-git-send-email-yamada.masahiro@socionext.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Jan 2019 18:15:31 -0800
Message-ID: <CAHk-=wiHNj59B9BJww2u-4mPERp5=EKCWtn4ZQC0TSiX47gYiw@mail.gmail.com>
Subject: Re: [URGENT FIX PATCH] arch: restore generic-y += shmparam.h for some architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Stafford Horne <shorne@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Guan Xuetao <gxt@pku.edu.cn>, linux-c6x-dev@linux-c6x.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org
Message-ID: <20190107021531.tKnmufzkqGHpzWRcOQN5mxi8xyP0E2N-mtrv6xnBHj8@z>

On Sun, Jan 6, 2019 at 6:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Could you pick up this directly?
> Apology for breakage.

Oops. I just made rc1.

But sure, I'll pick it up. Everybody is likely using the git tree
anyway, rather than some random release patches and tarballs.

             Linus
