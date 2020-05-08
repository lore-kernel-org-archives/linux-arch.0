From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 02/14] arm: add support for folded p4d page tables
Date: Fri, 8 May 2020 20:42:32 +0300
Message-ID: <20200508174232.GA759899@linux.ibm.com>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-3-rppt@kernel.org>
 <CGME20200507121658eucas1p240cf4a3e0fe5c22dda5ec4f72734149f@eucas1p2.samsung.com>
 <39ba8a04-d6b5-649d-c289-0c8b27cb66c5@samsung.com>
 <20200507161155.GE683243@linux.ibm.com>
 <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <98229ab1-fbf8-0a89-c5d6-270c828799e7@samsung.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>, kvm-ppc@vger.kernel.org, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
List-Id: linux-arch.vger.kernel.org

On Fri, May 08, 2020 at 08:53:27AM +0200, Marek Szyprowski wrote:
> Hi Mike,
> =

> On 07.05.2020 18:11, Mike Rapoport wrote:
> > On Thu, May 07, 2020 at 02:16:56PM +0200, Marek Szyprowski wrote:
> >> On 14.04.2020 17:34, Mike Rapoport wrote:
> >>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>
> >>> Implement primitives necessary for the 4th level folding, add walks o=
f p4d
> >>> level where appropriate, and remove __ARCH_USE_5LEVEL_HACK.
> >>>
> >>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> Today I've noticed that kexec is broken on ARM 32bit. Bisecting between
> >> current linux-next and v5.7-rc1 pointed to this commit. I've tested th=
is
> >> on Odroid XU4 and Raspberry Pi4 boards. Here is the relevant log:
> >>
> >> # kexec --kexec-syscall -l zImage --append "$(cat /proc/cmdline)"
> >> memory_range[0]:0x40000000..0xbe9fffff
> >> memory_range[0]:0x40000000..0xbe9fffff
> >> # kexec -e
> >> kexec_core: Starting new kernel
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address c010f1f4
> >> pgd =3D c6817793
> >> [c010f1f4] *pgd=3D4000041e(bad)
> >> Internal error: Oops: 80d [#1] PREEMPT ARM
> >> Modules linked in:
> >> CPU: 0 PID: 1329 Comm: kexec Tainted: G=A0=A0=A0=A0=A0=A0=A0 W
> >> 5.7.0-rc3-00127-g6cba81ed0f62 #611
> >> Hardware name: Samsung Exynos (Flattened Device Tree)
> >> PC is at machine_kexec+0x40/0xfc
> > Any chance you have the debug info in this kernel?
> > scripts/faddr2line would come handy here.
> =

> # ./scripts/faddr2line --list vmlinux machine_kexec+0x40
> machine_kexec+0x40/0xf8:
> =

> machine_kexec at arch/arm/kernel/machine_kexec.c:182
>  =A0177=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reboot_code_buffer =3D =

> page_address(image->control_code_page);
>  =A0178
>  =A0179=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Prepare parameters for reboot=
_code_buffer*/
>  =A0180=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_kernel_text_rw();
>  =A0181=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kexec_start_address =3D image->s=
tart;
>  >182<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kexec_indirection_page =3D page_list;
>  =A0183=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kexec_mach_type =3D machine_arch=
_type;
>  =A0184=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kexec_boot_atags =3D image->arch=
.kernel_r2;
>  =A0185
>  =A0186=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* copy our kernel relocation co=
de to the control code =

> page */
>  =A0187=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reboot_entry =3D fncpy(reboot_co=
de_buffer,

Can you please try the patch below:

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 963b5284d284..f86b3d17928e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -571,7 +571,7 @@ static inline void section_update(unsigned long addr, p=
mdval_t mask,
 {
 	pmd_t *pmd;
 =

-	pmd =3D pmd_off_k(addr);
+	pmd =3D pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), addr), add=
r), addr);
 =

 #ifdef CONFIG_ARM_LPAE
 	pmd[0] =3D __pmd((pmd_val(pmd[0]) & mask) | prot);

>  > ...
> =

> Best regards
> -- =

> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> =


-- =

Sincerely yours,
Mike.
