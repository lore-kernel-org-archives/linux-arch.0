From: Matt Turner <mattst88@gmail.com>
Subject: Re: [patch 01/14] alpha: invoke oom-killer from page fault
Date: Tue, 27 Apr 2010 23:30:46 -0400
Message-ID: <o2ub4198de61004272030v96788719w21b5dc024c1460be@mail.gmail.com>
References: <20100422160613.723698029@suse.de>
	 <20100422161222.762354051@suse.de>
	 <i2ob4198de61004271958xdb1f45e3o30f0e451bd192ea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63392 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0D1Dar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2010 23:30:47 -0400
In-Reply-To: <i2ob4198de61004271958xdb1f45e3o30f0e451bd192ea4@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>

On Tue, Apr 27, 2010 at 10:58 PM, Matt Turner <mattst88@gmail.com> wrot=
e:
> On Thu, Apr 22, 2010 at 12:06 PM, =A0<npiggin@suse.de> wrote:
>> As explained in commit 1c0fe6e3bd, we want to call the architecture =
independent
>> oom killer when getting an unexplained OOM from handle_mm_fault, rat=
her than
>> simply killing current.
>>
>> Cc: linux-alpha@vger.kernel.org
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Nick Piggin <npiggin@suse.de>
>> ---
>> Index: linux-2.6/arch/alpha/mm/fault.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/arch/alpha/mm/fault.c
>> +++ linux-2.6/arch/alpha/mm/fault.c
>> @@ -188,16 +188,10 @@ do_page_fault(unsigned long address, uns
>> =A0 =A0 =A0 =A0/* We ran out of memory, or some other thing happened=
 to us that
>> =A0 =A0 =A0 =A0 =A0 made us unable to handle the page fault graceful=
ly. =A0*/
>> =A0out_of_memory:
>> - =A0 =A0 =A0 if (is_global_init(current)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 yield();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&mm->mmap_sem);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto survive;
>> - =A0 =A0 =A0 }
>> - =A0 =A0 =A0 printk(KERN_ALERT "VM: killing process %s(%d)\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0current->comm, task_pid_nr(current));
>> =A0 =A0 =A0 =A0if (!user_mode(regs))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto no_context;
>> - =A0 =A0 =A0 do_group_exit(SIGKILL);
>> + =A0 =A0 =A0 pagefault_out_of_memory();
>> + =A0 =A0 =A0 return;
>>
>> =A0do_sigbus:
>> =A0 =A0 =A0 =A0/* Send a sigbus, regardless of whether we were in ke=
rnel
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-alph=
a" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> Thanks, added to my tree.
>
> Matt
>

=46YI: I had to kill off the now unused 'survive' label. Please check
this in my tree at
http://git.kernel.org/?p=3Dlinux/kernel/git/mattst88/alpha-2.6.git;a=3D=
summary
to make sure it's correct.

Matt
