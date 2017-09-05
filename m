From: Jessica Yu <jeyu@kernel.org>
Subject: Re: kernel: tracepoints: add support for relative references
Date: Tue, 5 Sep 2017 14:48:13 +0200
Message-ID: <20170905124812.yzjm2gkxj5lkynuq@redbean>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org>
 <20170819181035.969-6-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170819181035.969-6-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rosted>
List-Id: linux-arch.vger.kernel.org

+++ Ard Biesheuvel [19/08/17 19:10 +0100]:
>To avoid the need for relocating absolute references to tracepoint
>structures at boot time when running relocatable kernels (which may
>take a disproportionate amount of space), add the option to emit
>these tables as relative references instead.
>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Ingo Molnar <mingo@redhat.com>
>Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi Ard,

While testing this patchset I ran into the following general protection
fault when removing a module with tracepoints:

# rmmod kvm
[   25.279049] general protection fault: 0000 [#1] SMP
[   25.279385] Modules linked in: kvm(-) irqbypass
[   25.279829] CPU: 0 PID: 125 Comm: rmmod Not tainted 4.13.0-rc2+ #1
[   25.280007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
[   25.280315] task: ffff9697db7c0000 task.stack: ffffa907802dc000
[   25.280624] RIP: 0010:tracepoint_module_notify+0xd5/0x1d0
[   25.280782] RSP: 0018:ffffa907802dfe68 EFLAGS: 00000287
[   25.280963] RAX: ffffffffc02b6fb0 RBX: ffff9697ddb33440 RCX: ffffffffc02b70f0
[   25.281168] RDX: 000163cc00016410 RSI: ffff9697df21d860 RDI: ffff9697de001900
[   25.281371] RBP: ffffa907802dfe88 R08: 000000000001d860 R09: ffffffff941692b4
[   25.281543] R10: fffff0ec4076ccc0 R11: 0000000000000300 R12: ffffffffc02ce740
[   25.281716] R13: 0000000000000002 R14: ffffffffc02ce740 R15: 0000000000000000
[   25.281917] FS:  0000000000a6e880(0000) GS:ffff9697df200000(0000) knlGS:0000000000000000
[   25.282107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.282254] CR2: 00000000004adfc0 CR3: 000000001f838000 CR4: 00000000000006f0
[   25.282517] Call Trace:
[   25.283019]  notifier_call_chain+0x4a/0x70
[   25.283287]  blocking_notifier_call_chain+0x43/0x60
[   25.283422]  SyS_delete_module+0x1b8/0x240
[   25.283542]  ? SyS_chdir+0xc4/0xe0
[   25.283648]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[   25.283863] RIP: 0033:0x4ba267
[   25.283947] RSP: 002b:00007ffc3316bdf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b0
[   25.284134] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004ba267
[   25.284310] RDX: 0000000000000000 RSI: 0000000000000880 RDI: 00007ffc3316be00
[   25.284511] RBP: 00007ffc3316be40 R08: 0000000000000003 R09: 0000000000000000
[   25.284699] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000637672
[   25.284916] R13: 00007ffc3316c1b0 R14: 0000000000000000 R15: 0000000000000000
[   25.285226] Code: 00 48 89 43 08 e8 9c b4 0d 00 49 8b 84 24 90 02 00 00 48 85 c0 74 28 41 8b 94 24 8c 02 00 00 48 8d 0c d0 48 39 c8 73 17 48 8b 10 <48> 83 7a 28 00 0f 85 e8 00 00 00 48 83 c0 08 48 39 c1 77 e9 48 
[   25.286199] RIP: tracepoint_module_notify+0xd5/0x1d0 RSP: ffffa907802dfe68
[   25.286708] ---[ end trace 04f35cade1663177 ]---

The offending line is in tp_module_going_check_quiescent() (shown inlined):

(gdb) list *(tracepoint_module_notify+0xd5)
0xffffffff811692d5 is in tracepoint_module_notify (/home/jeyu/work/jeyu-linux/kernel/tracepoint.c:402).
397             struct tracepoint * const *iter;
398
399             if (!begin)
400                     return;
401             for (iter = begin; iter < end; iter++)
402                     WARN_ON_ONCE((*iter)->funcs);
403     }
404
405     static int tracepoint_module_coming(struct module *mod)
406     {

The relative reference calculations need to be done here too.

Thanks,

Jessica
