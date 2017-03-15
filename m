Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36793 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753895AbdCOW0f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2017 18:26:35 -0400
Received: by mail-yw0-f193.google.com with SMTP id 2so2898703ywn.3
        for <linux-arch@vger.kernel.org>; Wed, 15 Mar 2017 15:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170313144521.28127-1-shorne@gmail.com>
References: <20170313144521.28127-1-shorne@gmail.com>
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 15 Mar 2017 22:26:32 +0000
Message-ID: <CAAG0J99QAwefvpnNxrGRU6XH+0+k1LO6qRW3kLBQCc3nc6QdmA@mail.gmail.com>
Subject: Re: [PATCH v2] generic syscalls: Wire up statx syscall
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20170315222632.EJrAXGyndYsgpW5sUOAg_s6LTQab3OftLhVPW7434TE@z>

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
