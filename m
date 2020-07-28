From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
Date: Tue, 28 Jul 2020 08:38:58 -0500
Message-ID: <87365bg3nx.fsf@x220.int.ebiederm.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
        <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:48638 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgG1NmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 09:42:13 -0400
In-Reply-To: <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
        (Anthony Yznaga's message of "Mon, 27 Jul 2020 10:11:25 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com

Anthony Yznaga <anthony.yznaga@oracle.com> writes:

> A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
> vmas only.  For safety, overlap with fixed address VMAs created in the new
> mm during exec (e.g. the stack and elf load segments) is not permitted and
> will cause the exec to fail.
> (We are studying how to guarantee there are no conflicts. Comments welcome.)
>

> diff --git a/fs/exec.c b/fs/exec.c
> index 262112e5f9f8..1de09c4eef00 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  EXPORT_SYMBOL(read_code);
>  #endif
>  
> +static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
> +{
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
> +		if (vma->vm_flags & VM_EXEC_KEEP) {
> +			ret = vma_dup(vma, new_mm);
> +			if (ret)
> +				return ret;
> +		}
> +	return 0;
> +}
> +
>  /*
>   * Maps the mm_struct mm into the current task struct.
>   * On success, this function returns with the mutex
> @@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
>  			mutex_unlock(&tsk->signal->exec_update_mutex);
>  			return -EINTR;
>  		}
> +		ret = vma_dup_some(old_mm, mm);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ouch! An unconditional loop through all of the vmas of the execing
process, just in case there is a VM_EXEC_KEEP vma.

I know we already walk the list in exit_mmap, but I get the feeling this
will slow exec down when this feature is not enabled, especially when
a process with a lot of vmas is calling exec.

                
> +		if (ret) {
> +			mmap_read_unlock(old_mm);
> +			mutex_unlock(&tsk->signal->exec_update_mutex);
> +			return ret;
> +		}
>  	}
>  
>  	task_lock(tsk);
