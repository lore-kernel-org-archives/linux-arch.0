From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 00/11] mm: Hardened usercopy
Date: Mon, 18 Jul 2016 18:26:43 +1000
Message-ID: <1468830403.2800.0.camel@gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1468619065-3222-1-git-send-email-keescook@chromium.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Daniel Micay <danielmicay@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Mathias Krause <minipli>
List-Id: linux-arch.vger.kernel.org

On Fri, 2016-07-15 at 14:44 -0700, Kees Cook wrote:
> Hi,
>=C2=A0
> [I'm going to carry this series in my kspp -next tree now, though I'd
> really love to have some explicit Acked-bys or Reviewed-bys. If you'v=
e
> looked through it or tested it, please consider it. :) (I added Valdi=
s
> and mpe's Tested-bys where they seemed correct, thank you!)]
>=C2=A0
> This is a start of the mainline port of PAX_USERCOPY[1]. After I star=
ted
> writing tests (now in lkdtm in -next) for Casey's earlier port[2], I =
kept
> tweaking things further and further until I ended up with a whole new
> patch series. To that end, I took Rik and other people's feedback alo=
ng
> with other changes and clean-ups.
>=C2=A0
> Based on my understanding, PAX_USERCOPY was designed to catch a
> few classes of flaws (mainly bad bounds checking) around the use of
> copy_to_user()/copy_from_user(). These changes don't touch get_user()=
 and
> put_user(), since these operate on constant sized lengths, and tend t=
o be
> much less vulnerable. There are effectively three distinct protection=
s in
> the whole series, each of which I've given a separate CONFIG, though =
this
> patch set is only the first of the three intended protections. (Gener=
ally
> speaking, PAX_USERCOPY covers what I'm calling CONFIG_HARDENED_USERCO=
PY
> (this) and CONFIG_HARDENED_USERCOPY_WHITELIST (future), and
> PAX_USERCOPY_SLABS covers CONFIG_HARDENED_USERCOPY_SPLIT_KMALLOC
> (future).)
>=C2=A0
> This series, which adds CONFIG_HARDENED_USERCOPY, checks that objects
> being copied to/from userspace meet certain criteria:
> - if address is a heap object, the size must not exceed the object's
> =C2=A0 allocated size. (This will catch all kinds of heap overflow fl=
aws.)
> - if address range is in the current process stack, it must be within=
 the
> =C2=A0 current stack frame (if such checking is possible) or at least=
 entirely
> =C2=A0 within the current process's stack. (This could catch large le=
ngths that
> =C2=A0 would have extended beyond the current process stack, or overf=
lows if
> =C2=A0 their length extends back into the original stack.)
> - if the address range is part of kernel data, rodata, or bss, allow =
it.
> - if address range is page-allocated, that it doesn't span multiple
> =C2=A0 allocations.
> - if address is within the kernel text, reject it.
> - everything else is accepted
>=C2=A0
> The patches in the series are:
> - Support for arch-specific stack frame checking (which will likely b=
e
> =C2=A0 replaced in the future by Josh's more comprehensive unwinder):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01- mm: Implement stac=
k frame object validation
> - The core copy_to/from_user() checks, without the slab object checks=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02- mm: Hardened userc=
opy
> - Per-arch enablement of the protection:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03- x86/uaccess: Enabl=
e hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04- ARM: uaccess: Enab=
le hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05- arm64/uaccess: Ena=
ble hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A06- ia64/uaccess: Enab=
le hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A07- powerpc/uaccess: E=
nable hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08- sparc/uaccess: Ena=
ble hardened usercopy
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A09- s390/uaccess: Enab=
le hardened usercopy
> - The heap allocator implementation of object size checking:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010- mm: SLAB hardened userc=
opy support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A011- mm: SLUB hardened userc=
opy support
>=C2=A0
> Some notes:
>=C2=A0
> - This is expected to apply on top of -next which contains fixes for =
the
> =C2=A0 position of _etext on both arm and arm64, though it has minor =
conflicts
> =C2=A0 with KASAN that are trivial to fix up. Living in -next are als=
o tests
> =C2=A0 for this protection in lkdtm, prefixed with USERCOPY_.
>=C2=A0
> - I couldn't detect a measurable performance change with these featur=
es
> =C2=A0 enabled. Kernel build times were unchanged, hackbench was unch=
anged,
> =C2=A0 etc. I think we could flip this to "on by default" at some poi=
nt, but
> =C2=A0 for now, I'm leaving it off until I can get some more definiti=
ve
> =C2=A0 measurements. I would love if someone with greater familiarity=
 with
> =C2=A0 perf could give this a spin and report results.
>=C2=A0
> - The SLOB support extracted from grsecurity seems entirely broken. I
> =C2=A0 have no idea what's going on there, I spent my time testing SL=
AB and
> =C2=A0 SLUB. Having someone else look at SLOB would be nice, but this=
 series
> =C2=A0 doesn't depend on it.
>=C2=A0
> Additional features that would be nice, but aren't blocking this seri=
es:
>=C2=A0
> - Needs more architecture support for stack frame checking (only x86 =
now,
> =C2=A0 but it seems Josh will have a good solution for this soon).
>=C2=A0
>=C2=A0
> Thanks!
>=C2=A0
> -Kees
>=C2=A0
> [1] https://grsecurity.net/download.php "grsecurity - test kernel pat=
ch"
> [2] http://www.openwall.com/lists/kernel-hardening/2016/05/19/5
>=C2=A0
> v3:
> - switch to using BUG for better Oops integration
> - when checking page allocations, check each for Reserved
> - use enums for the stack check return for readability
>

Thanks looks good so far! I'll try and test it and report back

Balbir=C2=A0
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
