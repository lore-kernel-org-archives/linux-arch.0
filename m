From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
Date: Wed, 19 Dec 2018 18:08:13 +0100
Message-ID: <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com> <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Turner <mattst88@gmail.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 19, 2018 at 4:59 PM Matt Turner <mattst88@gmail.com> wrote:
> On Fri, Dec 14, 2018 at 10:18 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Tue, 13 Nov 2018 at 15:02, Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > Could someone review this patch series and queue it for 4.21
> > through alpha tree would be great.
>
> Thank you! I'll take a look.

Hi Matt,

I see that you merged the changes a while ago into

git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha#for-linus

This all seems fine, but they never showed up in linux-next,
which his what had both Firoz and me confused.

Is that intentional, or should it be added there?

Added Stephen to Cc here in case you want it added.

       Arnd
