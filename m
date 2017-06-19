From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/5] sh: thin archives fix linking
Date: Mon, 19 Jun 2017 15:19:26 +0900
Message-ID: <CAK7LNARFQ0bLEYOgEKd+0oULevSxRqwFu_VSLn89gn_XBo+-uQ@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-4-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170609052417.561-4-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> The VDSO symbols can't be linked into built-in.o when building with
> thin archives, so change this to linking them into the final link.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

SH maintainers, any comments for this patch?


I confirmed this patch solved the build error,
but I do not have access to any SH hardware.

Some Acked-by will be very helpful.



-- 
Best Regards
Masahiro Yamada
