From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Date: Sun, 3 May 2020 10:41:38 -0700
Message-ID: <20200503174138.GA114085@roeck-us.net>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200429121126.17989-18-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Ley Foon Tan <ley.foon.tan@intel.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hoan Tran <Hoan>
List-Id: linux-arch.vger.kernel.org

Hi,

On Wed, Apr 29, 2020 at 03:11:23PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
> ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
> sorted in descending order allows using free_area_init() on such
> architectures.
> 
> Add top -> down traversal of max_zone_pfn array in free_area_init() and use
> the latter in ARC node/zone initialization.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

This patch causes my microblazeel qemu boot test in linux-next to fail.
Reverting it fixes the problem.

qemu command line:

qemu-system-microblazeel -M petalogix-ml605 -m 256 \
	-kernel arch/microblaze/boot/linux.bin -no-reboot \
	-initrd rootfs.cpio \
	-append 'panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0,115200' \
	-monitor none -serial stdio -nographic

initrd:
	https://github.com/groeck/linux-build-test/blob/master/rootfs/microblazeel/rootfs.cpio.gz
configuration:
	https://github.com/groeck/linux-build-test/blob/master/rootfs/microblazeel/qemu_microblazeel_ml605_defconfig

Bisect log is below.

Guenter

---
# bad: [fb9d670f57e3f6478602328bbbf71138be06ca4f] Add linux-next specific files for 20200501
# good: [6a8b55ed4056ea5559ebe4f6a4b247f627870d4c] Linux 5.7-rc3
git bisect start 'HEAD' 'v5.7-rc3'
# good: [068b80b68a670f0b17288c8a3d1ee751f35162ab] Merge remote-tracking branch 'drm/drm-next'
git bisect good 068b80b68a670f0b17288c8a3d1ee751f35162ab
# good: [46c70fc6a3ac35cd72ddad248dcbe4eee716d2a5] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect good 46c70fc6a3ac35cd72ddad248dcbe4eee716d2a5
# good: [f39c4ad479a2f005f972a2b941b40efa6b9c9349] Merge remote-tracking branch 'rpmsg/for-next'
git bisect good f39c4ad479a2f005f972a2b941b40efa6b9c9349
# bad: [165d3ee0162fe28efc2c8180176633e33515df15] ipc-convert-ipcs_idr-to-xarray-update
git bisect bad 165d3ee0162fe28efc2c8180176633e33515df15
# good: [001f1d211ed2ed0f005838dc4390993930bbbd69] mm: remove early_pfn_in_nid() and CONFIG_NODES_SPAN_OTHER_NODES
git bisect good 001f1d211ed2ed0f005838dc4390993930bbbd69
# bad: [aaad7401bd32f10c1d591dd886b3a9b9595c6d77] mm/vmsan: fix some typos in comment
git bisect bad aaad7401bd32f10c1d591dd886b3a9b9595c6d77
# bad: [09f9d0ab1fbed85623b283995aa7a7d78daa1611] khugepaged: allow to collapse PTE-mapped compound pages
git bisect bad 09f9d0ab1fbed85623b283995aa7a7d78daa1611
# bad: [c942fc8a3e5088407bc32d94f554bab205175f8a] mm/vmstat.c: do not show lowmem reserve protection information of empty zone
git bisect bad c942fc8a3e5088407bc32d94f554bab205175f8a
# bad: [b29358d269ace3826d8521bea842fc2984cfc11b] mm/page_alloc.c: rename free_pages_check() to check_free_page()
git bisect bad b29358d269ace3826d8521bea842fc2984cfc11b
# bad: [be0fb591a1f1df20a00c8f023f9ca4891f177b0d] mm: simplify find_min_pfn_with_active_regions()
git bisect bad be0fb591a1f1df20a00c8f023f9ca4891f177b0d
# bad: [c17422a008d36dcf3e9f51469758c5762716cb0a] mm: rename free_area_init_node() to free_area_init_memoryless_node()
git bisect bad c17422a008d36dcf3e9f51469758c5762716cb0a
# bad: [51a2f644fd020d5f090044825c388444d11029d5] mm: free_area_init: allow defining max_zone_pfn in descending order
git bisect bad 51a2f644fd020d5f090044825c388444d11029d5
# first bad commit: [51a2f644fd020d5f090044825c388444d11029d5] mm: free_area_init: allow defining max_zone_pfn in descending order
