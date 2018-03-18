From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Date: Sun, 18 Mar 2018 13:25:57 -0700
Message-ID: <1521404757.27411.46.camel@perches.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2018-03-19 at 03:51 +0800, Guo Ren wrote:
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.16-rc5.
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)

[]

> It's my first patchset to linux and any feedback is welcome :)

Hello.  You might try to do a git am <series>
on a new branch and correct the various
git whitespace messages that are produced.

It's also possible to run checkpatch and correct
some of the linux-kernel code style conformance
nits it lists.

Perhaps something like:

$ git ls-files arch/csky/ | \
  while read file ; do \
    ./scripts/checkpatch.pl --strict --terse --no-summary $file ; \
  done

add --fix-inplace to the checkpatch line if desired.
