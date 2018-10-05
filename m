Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbeJEPrr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Oct 2018 11:47:47 -0400
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: [PATCH v5 05/17] arm64/cpufeature: detect pointer authentication
Date: Fri,  5 Oct 2018 09:47:42 +0100
Message-ID: <20181005084754.20950-6-kristina.martsenko@arm.com>
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Adam Wallis <awallis@codeaurora.org>, Amit Kachhap <Amit.Kachhap@arm.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Jacob Bramley <jacob.bramley@arm.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181005084742.h2jt3shhK6It-zFAPGQ4KqtALOvnT7m3yIeVbdqHgfY@z>

From: Mark Rutland <mark.rutland@arm.com>

So that we can dynamically handle the presence of pointer authentication
functionality, wire up probing code in cpufeature.c.
