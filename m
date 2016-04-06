From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 10/10] arch: fix has_transparent_hugepage()
Date: Wed, 6 Apr 2016 03:22:38 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E9C327@us01wembx1.internal.synopsys.com>
References: <alpine.LSU.2.11.1604051329480.5965@eggly.anvils>
 <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andres Lagar-Cavilla <andreslc@google.com>, Yang Shi <yang.shi@linaro.org>, Ning Qu <quning@gmail.com>, Arnd Bergman <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Miller <davem@davemloft.net>, Chris
 Metcalf <cmetcalf@tilera.com>, Ingo Molnar <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Wednesday 06 April 2016 02:32 AM, Hugh Dickins wrote:=0A=
> I've just discovered that the useful-sounding has_transparent_hugepage()=
=0A=
> is actually an architecture-dependent minefield: on some arches it only=
=0A=
> builds if CONFIG_TRANSPARENT_HUGEPAGE=3Dy, on others it's also there when=
=0A=
> not, but on some of those (arm and arm64) it then gives the wrong answer;=
=0A=
> and on mips alone it's marked __init, which would crash if called later=
=0A=
> (but so far it has not been called later).=0A=
>=0A=
> Straighten this out: make it available to all configs, with a sensible=0A=
> default in asm-generic/pgtable.h, removing its definitions from those=0A=
> arches (arc, arm, arm64, sparc, tile) which are served by the default,=0A=
> adding #define has_transparent_hugepage has_transparent_hugepage to those=
=0A=
> (mips, powerpc, s390, x86) which need to override the default at runtime,=
=0A=
> and removing the __init from mips (but maybe that kind of code should be=
=0A=
> avoided after init: set a static variable the first time it's called).=0A=
>=0A=
> Signed-off-by: Hugh Dickins <hughd@google.com>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com> # for arch/arc bits=0A=
=0A=
Thx,=0A=
-Vineet=0A=

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
