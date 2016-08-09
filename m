From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Tue, 9 Aug 2016 12:43:58 -0400
Message-ID: <feaaca8f-cc09-5847-ea3f-d27052704d9b@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160809124325.GG13300@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160809124325.GG13300@pathway.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 8/9/2016 8:43 AM, Petr Mladek wrote:
> On Mon 2016-08-08 12:03:38, Chris Metcalf wrote:
>> When doing an nmi backtrace of many cores, most of which are idle,
>> the output is a little overwhelming and very uninformative.  Suppress
>> messages for cpus that are idling when they are interrupted and just
>> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> Hmm, I do not see this message even though the CPU is in the idle state:
>
> [ 7918.884535] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.8.0-rc1-4-default+ #3088
> [ 7918.884538] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 7918.884539] task: ffff88013a594380 task.stack: ffff88013a598000
> [ 7918.884541] RIP: 0010:[<ffffffff81050bc6>]  [<ffffffff81050bc6>] native_safe_halt+0x6/0x10
> [ 7918.884543] RSP: 0018:ffff88013a59bea8  EFLAGS: 00000206
> [ 7918.884544] RAX: ffff88013a594380 RBX: 0000000000000003 RCX: 0000000000000000
> [ 7918.884546] RDX: ffff88013a594380 RSI: 0000000000000001 RDI: ffff88013a594380
> [ 7918.884548] RBP: ffff88013a59bea8 R08: 0000000000000000 R09: 0000000000000000
> [ 7918.884550] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000003
> [ 7918.884551] R13: 0000000000000000 R14: ffff88013a598000 R15: ffff88013a598000
> [ 7918.884553] FS:  0000000000000000(0000) GS:ffff88013fd80000(0000) knlGS:0000000000000000
> [ 7918.884554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7918.884556] CR2: 00007f8afc65e000 CR3: 00000001383b8000 CR4: 00000000000006e0
> [ 7918.884557] Stack:
> [ 7918.884559]  ffff88013a59bec8 ffffffff819573d3 0000000000000003 0000000000000000
> [ 7918.884561]  ffff88013a59bed8 ffffffff8102628f ffff88013a59bee8 ffffffff819579ea
> [ 7918.884562]  ffff88013a59bf30 ffffffff810bfe1a ffff88013a598000 ffff88013a598000
> [ 7918.884563] Call Trace:
> [ 7918.884565]  [<ffffffff819573d3>] default_idle+0x23/0x170
> [ 7918.884566]  [<ffffffff8102628f>] arch_cpu_idle+0xf/0x20
> [ 7918.884568]  [<ffffffff819579ea>] default_idle_call+0x2a/0x50
> [ 7918.884570]  [<ffffffff810bfe1a>] cpu_startup_entry+0x16a/0x260
> [ 7918.884571]  [<ffffffff8103faf6>] start_secondary+0xf6/0x100
> [ 7918.884573] Code: 00 00 00 00 00 55 48 89 e5 fa 5d c3 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 fb 5d c3 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 fb f4 <5d> c3 0f 1f 84 00 00 00 00 00 55
>   48 89 e5 f4 5d c3 66 0f 1f 84
>
> Note that I test it in a virtual machine using qemu.
>
> The strange thing is that I do not see .cpuidle.text section in
> the vmlinux binary. But it is possible that I have misunderstood
> the concept.

The .cpuidle.text sections are merged into the final kernel's overall
text segment.  What you should see is something like this in the "nm -n"
output from the built vmlinux:

[...]
ffffffff81922aa8 T __cpuidle_text_start
ffffffff81922ab0 T default_idle
ffffffff81922b90 t mwait_idle
ffffffff81922d20 T acpi_processor_ffh_cstate_enter
ffffffff81922df0 T default_idle_call
ffffffff81922e30 t cpu_idle_poll
ffffffff81922f50 t intel_idle
ffffffff81923085 t acpi_idle_do_entry
ffffffff819230d0 t poll_idle
ffffffff81923143 T __cpuidle_text_end
[...]

In other words, all the cpuidle functions grouped together and bracketed by
the __cpuidle_text_{start,end} symbols.

Perhaps you were running with a kernel that didn't have the actual patch 4/4
applied, but just the earlier patches?  Or perhaps your host Linux has been
patched, but not the guest Linux running in qemu?  Or perhaps you are
ending up doing an NMI backtrace on the host kernel, not the guest?

Thanks for your other reviews as well.  I have incorporated all of your
suggestions into a v8 patch series and pushed it up to kernel.org.
I will just wait to repost it until we sort out this issue that you've reported here.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
