Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEXRm2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 13:42:28 -0400
Date: Fri, 24 May 2019 12:42:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/tools: deal with 64-bit relative relocations for
 per-CPU symbols
Message-ID: <20190524174224.pdj2hgyni675xaoi@treble>
References: <20190522174057.21770-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522174057.21770-1-ard.biesheuvel@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, will.deacon@arm.com, guillaume.gardet@arm.com, mark.rutland@arm.com, mingo@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, x86@kernel.org
Message-ID: <20190524174224.bUwa8uye1-w4whvfjsJeSHVPmysr2Skf8Y5RxJLGb6g@z>

On Wed, May 22, 2019 at 06:40:57PM +0100, Ard Biesheuvel wrote:
> In order to fix an issue in the place relative ksymtab code, we
> need to switch to 64-bit place relative references, which
> require special handling in the x86 'relocs' tool. The reason
> is that per-CPU symbols on x86_64 live in a separate link time
> section, whose load time address is not reflected in the ELF
> metadata, and so relative references emitted by the toolchain
> are guaranteed to be wrong.
> 
> So fix this by extending the handling of 32-bit relative references
> to per-CPU variables to support 64-bit relative references as
> well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
> This is a follow-up to [0] and a prerequisite to the change it
> implements: using 64-bit relative references on x86_64 requires
> this handling in the 'relocs' tool and in the decompressor.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20190522150239.19314-1-ard.biesheuvel@arm.com
> 
> This patch plus [0] build and boot tested with x86_64_defconfig on QEMU/kvm + OVMF.

NACK based on

https://lkml.kernel.org/r/f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com

-- 
Josh
