From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/8] kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
 and clean-up code
Date: Wed, 9 May 2018 18:13:59 +0200
Message-ID: <20180509161359.GB7459@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Andy Whitcroft <apw@canonical.com>
List-Id: linux-arch.vger.kernel.org

Hi Masahiro.

On Wed, May 09, 2018 at 04:23:44PM +0900, Masahiro Yamada wrote:
> 
> I got acknowledge to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely.
> (https://lkml.org/lkml/2018/5/5/148)
> 
> Several tools can be cleaned-up.
> 
> Removing the CONFIG option makes VMLINUX_SYMBOL() no-op,
> so this macro can be removed too.
Looks good. You can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

for all patches.
One minor comment to one patch that I let you decide what to do about.
The code readability increases everywhere.

> 
> VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR() are widely used,
> so it will take some time to kill them entirely.
> (I will send other patches later, splitting per-arch)

There are a few files outside arch/ like
certs/system_certificates.S
drivers/mtd/chips/gen_probe.c
kernel/module.c

They could belong in this none-arch series.

	Sam
