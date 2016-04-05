Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:55840
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933603AbcDEWZ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Apr 2016 18:25:58 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Wed, 6 Apr 2016 01:08:32 +0300
Message-ID: <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Message-ID: <20160405220832.pKZQKihv45QY_9Yjyj9EIqhuW6UsxryzyYymywLIVQ8@z>

From: Andrew Pinski <apinski@cavium.com>

In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
