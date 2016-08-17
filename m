Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:31360
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751550AbcHQMC1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2016 08:02:27 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 04/18] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Wed, 17 Aug 2016 14:46:29 +0300
Message-ID: <1471434403-25291-5-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Message-ID: <20160817114629.qLxkth2DlsPZUKoYqgZOJF4gfNjj6X8xf-USYYR1z2k@z>

From: Andrew Pinski <apinski@cavium.com>

In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
