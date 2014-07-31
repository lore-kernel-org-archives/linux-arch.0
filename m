From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
 syscall_trace_enter into two phases)
Date: Thu, 31 Jul 2014 20:50:29 +0200
Message-ID: <CAFTL4hyHh3Bw0eeJe9q50HVrt=B-zgmyu6C_hy+RoW21kQEJtg@mail.gmail.com>
References: <20140728173723.GA20993@redhat.com>
	<20140728185803.GA24663@redhat.com>
	<20140728192209.GA26017@localhost.localdomain>
	<20140729175414.GA3289@redhat.com>
	<20140730163516.GC18158@localhost.localdomain>
	<20140730174630.GA30862@redhat.com>
	<20140731003034.GA32078@localhost.localdomain>
	<20140731160353.GA14772@redhat.com>
	<20140731171329.GD7842@localhost.localdomain>
	<20140731181230.GA18695@redhat.com>
	<20140731184729.GA12296@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:63677 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaGaSuc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Jul 2014 14:50:32 -0400
In-Reply-To: <20140731184729.GA12296@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, the arch/x86 maintainers <x86@kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>

2014-07-31 20:47 GMT+02:00 Frederic Weisbecker <fweisbec@gmail.com>:
> On Thu, Jul 31, 2014 at 08:12:30PM +0200, Oleg Nesterov wrote:
>> On 07/31, Frederic Weisbecker wrote:
> No, because preempt_schedule_irq() does the ctx_state save and restore with
> exception_enter/exception_exit.

Similar thing happens with schedule_user().

preempt_schedule_irq() handles kernel preemption and schedule_user()
the user preemption. On both cases we save and restore the context
tracking state.

This might be the missing piece you were missing :)
