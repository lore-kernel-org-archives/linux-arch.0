From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH v6 20/36] nds32: Signal handling support
Date: Tue, 6 Feb 2018 14:39:38 +0800
Message-ID: <CAJsyPhxmZx_S=imSxDyW3POhRcHd66q1p0kkX0B4f-W2APxJkA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e145c39b3c50b3aee05bc60ad0117f1ec7cc5153.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ@mail.gmail.com>
 <CAJsyPhyGpJVQegd7ns9oZOjM=XsGVixCQaH9nT_jOQsSpyRs+g@mail.gmail.com> <CAK8P3a0eeJKAOZjJ-XVQwLOCuVzSqdUtCaS4F90zZ=WvRQ8sBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0eeJKAOZjJ-XVQwLOCuVzSqdUtCaS4F90zZ=WvRQ8sBQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Thanks, I got it.

After referring to arm64 and risc-v, we try to refine our code, such as
removing unneeded checking and refining syscall restart flow. We
hope these modifications can enhance the reliability and readability.
However, the following 2 files which you had acked are included in
this modification.
1. arch/nds32/include/asm/nds32.h
    (patch: Assembly macros and definitions)
     The definition of  macro tbl and why are removed.
       - Now, we use pt_reg->syscallno instead of 'why' to determine
         whether entering kernel is via syscall or not. Therefore, macro
         'why' is unneeded.

--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -66,10 +66,6 @@ static inline unsigned long CACHE_LINE_SIZE

 #endif /* __ASSEMBLY__ */

-/* tbl and why is used in ex-scall.S and ex-exit.S */
-#define tbl $r8
-#define why $r8
-
 #define IVB_BASE               PHYS_OFFSET


2. arch/nds32/kernel/ex-scall.S    (patch: System calls handling)
    a. Define macro tbl
        - The marco tbl is used only in this file. So, I move its definition
          from arch/nds32/include/asm/nds32.h to here.
    b. Remove 'set why = 0'  when issuing syscall number is invalid
    c. Adjust input arguments of syscall_trace_enter

--- a/arch/nds32/kernel/ex-scall.S
+++ b/arch/nds32/kernel/ex-scall.S
...
+#define tbl $r8

 /*
  * $r7 will be writen as syscall nr
- * by retrieving from $ITYPE 'SWID' bitfiled
  */
        .macro  get_scno
        lwi     $r7, [$sp + R15_OFFSET]
@@ -54,7 +49,6 @@ ENTRY(eh_syscall)
        get_scno
        gie_enable

-ENTRY(eh_syscall_phase_2)
        lwi     $p0, [tsk+#TSK_TI_FLAGS]

        andi    $p1, $p0, #_TIF_WORK_SYSCALL_ENTRY
@@ -71,7 +65,6 @@ jmp_systbl:
        jr      $p1                             ! no return

 _SCNO_EXCEED:
-       movi    why, 0
        ori     $r0, $r7, #0
        ori    $r1, $sp, #0
        b       bad_syscall
@@ -81,8 +74,7 @@ _SCNO_EXCEED:
  * context switches, and waiting for our parent to respond.
  */
 __sys_trace:
-       move    $r1, $sp
-       move    $r0, $r7                        ! trace entry [IP = 0]
+       move    $r0, $sp
        bal     syscall_trace_enter
        move    $r7, $r0
        la      $lp, __sys_trace_return         ! return address


If you think these modifications in acked files are not permitted,
we will recover it.

We verify all modifications by LTP 2017 related cases and glibc
2.26 testsuite. We plan to add it in the next version patch and
hope you can give us some comments as before.

Thanks

Vincent



2018-01-24 19:13 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 24, 2018 at 1:56 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>> 2018-01-18 18:30 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> From: Greentime Hu <greentime@andestech.com>
>>>>
>>>> This patch adds support for signal handling.
>>>>
>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>
>>> I never feel qualified enough to properly review signal handling code, so
>>> no Ack from me for this code even though I don't see anything wrong with it.
>>> Hopefully someone else can give an Ack after looking more closely.
>>>
>>
>> Dear Arnd:
>>
>> We'd be glad to improve signal handling code to meet your requirement.
>> Could you
>> tell us which part we need to refine or which implementation is good
>> for us to refer?
>
> No, as I said, the problem is on my side, I just don't understand enough of it.
> I would assume that the arm64 and risc-v implementations are the most
> thoroughly reviewed, but haven't looked at those in enough detail either.
> If your code does something that risc-v doesn't do, try to understand whether
> there should be a difference or not.
>
>       Arnd
