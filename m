From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] mm: Reserve asm-generic prot flags 0x10 and 0x20
 for arch use
Date: Wed, 11 Dec 2019 20:26:39 +0100
Message-ID: <CAK8P3a0OxNWPjekT_m55reuopHJeWZs6dm7YTtoLgd39P6y2PQ@mail.gmail.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-2-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-2-catalin.marinas@arm.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, Linux-MM <linux-mm@kvack.org>, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Dave Martin <Dave.Martin@arm.com>
>
> The asm-generic/mman.h definitions are used by a few architectures that
> also define arch-specific PROT flags with value 0x10 and 0x20. This
> currently applies to sparc and powerpc for 0x10, while arm64 will soon
> join with 0x10 and 0x20.
>
> To help future maintainers, document the use of this flag in the
> asm-generic header too.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> [catalin.marinas@arm.com: reserve 0x20 as well]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
