Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54490 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfEMUTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 16:19:51 -0400
From: Yuri Norov <ynorov@marvell.com>
Subject: Re: [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
Date: Mon, 13 May 2019 20:16:17 +0000
Message-ID: <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
        <20190508225900.GA14091@yury-thinkpad>,<mvmtvdyoi33.fsf@suse.de>
In-Reply-To: <mvmtvdyoi33.fsf@suse.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@suse.de>, Yury Norov <yury.norov@gmail.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <20190513201617.hdsF7qhbRhem20mXqBQeR7H8bPKabRaG78aJtDJKnaE@z>

+ ltp@lists.linux.it

> There is a problem with the stack size accounting during execve when
> there is no stack limit:
>
> $ ulimit -s
> 8192
> $ ./hello.ilp32=20
> Hello World!
> $ ulimit -s unlimited
> $ ./hello.ilp32=20
> Segmentation fault
> $ strace ./hello.ilp32=20
> execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) =
=3D -1 ENOMEM (Cannot allocate memory)
> +++ killed by SIGSEGV +++
> Segmentation fault (core dumped)
>
> Andreas.

Thanks Andreas, I will take a look. Do we have such test in LTP?
   =20
Yury=
