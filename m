From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 15:54:59 +0200
Message-ID: <CAKv+Gu98iosK2Btz1fAT81ygrdN_aL2sK4R53LHJ_F1y4Ak=ag@mail.gmail.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk> <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
 <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
 <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com> <20160812135212.GZ1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160812135212.GZ1041@n2100.armlinux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 12 August 2016 at 15:52, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Aug 12, 2016 at 03:50:17PM +0200, Ard Biesheuvel wrote:
>> $ objdump -dr vmlinux |grep -A1 -E \\sb\.w |less
>>
>> I get numerous instances of b.w that are not covered by any
>> relocations, so i assume that will be the case for modules as well.
>
> Not surprising.  vmlinux is fully linked.  There's no relocations.
>

My bad. It does if you link it with --emit-relocs.

Random snippet:

c036b098:       f7ff bff8       b.w     c036b08c <rcu_barrier>
                        c036b098: R_ARM_THM_JUMP24      rcu_barrier
--
c036b5ae:       f7ff ba5b       b.w     c036aa68 <rcu_gp_kthread_wake>
c036b5b2:       bf00            nop
--
c036bc28:       f1c6 b6da       b.w     c09329e0 <_raw_spin_unlock_irqrestore>
                        c036bc28: R_ARM_THM_JUMP24
_raw_spin_unlock_irqrestore
--
c036bcbc:       f7ee bc2e       b.w     c035a51c <swake_up>
                        c036bcbc: R_ARM_THM_JUMP24      swake_up
--
c036c63a:       f7ff bfd5       b.w     c036c5e8 <synchronize_sched>
                        c036c63a: R_ARM_THM_JUMP24      synchronize_sched
--
c036c640:       f7ff bff0       b.w     c036c624 <cond_synchronize_sched>
                        c036c640: R_ARM_THM_JUMP24      cond_synchronize_sched
--
c036c644:       f7ff bb3e       b.w     c036bcc4 <synchronize_sched_expedited>
                        c036c644: R_ARM_THM_JUMP24
synchronize_sched_expedited
--
c036c690:       f7dc ba0a       b.w     c0348aa8 <resched_cpu>
                        c036c690: R_ARM_THM_JUMP24      resched_cpu
--
c036c6a2:       f7ff baad       b.w     c036bc00
<rcu_report_exp_cpu_mult.constprop.22>
c036c6a6:       bf00            nop
--
c036c716:       f7ff ba73       b.w     c036bc00
<rcu_report_exp_cpu_mult.constprop.22>
c036c71a:       bf00            nop
--
c036cf3a:       f7fd bc4d       b.w     c036a7d8 <rcu_eqs_enter_common>
c036cf3e:       bf00            nop

So some branches are relocated, some have already been resolved at compile time.
