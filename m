From: Christopher Yeoh <cyeoh@au1.ibm.com>
Subject: Re: Cross Memory Attach v3
Date: Mon, 25 Jul 2011 16:32:07 +0930
Message-ID: <20110725163207.27336094@lilo>
References: <20110719003537.16b189ae@lilo>
	<20110721145433.a77818b2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20110721145433.a77818b2.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 21 Jul 2011 14:54:33 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > The following patch attempts to achieve this by allowing a
> > destination process, given an address and size from a source
> > process, to copy memory directly from the source process into its
> > own address space via a system call. There is also a symmetrical
> > ability to copy from the current process's address space into a
> > destination process's address space.
> >
> > ...
> >
> >  arch/powerpc/include/asm/systbl.h  |    2 
> >  arch/powerpc/include/asm/unistd.h  |    4 
> >  arch/x86/include/asm/unistd_32.h   |    4 
> >  arch/x86/kernel/syscall_table_32.S |    2 
> >  fs/aio.c                           |    4 
> >  fs/compat.c                        |    7 
> >  fs/read_write.c                    |    8 
> >  include/linux/compat.h             |    3 
> >  include/linux/fs.h                 |    7 
> >  include/linux/syscalls.h           |   13 +
> >  mm/Makefile                        |    3 
> >  mm/process_vm_access.c             |  446
> > +++++++++++++++++++++++++++++++++++++
> > security/keys/compat.c             |    2
> > security/keys/keyctl.c             |    2 14 files changed, 490
> > insertions(+), 17 deletions(-)
> 
> Confused.  Why no arch/x86/include/asm/unistd_64.h wire-up?

I forgot. Have done this now as well as the 32-bit compat and am
retesting....

Chris
-- 
cyeoh@au.ibm.com

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
