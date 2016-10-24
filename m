From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH 01/18] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Mon, 24 Oct 2016 12:30:47 -0400
Message-ID: <7d5ef8e8-38f1-92fe-b584-242cc2924558@mellanox.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-2-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-2-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kilobyte@angband.pl, manuel.montezelo@gmail.com, zhouchengming1@huawei.com, pinskia@gmail.com, szabolcs.nagy@arm.com, Nathan_Lynch@mentor.com, heiko.carstens@de.ibm.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, schwidefsky@de.ibm.com, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, linyongting@huawei.com, davem@davemloft.net, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On 10/21/2016 4:33 PM, Yury Norov wrote:
> All new 32-bit architectures should have 64-bit off_t type, but existing
> architectures has 32-bit ones.
>
> [...]
> For syscalls sys_openat() and sys_open_by_handle_at() force_o_largefile()
> is called, to set O_LARGEFILE flag, and this is the only difference
> comparing to compat versions. All compat ABIs are already turned to use
> 64-bit off_t, except tile. So, compat versions for this syscalls are not
> needed anymore. Tile is handled explicitly.
>
> [...]
> --- a/arch/tile/kernel/compat.c
> +++ b/arch/tile/kernel/compat.c
> @@ -103,6 +103,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
>   #define compat_sys_readahead sys32_readahead
>   #define sys_llseek compat_sys_llseek
>   
> +#define sys_openat             compat_sys_openat
> +#define sys_open_by_handle_at  compat_sys_open_by_handle_at
> +
>   /* Call the assembly trampolines where necessary. */
>   #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
>   #define sys_clone _sys_clone

This patch accomplishes two goals that could be completely separated.
It's confusing to have them mixed in the same patch without any
discussion of why they are in the same patch.

First, you want to modify the default <asm/unistd.h> behavior for
compat syscalls so that the default is sys_openat (etc) rather than
the existing compat_sys_openat, and then use that new behavior for
arm64 ILP32.  This lets you force O_LARGEFILE for arm64 ILP32 to
support having a 64-bit off_t at all times.  To do that, you fix the
asm-generic header, and then make tile have a special override.
This seems reasonable enough.

Second, you introduce ARCH_32BIT_OFF_T basically as a synonym for
"BITS_PER_WORD == 32", so that new 32-bit architectures can choose not
to enable it.  This is fine in the abstract, but I'm a bit troubled by
the fact that you are not actually introducing a new 32-bit
architecture here (just a new 32-bit mode for the arm 64-bit kernel).
Shouldn't this part of the change wait until someone actually has a
new 32-bit kernel to drive this forward?

If you want to push forward the ARCH_32BIT_OFF_T change in the absence
of an architecture that supports it, I would think it would be a lot
less confusing to have these two in separate patches, and make it
clear that the ARCH_32BIT_OFF_T change is just laying groundwork
for some hypothetical future architecture.

The existing commit language itself is also confusing. You write "All
compat ABIs are already turned to use 64-bit off_t, except tile."
First, I'm not sure what you mean by "turned" here.  And, tile is just
one of many compat ABIs that allow O_LARGEFILE not to be part of the
open call: see arm64's AArch32 ABI, MIPS o32, s390 31-bit emulation,
sparc64's 32-bit mode, and of course x86's 32-bit compat mode.
Presumably your point here is that tile is the only pre-existing
architecture that #includes <asm/unistd.h> to create its compat
syscall table, and so I think "all except tile" here is particularly
confusing, since there are no architectures except tile that use the
__SYSCALL_COMPAT functionality in the current tree.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
