From: Ingo Molnar <mingo@kernel.org>
Subject: Re: improve compat handling for the i386 u64 alignment quirk v2
Date: Thu, 6 Aug 2020 15:50:36 +0200
Message-ID: <20200806135036.GA2077896@gmail.com>
References: <20200731122202.213333-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> the i386 ABI is a little special in that it uses less than natural
> alignment for 64-bit integer types (u64 and s64), and a significant
> amount of our compat handlers deals with just that.  Unfortunately
> there is no good way to check for this specific quirk at runtime,
> similar how in_compat_syscall() checks for a compat syscall.  This
> series adds such a check, and then uses the quota code as an example
> of how this improves the compat handling.  I have a few other places
> in mind where this will also be useful going forward.
> 
> Changes since v1:
>  - use asm-generic/compat.h instead of linux/compat.h for
>    compat_u64 and compat_s64
>  - fix a typo
> 
> Diffstat:
>  b/arch/arm64/include/asm/compat.h        |    2 
>  b/arch/mips/include/asm/compat.h         |    2 
>  b/arch/parisc/include/asm/compat.h       |    2 
>  b/arch/powerpc/include/asm/compat.h      |    2 
>  b/arch/s390/include/asm/compat.h         |    2 
>  b/arch/sparc/include/asm/compat.h        |    3 
>  b/arch/x86/entry/syscalls/syscall_32.tbl |    2 
>  b/arch/x86/include/asm/compat.h          |    3 
>  b/fs/quota/Kconfig                       |    5 -
>  b/fs/quota/Makefile                      |    1 
>  b/fs/quota/compat.h                      |   34 ++++++++
>  b/fs/quota/quota.c                       |   73 +++++++++++++++---
>  b/include/asm-generic/compat.h           |    8 ++
>  b/include/linux/compat.h                 |    9 ++
>  b/include/linux/quotaops.h               |    3 
>  b/kernel/sys_ni.c                        |    1 
>  fs/quota/compat.c                        |  120 -------------------------------
>  17 files changed, 113 insertions(+), 159 deletions(-)

If nobody objects to this being done at runtime, and if it's 100% ABI 
compatible, then the x86 impact looks good to me:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
