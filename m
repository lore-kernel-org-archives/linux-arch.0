Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:49718 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKTU3I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 15:29:08 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20191118145114.GA9228@avx2>
        <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
        <20191118215227.GA24536@avx2> <20191120191752.GC4799@willie-the-truck>
Date: Wed, 20 Nov 2019 14:28:37 -0600
In-Reply-To: <20191120191752.GC4799@willie-the-truck> (Will Deacon's message
        of "Wed, 20 Nov 2019 19:17:52 +0000")
Message-ID: <87d0dm47ii.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] exec: warn if process starts with executable stack
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org, ben.dooks@codethink.co.uk
Message-ID: <20191120202837.q2yDCJatdZYkRXFulETzh9b2UDWlq-AhvWlJ2Ph2p7w@z>

Will Deacon <will@kernel.org> writes:

> On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
>> There were few episodes of silent downgrade to an executable stack:
>> 
>> 1) linking innocent looking assembly file
>> 
>> 	$ cat f.S
>> 	.intel_syntax noprefix
>> 	.text
>> 	.globl f
>> 	f:
>> 	        ret
>> 
>> 	$ cat main.c
>> 	void f(void);
>> 	int main(void)
>> 	{
>> 	        f();
>> 	        return 0;
>> 	}
>> 
>> 	$ gcc main.c f.S
>> 	$ readelf -l ./a.out
>> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>>                          0x0000000000000000 0x0000000000000000  RWE    0x10
>> 
>> 2) converting C99 nested function into a closure
>> https://nullprogram.com/blog/2019/11/15/
>> 
>> 	void intsort2(int *base, size_t nmemb, _Bool invert)
>> 	{
>> 	    int cmp(const void *a, const void *b)
>> 	    {
>> 	        int r = *(int *)a - *(int *)b;
>> 	        return invert ? -r : r;
>> 	    }
>> 	    qsort(base, nmemb, sizeof(*base), cmp);
>> 	}
>> 
>> will silently require stack trampolines while non-closure version will not.
>> 
>> While without a double this behaviour is documented somewhere, add a warning
>> so that developers and users can at least notice. After so many years of x86_64
>> having proper executable stack support it should not cause too much problems.
>> 
>> If the system is old or CPU is old, then there will be an early warning
>> against init and/or support personnel will write that "uh-oh, our Enterprise
>> Software absolutely requires executable stack" and close tickets and customers
>> will nod heads and life moves on.
>> 
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> ---
>> 
>>  fs/exec.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -762,6 +762,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
>>  		goto out_unlock;
>>  	BUG_ON(prev != vma);
>>  
>> +	if (vm_flags & VM_EXEC) {
>> +		pr_warn_once("process '%s'/%u started with executable stack\n",
>> +			     current->comm, current->pid);
>> +	}
>
> Given that this is triggerable by userspace, is there a concern about PID
> namespaces here?

In what sense?  Are you thinking about the printing of the pid?

Pretty much by fiat and by definition the kernel log always print things
in the initial pid namespace.  Which this printk does.

Eric
