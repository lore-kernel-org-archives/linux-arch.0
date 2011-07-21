From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: Cross Memory Attach v3
Date: Thu, 21 Jul 2011 14:54:33 -0700
Message-ID: <20110721145433.a77818b2.akpm@linux-foundation.org>
References: <20110719003537.16b189ae@lilo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110719003537.16b189ae@lilo>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christopher Yeoh <cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, 19 Jul 2011 00:35:37 +0930
Christopher Yeoh <cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi Andrew,
> 
> Resending with CC's as you requested. Have added information about a man
> page and what is required for arches other than x86 and powerpc which
> have already been done.
> 
> Just as a reminder of what has happened so far, repeating some content
> from previous emails about it:
> 
> The basic idea behind cross memory attach is to allow MPI programs doing
> intra-node communication to do a single copy of the message rather than
> a double copy of the message via shared memory.
> 
> The following patch attempts to achieve this by allowing a
> destination process, given an address and size from a source process, to
> copy memory directly from the source process into its own address space
> via a system call. There is also a symmetrical ability to copy from 
> the current process's address space into a destination process's
> address space.
>
> ...
>
>  arch/powerpc/include/asm/systbl.h  |    2 
>  arch/powerpc/include/asm/unistd.h  |    4 
>  arch/x86/include/asm/unistd_32.h   |    4 
>  arch/x86/kernel/syscall_table_32.S |    2 
>  fs/aio.c                           |    4 
>  fs/compat.c                        |    7 
>  fs/read_write.c                    |    8 
>  include/linux/compat.h             |    3 
>  include/linux/fs.h                 |    7 
>  include/linux/syscalls.h           |   13 +
>  mm/Makefile                        |    3 
>  mm/process_vm_access.c             |  446 +++++++++++++++++++++++++++++++++++++
>  security/keys/compat.c             |    2 
>  security/keys/keyctl.c             |    2 
>  14 files changed, 490 insertions(+), 17 deletions(-)

Confused.  Why no arch/x86/include/asm/unistd_64.h wire-up?
--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
