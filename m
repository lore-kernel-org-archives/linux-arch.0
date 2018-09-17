Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:62080
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbeIQWp6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 18:45:58 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 0/3] System call table generation support
Date: Mon, 17 Sep 2018 17:17:23 +0000
Message-ID: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <E013BB721669064EBAB7919B20DB00F1@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Message-ID: <20180917171723.2aigWI-SJ7d3UEkGcVrGJp3grCPio1M-sR6m8aa8reI@z>

Hi Firoz,

On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> The purpose of this patch series is:
> 1. We can easily add/modify/delete system call by changing entry=20
> in syscall.tbl file. No need to manually edit many files.
>=20
> 2. It is easy to unify the system call implementation across all=20
> the architectures.=20
>=20
> The system call tables are in different format in all architecture=20
> and it will be difficult to manually add or modify the system calls
> in the respective files manually. To make it easy by keeping a script=20
> and which'll generate the header file and syscall table file so this=20
> change will unify them across all architectures.

Interesting :)

I actually started on something similar recently with the goals of
reducing the need to adjust both asm/unistd.h & the syscall entry tables
when adding syscalls, clean up asm/unistd.h a bit & make it
easier/cleaner to add support for nanoMIPS & the P32 ABI.

My branch still needed some work but it's here if you're interested:

    git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-s=
yscalls

    https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=
=3Dwip-mips-syscalls

There are some differences:

  - I'd placed syscall numbers the 3 current MIPS ABIs in one table,
    rather than splitting it up. I can see pros & cons to both though so
    I'm not tied to having a single all-encompassing table.

  - I'd mostly inferred the entry point names from the syscall names,
    only specifying them where they differ. Again I'm not particularly
    tied to this.

  - I'd made asm/unistd.h behave like asm-generic/unistd.h with the
    __SYSCALL() macro, where you generate separate syscall_table_*
    headers. I'm fine with that too.

So I'm pretty happy to go with your series, though I agree with Arnd on
the ABI/file naming & the missing syscalls that were added in the 4.18
cycle. We probably need to provide mipsmt_sys_sched_[gs]etaffinity as
aliases to sys_sched_[gs]etaffinity when CONFIG_MIPS_MT_FPAFF isn't
enabled in order to fix the issue the kbuild test robot reported.

But I'm looking forward to v2 :)

Thanks,
    Paul
