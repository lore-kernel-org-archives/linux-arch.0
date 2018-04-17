Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34908 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDQT4D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Apr 2018 15:56:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180417183735.56985-7-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com> <20180417183735.56985-7-mark.rutland@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Apr 2018 21:56:02 +0200
Message-ID: <CAK8P3a3SVhW1ByQOtxw7JG8i3wWU5opdycfSCTbW=GCFvBJmQg@mail.gmail.com>
Subject: Re: [PATCHv3 06/11] asm-generic: mm_hooks: allow hooks to be
 overridden individually
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, cdall@kernel.org, drjones@redhat.com, kvmarm@lists.cs.columbia.edu, linux-arch <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Wallis <awallis@codeaurora.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>
Message-ID: <20180417195602.qVk5w93ceDXu7ivA1HbJsgYTdxcT8yeethk6u_GrBvo@z>

On Tue, Apr 17, 2018 at 8:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently, an architecture must either implement all of the mm hooks
> itself, or use all of those provided by the asm-generic implementation.
> When an architecture only needs to override a single hook, it must copy
> the stub implementations from the asm-generic version.
>
> To avoid this repetition, allow each hook to be overridden indiviually,
> by placing each under an #ifndef block. As architectures providing their
> own hooks can't include this file today, this shouldn't adversely affect
> any existing hooks.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
