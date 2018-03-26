From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] earlycon: Use a pointer table to fix __earlycon_table
 stride
Date: Mon, 26 Mar 2018 17:24:21 -0500
Message-ID: <20180326222421.bwkdakaofoixp562@rob-hp-laptop>
References: <20180320220536.20245-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320220536.20245-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, adurbin@chromium.org, linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 20, 2018 at 04:05:36PM -0600, Daniel Kurtz wrote:
> Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") tried to fix
> __earlycon_table stride by forcing the earlycon_id struct alignment to 32
> and asking the linker to 32-byte align the __earlycon_table symbol.  This
> fix was based on commit 07fca0e57fca92 ("tracing: Properly align linker
> defined symbols") which tried a similar fix for the tracing subsystem.
> 
> However, this fix doesn't quite work because there is no guarantee that
> gcc will place structures packed into an array format.  In fact, gcc 4.9
> chooses to 64-byte align these structs by inserting additional padding
> between the entries because it has no clue that they are supposed to be in
> an array.  If we are unlucky, the linker will assign symbol
> "__earlycon_table" to a 32-byte aligned address which does not correspond
> to the 64-byte aligned contents of section "__earlycon_table".
> 
> To address this same problem, the fix to the tracing system was
> subsequently re-implemented using a more robust table of pointers approach
> by commits:
>  3d56e331b653 ("tracing: Replace syscall_meta_data struct array with pointer array")
>  654986462939 ("tracepoints: Fix section alignment using pointer array")
>  e4a9ea5ee7c8 ("tracing: Replace trace_event struct array with pointer array")
> 
> Let's use this same "array of pointers to structs" approach for
> EARLYCON_TABLE.

Wouldn't every use of linker sections with structs have this problem? We 
use them for clocks, irqs, timers unless those have been fixed.

> 
> Fixes: 99492c39f39f ("earlycon: Fix __earlycon_table stride")
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Suggested-by: Aaron Durbin <adurbin@chromium.org>
> ---
> Changes since v2:
>  * Use __initconst instead of __initdata to avoid h8300 and alpha kbuild errors
> 
> Changes since v3:
>  * Fixed typos in commit message
> 
> Changes since v4:
>  * removed Change-Id: from commit message
> 
>  drivers/of/fdt.c                  |  7 +++++--
>  drivers/tty/serial/earlycon.c     |  6 ++++--
>  include/asm-generic/vmlinux.lds.h |  2 +-
>  include/linux/serial_core.h       | 21 ++++++++++++++-------
>  4 files changed, 24 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
