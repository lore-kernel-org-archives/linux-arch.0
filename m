Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43786 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfLMSFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 13:05:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so382439wre.10
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2019 10:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 13 Dec 2019 10:05:10 -0800
Message-ID: <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
Subject: Re: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Evgenii Stepanov <eugenis@google.com>, Kostya Kortchinsky <kostyak@google.com>, Kostya Serebryany <kcc@google.com>
Message-ID: <20191213180510.zVev99I0A1M-TwOvi9T0hA4nuyd7MA2Cy2IXbwEmRQA@z>

On Wed, Dec 11, 2019 at 10:40 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> Hi,
>
> This series proposes the initial user-space support for the ARMv8.5
> Memory Tagging Extension [1].

Thanks for sending out this series. I have been testing it on Android
with the FVP model and my in-development scudo changes that add memory
tagging support [1], and have not noticed any problems so far.

> - Clarify whether mmap(tagged_addr, PROT_MTE) pre-tags the memory with
>   the tag given in the tagged_addr hint. Strong justification is
>   required for this as it would force arm64 to disable the zero page.

We would like to use this feature in scudo to tag large (>128KB on
Android) allocations, which are currently allocated via mmap rather
than from an allocation pool. Otherwise we would need to pay the cost
(perf and RSS) of faulting all of their pages at allocation time
instead of on demand, if we want to tag them.

If we could disable the zero page for tagged mappings only and let the
pages be faulted as they are read, that would work for us.

Peter

[1] https://reviews.llvm.org/D70762
