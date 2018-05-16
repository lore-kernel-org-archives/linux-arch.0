Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:24928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752245AbeEPIVM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 May 2018 04:21:12 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 08/24] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Wed, 16 May 2018 11:18:53 +0300
Message-ID: <20180516081910.10067-9-ynorov@caviumnetworks.com>
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Message-ID: <20180516081853.3Sb4DFv0D_Tz7R6JNHYB_Lautlwn6spIWX7kkLIh0CI@z>

From: Andrew Pinski <apinski@cavium.com>

In this patchset ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
