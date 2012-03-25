From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/20 v2] m68k/mm/fault.c: Port OOM changes to do_page_fault
Date: Sun, 25 Mar 2012 11:13:11 +0200
Message-ID: <CAMuHMdVdhKANw2T0wQd_BXpWXWyUt-ozKoEP5GPH1zaQi6Y-dg@mail.gmail.com>
References: <1332259546-2037-1-git-send-email-consul.kautuk@gmail.com>
	<CAFPAmTTWtZGprAxfAd_k17Bip-cwpamLjAaQWRGfxgv+dwzK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAFPAmTTWtZGprAxfAd_k17Bip-cwpamLjAaQWRGfxgv+dwzK8w@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Kautuk,

On Sun, Mar 25, 2012 at 10:44, Kautuk Consul <consul.kautuk@gmail.com> =
wrote:
> did you get a chance to review this patch ?

Yes, I've just did. Sorry it took that long.
Looks good, so
Acked-by: <Geert Uytterhoeven <geert@linux-m68k.org>

BTW, what's the plan with this series? Will you take care of it, or sho=
uld
all arch maintainers take their parts?

> can I improve this patch in any way ?

There are a few more or less minor things:
  - You can remove "write" completely, as it's now superseded by
    FAULT_FLAG_WRITE in "flags",
  - Please also port the comments that were added to x86. They make
    life easier for the casual reader.

Thanks!

> On Tue, Mar 20, 2012 at 12:05 PM, Kautuk Consul <consul.kautuk@gmail.=
com> wrote:
>> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
>> (mm: retry page fault when blocking on disk transfer) and
>> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
>> (x86,mm: make pagefault killable)
>>
>> The above commits introduced changes into the x86 pagefault handler
>> for making the page fault handler retryable as well as killable.
>>
>> These changes reduce the mmap_sem hold time, which is crucial
>> during OOM killer invocation.
>>
>> Port these changes to m68k.
>>
>> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
>> ---
>> =C2=A0arch/m68k/mm/fault.c | =C2=A0 31 ++++++++++++++++++++++++++---=
--
>> =C2=A01 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
>> index 2db6099..27879bd 100644
>> --- a/arch/m68k/mm/fault.c
>> +++ b/arch/m68k/mm/fault.c
>> @@ -74,6 +74,7 @@ int do_page_fault(struct pt_regs *regs, unsigned l=
ong address,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm =3D current->mm;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vm_area_struct * vma;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int write, fault;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY=
 | FAULT_FLAG_KILLABLE;
>>
>> =C2=A0#ifdef DEBUG
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk ("do page fault:\nregs->sr=3D%#x, =
regs->pc=3D%#lx, address=3D%#lx, %ld, %p\n",
>> @@ -88,6 +89,7 @@ int do_page_fault(struct pt_regs *regs, unsigned l=
ong address,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (in_atomic() || !mm)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto no_conte=
xt;
>>
>> +retry:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0down_read(&mm->mmap_sem);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0vma =3D find_vma(mm, address);
>> @@ -126,6 +128,7 @@ good_area:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!(vma->vm_flags & VM_WRITE))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto acc_err;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0write++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flags |=3D FAULT_FLAG_WRITE;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1: =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* read, present */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto acc_err;
>> @@ -140,10 +143,14 @@ good_area:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the fault.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>
>> - =C2=A0 =C2=A0 =C2=A0 fault =3D handle_mm_fault(mm, vma, address, w=
rite ? FAULT_FLAG_WRITE : 0);
>> + =C2=A0 =C2=A0 =C2=A0 fault =3D handle_mm_fault(mm, vma, address, f=
lags);
>> =C2=A0#ifdef DEBUG
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk("handle_mm_fault returns %d\n",fau=
lt);
>> =C2=A0#endif
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if ((fault & VM_FAULT_RETRY) && fatal_signal_=
pending(current))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(fault & VM_FAULT_ERROR)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fault & V=
M_FAULT_OOM)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto out_of_memory;
>> @@ -151,10 +158,24 @@ good_area:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto bus_err;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> - =C2=A0 =C2=A0 =C2=A0 if (fault & VM_FAULT_MAJOR)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current->maj_flt+=
+;
>> - =C2=A0 =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current->min_flt+=
+;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (flags & FAULT_FLAG_ALLOW_RETRY) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault & VM_FA=
ULT_MAJOR)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 current->maj_flt++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 current->min_flt++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault & VM_FA=
ULT_RETRY) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 flags &=3D ~FAULT_FLAG_ALLOW_RETRY;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* No need to up_read(&mm->mmap_sem) as we would
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* have already released it in __lock_page_or_retry
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* in mm/filemap.c.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto retry;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0up_read(&mm->mmap_sem);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
