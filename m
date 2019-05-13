Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbfEMIsy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 04:48:54 -0400
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
        <20190508225900.GA14091@yury-thinkpad>
Date: Mon, 13 May 2019 10:48:48 +0200
In-Reply-To: <20190508225900.GA14091@yury-thinkpad> (Yury Norov's message of
        "Wed, 8 May 2019 15:59:00 -0700")
Message-ID: <mvmtvdyoi33.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <20190513084848.SMTQSpbOakFO5y_sldMqCzEMcvT-Haenw_a34CPBlsw@z>

There is a problem with the stack size accounting during execve when
there is no stack limit:

$ ulimit -s
8192
$ ./hello.ilp32 
Hello World!
$ ulimit -s unlimited
$ ./hello.ilp32 
Segmentation fault
$ strace ./hello.ilp32 
execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
+++ killed by SIGSEGV +++
Segmentation fault (core dumped)

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
