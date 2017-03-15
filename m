From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2] generic syscalls: Wire up statx syscall
Date: Wed, 15 Mar 2017 22:26:32 +0000
Message-ID: <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
References: <20170313144521.28127-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170313144521.28127-1-shorne@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stafford Horne <shorne@gmail.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 13 March 2017 at 14:45, Stafford Horne <shorne@gmail.com> wrote:
> The new syscall statx is implemented as generic code, so enable it
> for architectures like openrisc which use the generic syscall table.
>
> Fixes: a528d35e8bfcc ("statx: Add a system call to make enhanced file info available")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Change in v2:
>  - Add a few more Cc's to get attention of the right people
>  - Add a fixes tag for better audit
>
>  include/uapi/asm-generic/unistd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 9b1462e..a076cf1 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -730,9 +730,11 @@ __SYSCALL(__NR_pkey_mprotect, sys_pkey_mprotect)
>  __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
>  #define __NR_pkey_free 290
>  __SYSCALL(__NR_pkey_free,     sys_pkey_free)
> +#define __NR_statx 291
> +__SYSCALL(__NR_statx,     sys_statx)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 291
> +#define __NR_syscalls 292

Out of interest, anybody know OTOH which other stat syscalls statx
supersedes (such that they could at some point be disabled by default
in asm-generic for new arches, and implemented in userspace)?

Cheers
-- 
James Hogan
