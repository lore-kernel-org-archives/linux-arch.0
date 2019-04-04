From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
Date: Thu, 04 Apr 2019 16:29:42 -0700 (PDT)
Message-ID: <mhng-a348d416-3a9d-458e-be83-d7a584f590aa@palmer-si-x1c4>
References: <20190404102653.705456df@gandalf.local.home>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404102653.705456df@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: ldv@altlinux.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org, akpm@linux-foundation.org, luto@amacapital.net, roland@hack.frob.com, oleg@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de, gustavo@embeddedor.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, linux@dominikbrodowski.net, luto@kernel.org, keescook@chromium.org, ebiederm@xmission.com, wad@chromium.org, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
