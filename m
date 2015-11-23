From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 12:16:36 -0800
Message-ID: <20151123201635.GB27783@x>
References: <5868782.RxZY0W5S4d@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5868782.RxZY0W5S4d@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Two comments inline below.

On Mon, Nov 23, 2015 at 05:25:28PM +0100, Arnd Bergmann wrote:
> When CONFIG_BUG is disabled, BUG_ON() will only evaluate the condition,
> but will not actually stop the current thread. GCC warns about a couple
> of BUG_ON() users where this actually leads to further undefined
> behavior:
> 
> include/linux/ceph/osdmap.h: In function 'ceph_can_shift_osds':
> include/linux/ceph/osdmap.h:54:1: warning: control reaches end of non-void function
> fs/ext4/inode.c: In function 'ext4_map_blocks':
> fs/ext4/inode.c:548:5: warning: 'retval' may be used uninitialized in this function
> drivers/mfd/db8500-prcmu.c: In function 'prcmu_config_clkout':
> drivers/mfd/db8500-prcmu.c:762:10: warning: 'div_mask' may be used uninitialized in this function
> drivers/mfd/db8500-prcmu.c:769:13: warning: 'mask' may be used uninitialized in this function
> drivers/mfd/db8500-prcmu.c:757:7: warning: 'bits' may be used uninitialized in this function
> drivers/tty/serial/8250/8250_core.c: In function 'univ8250_release_irq':
> drivers/tty/serial/8250/8250_core.c:252:18: warning: 'i' may be used uninitialized in this function
> drivers/tty/serial/8250/8250_core.c:235:19: note: 'i' was declared here

Eliminating the spurious warnings seems like a good reason to do this.

> There is an obvious conflict of interest here: on the one hand, someone
> who disables CONFIG_BUG() will want the kernel to be as small as possible
> and doesn't care about printing error messages to a console that nobody
> looks at. On the other hand, running into a BUG_ON() condition means that
> something has gone wrong, and we probably want to also stop doing things
> that might cause data corruption.

Seems like you should adjust the Kconfig description for 'config BUG' in
init/Kconfig to account for BUG/BUG_ON still stopping the machine.

(For that matter, I can't help but wonder if we could then consolidate
CONFIG_BUG and CONFIG_DEBUG_BUGVERBOSE, since we now only semantically
change whether and how much we print.  However, that could happen in
another patch.)

> This patch picks the second choice, and changes the NOP to BUG(), which
> normally stops the execution of the current thread in some form (endless
> loop or a trap). This follows the logic we applied in a4b5d580e078 ("bug:
> Make BUG() always stop the machine").
> 
> For ARM multi_v7_defconfig, the size slightly increases:
> 
> section		CONFIG_BUG=y	CONFIG_BUG=n	CONFIG_BUG=n+patch
> 
>   .text            8320248   |     8180944   |     8207688
>   .rodata          3633720   |     3567144   |     3570648
>   __bug_table        32508   |         ---   |         ---
>   __modver             692   |        1584   |        2176
>   .init.text        558132   |      548300   |      550088
>   .exit.text         12380   |       12256   |       12380
>   .data            1016672   |     1016064   |     1016128
>   Total           14622556   |    14374510   |    14407326
> 
> So instead of saving 1.70% of the total image size, we only save 1.48%

Could you please include numbers for tinyconfig as well?  Percentages
get larger when the numbers get smaller.

> by turning off CONFIG_BUG, but in return we can ensure that we don't run
> into cases of uninitialized variable or return code uses when something
> bad happens. Aside from that, we significantly reduce the number of
> warnings in randconfig builds, which makes it easier to fix the warnings
> about other problems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 630dd2372238..58bd1f08c5c7 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -142,7 +142,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>  #endif
>  
>  #ifndef HAVE_ARCH_BUG_ON
> -#define BUG_ON(condition) do { if (condition) ; } while (0)
> +#define BUG_ON(condition) do { if (condition) BUG(); } while (0)

This makes BUG_ON in the !CONFIG_BUG case almost identical to the
CONFIG_BUG=y case, except for the use of unlikely(condition), which this
ought to do as well.

Given that, could you pull the definition *out* of the #ifdef/#else for
CONFIG_BUG entirely, and define it the same way in both cases?

- Josh Triplett
