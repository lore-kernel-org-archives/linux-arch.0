From: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
Date: Fri, 13 Dec 2019 10:05:10 -0800
Message-ID: <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kostya Kortchinsky <kostyak@google.com>, Kostya Serebryany <kcc@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Evgenii Stepanov <eugenis@google.com>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

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
