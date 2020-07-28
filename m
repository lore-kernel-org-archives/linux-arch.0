From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: Re: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
Date: Tue, 28 Jul 2020 10:44:13 -0700
Message-ID: <7694af9d-dfb9-8c44-dc41-79f58bb14413@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
 <87365bg3nx.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87365bg3nx.fsf@x220.int.ebiederm.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-Id: linux-arch.vger.kernel.org



On 7/28/20 6:38 AM, ebiederm@xmission.com wrote:
> Anthony Yznaga <anthony.yznaga@oracle.com> writes:
>
>> A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
>> vmas only.  For safety, overlap with fixed address VMAs created in the new
>> mm during exec (e.g. the stack and elf load segments) is not permitted and
>> will cause the exec to fail.
>> (We are studying how to guarantee there are no conflicts. Comments welcome.)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 262112e5f9f8..1de09c4eef00 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>>  EXPORT_SYMBOL(read_code);
>>  #endif
>>  
>> +static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
>> +{
>> +	struct vm_area_struct *vma;
>> +	int ret;
>> +
>> +	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
>> +		if (vma->vm_flags & VM_EXEC_KEEP) {
>> +			ret = vma_dup(vma, new_mm);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Maps the mm_struct mm into the current task struct.
>>   * On success, this function returns with the mutex
>> @@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
>>  			mutex_unlock(&tsk->signal->exec_update_mutex);
>>  			return -EINTR;
>>  		}
>> +		ret = vma_dup_some(old_mm, mm);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Ouch! An unconditional loop through all of the vmas of the execing
> process, just in case there is a VM_EXEC_KEEP vma.
>
> I know we already walk the list in exit_mmap, but I get the feeling this
> will slow exec down when this feature is not enabled, especially when
> a process with a lot of vmas is calling exec.
Patch 4 changes this to only call vma_dup_some() if the new
binary has opted in to accepting preserved memory.

Anthony
>
>                 
>> +		if (ret) {
>> +			mmap_read_unlock(old_mm);
>> +			mutex_unlock(&tsk->signal->exec_update_mutex);
>> +			return ret;
>> +		}
>>  	}
>>  
>>  	task_lock(tsk);
