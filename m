Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeDQSiC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Apr 2018 14:38:02 -0400
From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv3 05/11] arm64/cpufeature: detect pointer authentication
Date: Tue, 17 Apr 2018 19:37:29 +0100
Message-ID: <20180417183735.56985-6-mark.rutland@arm.com>
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, cdall@kernel.org, drjones@redhat.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, mark.rutland@arm.com, ramana.radhakrishnan@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, awallis@codeaurora.org, kernel-hardening@lists.openwall.com
Message-ID: <20180417183729.2uPkOQi8Cb3e_Bp3peXRHBbUjtXU_F50aVbwoxysXyA@z>

So that we can dynamically handle the presence of pointer authentication
functionality, wire up probing code in cpufeature.c.
