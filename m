From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Date: Mon, 14 May 2018 12:05:19 +1000
Message-ID: <87a7t3q9eo.fsf@concordia.ellerman.id.au>
References: <20180509130001.24276-1-npiggin@gmail.com>
 <20180509130001.24276-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180509130001.24276-5-npiggin@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> This requires further changes to linker script to KEEP some tables
> and wildcard compiler generated sections into the right place. This
> includes pp32 modifications from Christophe Leroy.
>
> When compiling powernv_defconfig with this option, the resulting
> kernel is almost 400kB smaller (and still boots):
>
>     text      data       bss        dec   filename
> 11827621   4810490   1341080   17979191   vmlinux
> 11752437   4598858   1338776   17690071   vmlinux.dcde
>
> Mathieu's numbers for custom Mac Mini G4 config has almost 200kB
> saving. It also had some increase in vmlinux size for as-yet
> unknown reasons.
>
>     text      data       bss        dec   filename
>  7461457   2475122   1428064   11364643   vmlinux
>  7386425   2364370   1425432   11176227   vmlinux.dcde
>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> [8xx]
> Tested-by: Mathieu Malaterre <malat@debian.org> [32-bit powermac]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)

I'm happy for this to go in via the kbuild tree.

As long as it's in linux-next it will get tested by my CI which should
hopefully shake out any bugs.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
