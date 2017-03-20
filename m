From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] generic syscalls: Wire up statx syscall
Date: Mon, 20 Mar 2017 12:33:20 +0000
Message-ID: <20170320123320.GK17263@arm.com>
References: <20170313144521.28127-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313144521.28127-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 13, 2017 at 11:45:21PM +0900, Stafford Horne wrote:
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

As suggested by Arnd, I'll pick this up via arm64 for 4.11. I was on holiday
last week, so sorry for the delay.

Thanks,

Will
