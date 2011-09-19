From: Dongdong Deng <libfetion@gmail.com>
Subject: Re: [PATCH v4 31/36] Hexagon: kgdb support files
Date: Mon, 19 Sep 2011 17:46:09 +0800
Message-ID: <CAGn38=0herzUuFyq7-4irgi8Myq0tibz0FGLiZY0GRq8iiO5kg@mail.gmail.com>
References: <e97c6e$3hno1n@wolverine02.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <e97c6e$3hno1n@wolverine02.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 15, 2011 at 2:19 AM, Richard Kuo <rkuo@codeaurora.org> wrot=
e:
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =C2=A0arch/hexagon/include/asm/kgdb.h | =C2=A0 43 +++++++
> =C2=A0arch/hexagon/kernel/kgdb.c =C2=A0 =C2=A0 =C2=A0| =C2=A0247 ++++=
+++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 290 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/hexagon/include/asm/kgdb.h
> =C2=A0create mode 100644 arch/hexagon/kernel/kgdb.c
>
> diff --git a/arch/hexagon/include/asm/kgdb.h b/arch/hexagon/include/a=
sm/kgdb.h
> new file mode 100644
> index 0000000..9e87797
> --- /dev/null
> +++ b/arch/hexagon/include/asm/kgdb.h
> @@ -0,0 +1,43 @@
> +/*
> + * arch/hexagon/include/asm/kgdb.h - Hexagon KGDB Support
> + *
> + * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +#ifndef __HEXAGON_KGDB_H__
> +#define __HEXAGON_KGDB_H__
> +
> +#define BREAK_INSTR_SIZE 4
> +#define CACHE_FLUSH_IS_SAFE =C2=A0 1
> +#define BUFMAX =C2=A0 =C2=A0 =C2=A0 ((NUMREGBYTES * 2) + 512)
> +
> +static inline void arch_kgdb_breakpoint(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 asm("trap0(#0xDB)");
> +}
> +
> +/* Registers:
> + * 32 gpr + sa0/1 + lc0/1 + m0/1 + gp + ugp + pred + pc =3D 42 total=
=2E
> + * vm regs =3D psp+elr+est+badva =3D 4
> + * syscall+restart =3D 2 more
> + * so 48 =3D 42 +4 + 2
> + */
> +#define DBG_USER_REGS 42
> +#define DBG_MAX_REG_NUM (DBG_USER_REGS + 6)
> +#define NUMREGBYTES =C2=A0(DBG_MAX_REG_NUM*4)
> +
> +#endif /* __HEXAGON_KGDB_H__ */
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> new file mode 100644
> index 0000000..603dbba
> --- /dev/null
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -0,0 +1,247 @@
> +/*
> + * arch/hexagon/kernel/kgdb.c - Hexagon KGDB Support
> + *
> + * Copyright (c) 2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +#include <linux/kdebug.h>
> +#include <linux/kgdb.h>
> +
> +/* All registers are 4 bytes, for now */
> +#define GDB_SIZEOF_REG 4
> +
> +/* The register names are used during printing of the regs;
> + * Keep these at three letters to pretty-print. */
> +struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =3D {
> + =C2=A0 =C2=A0 =C2=A0 { " r0", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r00)},
> + =C2=A0 =C2=A0 =C2=A0 { " r1", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r01)},
> + =C2=A0 =C2=A0 =C2=A0 { " r2", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r02)},
> + =C2=A0 =C2=A0 =C2=A0 { " r3", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r03)},
> + =C2=A0 =C2=A0 =C2=A0 { " r4", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r04)},
> + =C2=A0 =C2=A0 =C2=A0 { " r5", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r05)},
> + =C2=A0 =C2=A0 =C2=A0 { " r6", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r06)},
> + =C2=A0 =C2=A0 =C2=A0 { " r7", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r07)},
> + =C2=A0 =C2=A0 =C2=A0 { " r8", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r08)},
> + =C2=A0 =C2=A0 =C2=A0 { " r9", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r09)},
> + =C2=A0 =C2=A0 =C2=A0 { "r10", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r10)},
> + =C2=A0 =C2=A0 =C2=A0 { "r11", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r11)},
> + =C2=A0 =C2=A0 =C2=A0 { "r12", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r12)},
> + =C2=A0 =C2=A0 =C2=A0 { "r13", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r13)},
> + =C2=A0 =C2=A0 =C2=A0 { "r14", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r14)},
> + =C2=A0 =C2=A0 =C2=A0 { "r15", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r15)},
> + =C2=A0 =C2=A0 =C2=A0 { "r16", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r16)},
> + =C2=A0 =C2=A0 =C2=A0 { "r17", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r17)},
> + =C2=A0 =C2=A0 =C2=A0 { "r18", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r18)},
> + =C2=A0 =C2=A0 =C2=A0 { "r19", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r19)},
> + =C2=A0 =C2=A0 =C2=A0 { "r20", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r20)},
> + =C2=A0 =C2=A0 =C2=A0 { "r21", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r21)},
> + =C2=A0 =C2=A0 =C2=A0 { "r22", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r22)},
> + =C2=A0 =C2=A0 =C2=A0 { "r23", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r23)},
> + =C2=A0 =C2=A0 =C2=A0 { "r24", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r24)},
> + =C2=A0 =C2=A0 =C2=A0 { "r25", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r25)},
> + =C2=A0 =C2=A0 =C2=A0 { "r26", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r26)},
> + =C2=A0 =C2=A0 =C2=A0 { "r27", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r27)},
> + =C2=A0 =C2=A0 =C2=A0 { "r28", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r28)},
> + =C2=A0 =C2=A0 =C2=A0 { "r29", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r29)},
> + =C2=A0 =C2=A0 =C2=A0 { "r30", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r30)},
> + =C2=A0 =C2=A0 =C2=A0 { "r31", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, r31)},
> +
> + =C2=A0 =C2=A0 =C2=A0 { "usr", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, usr)},
> + =C2=A0 =C2=A0 =C2=A0 { "preds", GDB_SIZEOF_REG, offsetof(struct pt_=
regs, preds)},
> + =C2=A0 =C2=A0 =C2=A0 { " m0", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, m0)},
> + =C2=A0 =C2=A0 =C2=A0 { " m1", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, m1)},
> + =C2=A0 =C2=A0 =C2=A0 { "sa0", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, sa0)},
> + =C2=A0 =C2=A0 =C2=A0 { "sa1", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, sa1)},
> + =C2=A0 =C2=A0 =C2=A0 { "lc0", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, lc0)},
> + =C2=A0 =C2=A0 =C2=A0 { "lc1", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, lc1)},
> + =C2=A0 =C2=A0 =C2=A0 { " gp", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, gp)},
> + =C2=A0 =C2=A0 =C2=A0 { "ugp", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, ugp)},
> + =C2=A0 =C2=A0 =C2=A0 { "psp", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, hvmer.vmpsp)},
> + =C2=A0 =C2=A0 =C2=A0 { "elr", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, hvmer.vmel)},
> + =C2=A0 =C2=A0 =C2=A0 { "est", GDB_SIZEOF_REG, offsetof(struct pt_re=
gs, hvmer.vmest)},
> + =C2=A0 =C2=A0 =C2=A0 { "badva", GDB_SIZEOF_REG, offsetof(struct pt_=
regs, hvmer.vmbadva)},
> + =C2=A0 =C2=A0 =C2=A0 { "restart_r0", GDB_SIZEOF_REG, offsetof(struc=
t pt_regs, restart_r0)},
> + =C2=A0 =C2=A0 =C2=A0 { "syscall_nr", GDB_SIZEOF_REG, offsetof(struc=
t pt_regs, syscall_nr)},
> +};
> +
> +struct kgdb_arch arch_kgdb_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 /* trap0(#0xDB) 0x0cdb0054 */
> + =C2=A0 =C2=A0 =C2=A0 .gdb_bpt_instr =3D {0x54, 0x00, 0xdb, 0x0c},
> +};
> +
> +char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (regno >=3D DBG_MAX_REG_NUM || regno < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 *((unsigned long *) mem) =3D *((unsigned long =
*) ((void *)regs +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbg_reg_def[regno]=
=2Eoffset));
> +
> + =C2=A0 =C2=A0 =C2=A0 return dbg_reg_def[regno].name;
> +}
> +
> +int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (regno >=3D DBG_MAX_REG_NUM || regno < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 *((unsigned long *) ((void *)regs + dbg_reg_de=
f[regno].offset)) =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((unsigned long *=
) mem);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
> +{
> + =C2=A0 =C2=A0 =C2=A0 instruction_pointer(regs) =3D pc;
> +}
> +
> +#ifdef CONFIG_SMP
> +
> +/**
> + * kgdb_roundup_cpus - Get other CPUs into a holding pattern
> + * @flags: Current IRQ state
> + *
> + * On SMP systems, we need to get the attention of the other CPUs
> + * and get them be in a known state. =C2=A0This should do what is ne=
eded
> + * to get the other CPUs to call kgdb_wait(). Note that on some arch=
es,
> + * the NMI approach is not used for rounding up all the CPUs. For ex=
ample,
> + * in case of MIPS, smp_call_function() is used to roundup CPUs. In
> + * this case, we have to make sure that interrupts are enabled befor=
e
> + * calling smp_call_function(). The argument to this function is
> + * the flags that will be used when restoring the interrupts. There =
is
> + * local_irq_save() call before kgdb_roundup_cpus().
> + *
> + * On non-SMP systems, this is not called.
> + */
> +
> +static void hexagon_kgdb_nmi_hook(void *ignored)
> +{
> + =C2=A0 =C2=A0 =C2=A0 kgdb_nmicallback(raw_smp_processor_id(), get_i=
rq_regs());
> +}
> +
> +void kgdb_roundup_cpus(unsigned long flags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 smp_call_function(hexagon_kgdb_nmi_hook, NULL,=
 0);
> +}
> +#endif
> +
> +
> +/* =C2=A0Not yet working =C2=A0*/
> +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct task_struct *task)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pt_regs *thread_regs;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (task =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Initialize to zero */
> + =C2=A0 =C2=A0 =C2=A0 memset(gdb_regs, 0, NUMREGBYTES);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Otherwise, we have only some registers from=
 switch_to() */
> + =C2=A0 =C2=A0 =C2=A0 thread_regs =3D task_pt_regs(task);
> + =C2=A0 =C2=A0 =C2=A0 gdb_regs[0] =3D thread_regs->r00;
> +}
> +
> +/**
> + * kgdb_arch_handle_exception - Handle architecture specific GDB pac=
kets.
> + * @vector: The error vector of the exception that happened.
> + * @signo: The signal number of the exception that happened.
> + * @err_code: The error code of the exception that happened.
> + * @remcom_in_buffer: The buffer of the packet we have read.
> + * @remcom_out_buffer: The buffer of %BUFMAX bytes to write a packet=
 into.
> + * @regs: The &struct pt_regs of the current process.
> + *
> + * This function MUST handle the 'c' and 's' command packets,
> + * as well packets to set / remove a hardware breakpoint, if used.
> + * If there are additional packets which the hardware needs to handl=
e,
> + * they are handled here. =C2=A0The code should return -1 if it want=
s to
> + * process more packets, and a %0 or %1 if it wants to exit from the
> + * kgdb callback.
> + *
> + * Not yet working.
> + */
> +int kgdb_arch_handle_exception(int vector, int signo, int err_code,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *remcom_in_buffer, char *remcom=
_out_buffer,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pt_regs *linux_regs)
> +{
> + =C2=A0 =C2=A0 =C2=A0 switch (remcom_in_buffer[0]) {
> + =C2=A0 =C2=A0 =C2=A0 case 's':
> + =C2=A0 =C2=A0 =C2=A0 case 'c':
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* Stay in the debugger. */
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}
> +
> +static int __kgdb_notify(struct die_args *args, unsigned long cmd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pt_regs *regs =3D args->regs;
> +#if 0
> + =C2=A0 =C2=A0 =C2=A0 ret =3D kgdb_handle_exception(args->trapnr & 0=
xff, args->signr, args->err,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NOTIFY_DONE=
;
> +#endif



Hmm,  the key code of invoking kgdb_core was disabled by "#if 0".

Thanks,
Dongdong







> + =C2=A0 =C2=A0 =C2=A0 return NOTIFY_STOP;
> +}
> +
> +static int
> +kgdb_notify(struct notifier_block *self, unsigned long cmd, void *pt=
r)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 local_irq_save(flags);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D __kgdb_notify(ptr, cmd);
> + =C2=A0 =C2=A0 =C2=A0 local_irq_restore(flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static struct notifier_block kgdb_notifier =3D {
> + =C2=A0 =C2=A0 =C2=A0 .notifier_call =3D kgdb_notify,
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lowest-prio notifier priority, we want=
 to be notified last:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 .priority =3D -INT_MAX,
> +};
> +
> +/**
> + * kgdb_arch_init - Perform any architecture specific initalization.
> + *
> + * This function will handle the initalization of any architecture
> + * specific callbacks.
> + */
> +int kgdb_arch_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return register_die_notifier(&kgdb_notifier);
> +}
> +
> +/**
> + * kgdb_arch_exit - Perform any architecture specific uninitalizatio=
n.
> + *
> + * This function will handle the uninitalization of any architecture
> + * specific callbacks, for dynamic registration and unregistration.
> + */
> +void kgdb_arch_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unregister_die_notifier(&kgdb_notifier);
> +}
> +
> --
> 1.7.1
>
>
> --
>
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
