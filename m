Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42284 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932593AbdGSQC4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Jul 2017 12:02:56 -0400
From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 04/11] arm64/cpufeature: add ARMv8.3 id_aa64isar1 bits
Date: Wed, 19 Jul 2017 17:01:25 +0100
Message-ID: <1500480092-28480-5-git-send-email-mark.rutland@arm.com>
In-Reply-To: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, christoffer.dall@linaro.org, Dave.Martin@arm.com, jiong.wang@arm.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com, yao.qi@arm.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Message-ID: <20170719160125.xpmlDD0GArGYbvk0sFOuT4fYarzfBfnurf4KPKXlW9Q@z>
