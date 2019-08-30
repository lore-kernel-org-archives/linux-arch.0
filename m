From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Date: Fri, 30 Aug 2019 22:08:49 +0200
Message-ID: <CAK8P3a3T3r3b2uW977HiuMi0uYKs4V_d4e=PDnkWDpqs+wrLww@mail.gmail.com>
References: <20190828210934.17711-1-efremov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828210934.17711-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denis Efremov <efremov@linux.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 28, 2019 at 11:09 PM Denis Efremov <efremov@linux.com> wrote:
>
> Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
> the define consistent with BUG_ON(x) in CONFIG_BUG.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>

This makes sense, I've applied it to the asm-generic tree for now.

Two concerns though:

- adding unlikely() can cause new (usually false-postive) compile time
  warnings to show up in random configurations, so we'll have to see what
  the build bots think

- Kees Cook has recently sent a series for asm/bug.h that was merged by
  Andrew Morton. If there are is a conflict with your patch, it may be better
  to merge both through the same tree, either linux-mm or asm-generic.

        Arnd
