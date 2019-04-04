Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDX3o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 19:29:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so1961997plt.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Apr 2019 16:29:44 -0700 (PDT)
Date: Thu, 04 Apr 2019 16:29:42 -0700 (PDT)
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
In-Reply-To: <20190404102653.705456df@gandalf.local.home>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a348d416-3a9d-458e-be83-d7a584f590aa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt@goodmis.org
Cc: ldv@altlinux.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org, akpm@linux-foundation.org, luto@amacapital.net, roland@hack.frob.com, oleg@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de, gustavo@embeddedor.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, linux@dominikbrodowski.net, luto@kernel.org, keescook@chromium.org, ebiederm@xmission.com, wad@chromium.org, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Message-ID: <20190404232942.BMo2nT8StXAjfr9ex40EWSk86OrMIqkfMA7m74lZ668@z>

On Thu, 04 Apr 2019 07:26:53 PDT (-0700), rostedt@goodmis.org wrote:
> On Thu, 4 Apr 2019 17:02:10 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
>
>> On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
>> > From: "Dmitry V. Levin" <ldv@altlinux.org>
>> >
>> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
>> > of struct pt_regs.
>> >
>> > Due to an off-by-one bug and a bug in pointer arithmetic
>> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
>> > Likewise, syscall_set_arguments() was writing s3..s7 fields
>> > instead of a1..a5.
>> >
>> > Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
>> >
>> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Andy Lutomirski <luto@amacapital.net>
>> > Cc: Will Drewry <wad@chromium.org>
>> > Cc: Palmer Dabbelt <palmer@sifive.com>
>> > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> > Cc: linux-riscv@lists.infradead.org
>> > Cc: stable@vger.kernel.org # v4.15+
>> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>
>> According to
>> https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4/
>> the following tag could be added to this patch:
>>
>> Acked-by: Palmer Dabbelt <palmer@sifive.com>
>
> That link isn't actually an ack. Palmer, you OK if I add it?

Acked-by: Palmer Dabbelt <palmer@sifive.com> (for the RISC-V parts)

Thanks!
