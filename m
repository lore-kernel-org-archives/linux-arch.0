Return-Path: <SRS0=qpv3=7J=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com> <20200515171612.1020-12-catalin.marinas@arm.com>
In-Reply-To: <20200515171612.1020-12-catalin.marinas@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 27 May 2020 11:57:39 -0700
Message-ID: <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Evgenii Stepanov <eugenis@google.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200527185739.yUeB4wEu3o-U-vL-v5x2LYRWDphbYevnVh0OS7WzVH0@z>

On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> To enable tagging on a memory range, the user must explicitly opt in via
> a new PROT_MTE flag passed to mmap() or mprotect(). Since this is a new
> memory type in the AttrIndx field of a pte, simplify the or'ing of these
> bits over the protection_map[] attributes by making MT_NORMAL index 0.

Should the userspace stack always be mapped as if with PROT_MTE if the
hardware supports it? Such a change would be invisible to non-MTE
aware userspace since it would already need to opt in to tag checking
via prctl. This would let userspace avoid a complex stack
initialization sequence when running with stack tagging enabled on the
main thread.

Peter
