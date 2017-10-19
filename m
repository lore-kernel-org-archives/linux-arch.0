From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: Re: [PATCH 4/4][PoC][RFC] Allow to trace fd usage with
 rlimit-events
Date: Thu, 19 Oct 2017 19:28:21 +0200
Message-ID: <e9dd8610-abb3-2247-666d-e12fd656c2d6@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203342epcas1p23933a20a33807f92c716433374374397@epcas1p2.samsung.com>
        <20171018203230.29871-5-k.opasiak@samsung.com>
        <20171018230521.GP21978@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171018230521.GP21978@ZenIV.linux.org.uk>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
List-Id: linux-arch.vger.kernel.org

Hi,

On 10/19/2017 01:05 AM, Al Viro wrote:
> On Wed, Oct 18, 2017 at 10:32:30PM +0200, Krzysztof Opasiak wrote:
> 
>> @@ -417,7 +417,7 @@ static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
>>   	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
>>   	unlock_task_sighand(proc->tsk, &irqs);
>>   
>> -	return __alloc_fd(files, 0, rlim_cur, flags);
>> +	return __alloc_fd(proc->tsk, 0, rlim_cur, flags);
> 
> Who said that proc->files will remain equal to proc->tsk->files?
> 
>> -static void __put_unused_fd(struct files_struct *files, unsigned int fd)
>> +static void __put_unused_fd(struct task_struct *owner, unsigned int fd)
>>   {
>> +	struct files_struct *files = owner->files;
>>   	struct fdtable *fdt = files_fdtable(files);
>>   	__clear_open_fd(fd, fdt);
>>   	if (fd < files->next_fd)
>>   		files->next_fd = fd;
>> +
>> +	if (rlimit_noti_watch_active(owner, RLIMIT_NOFILE)) {
>> +		unsigned int count;
>> +
>> +		count = count_open_fds(fdt);
>> +		rlimit_noti_res_changed(owner, RLIMIT_NOFILE, count + 1, count);
>> +	}
>>   }
> 
> [... and similar for other __...fd() primitives]
> This is blatantly wrong - you *CAN'T* modify files_struct unless it's
> 	a) yours (i.e. current->files) or
> 	b) you've had its refcount incremented for you by some process that
> did, at the time, have current->files pointing to it.
> 
> There is a reason why binder keeps ->files explicitly, rather than going through
> ->tsk->files.

Your are perfectly right! Thank you very much for catching this.

To be honest, initially I just added the struct task_struct ptr to the 
argument list keeping that in mind. Then when I was cleaning up patches 
before sending I found this to look a litlle bit odd and forgot that I 
did this on purpose because tsk->files can be reassigned and that's why 
I removed the files param.

I'll fix this for v2. Thanks once again.

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
