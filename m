From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 05 Jul 2017 09:49:36 -0700 (PDT)
Message-ID: <mhng-69cb8e74-bdd5-41b8-9955-748be5e45af4@palmer-si-x1c4>
References: <20170703230639.GY6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34503 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdGEQti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 12:49:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so22085265pfe.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Jul 2017 09:49:38 -0700 (PDT)
In-Reply-To: <20170703230639.GY6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Mon, 03 Jul 2017 16:06:39 PDT (-0700), james.hogan@imgtec.com wrote:
> On Thu, Jun 29, 2017 at 02:42:38PM -0700, Palmer Dabbelt wrote:
>> On Wed, 28 Jun 2017 15:42:37 PDT (-0700), james.hogan@imgtec.com wrote:
>> > On Wed, Jun 28, 2017 at 11:55:37AM -0700, Palmer Dabbelt wrote:
>> >> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
>> >> new file mode 100644
>> >> index 000000000000..52eff9febcfd
>> >> --- /dev/null
>> >> +++ b/arch/riscv/include/uapi/asm/ucontext.h
>> > ...
>> >> +struct ucontext {
>> >> +	unsigned long	  uc_flags;
>> >> +	struct ucontext	 *uc_link;
>> >> +	stack_t		  uc_stack;
>> >> +	sigset_t	  uc_sigmask;
>> >> +	/* glibc uses a 1024-bit sigset_t */
>> >> +	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
>> >> +	/* last for future expansion */
>> >> +	struct sigcontext uc_mcontext;
>> >> +};
>> >
>> > Any particular reason not to use the asm-generic ucontext?
>>
>> In the generic ucontext, 'uc_sigmask' is at the end of the structure so it can
>> be expanded.  Since we want our mcontext to be expandable as well, we
>> pre-allocate some expandable space for sigmask and then put mcontext at the
>> end.
>>
>> We stole this idea from arm64.
>
> Curious. __unused seems like overkill to be honest given that expanding
> the number of signals up to 128 causes other issues (as discovered on
> MIPS e.g. the waitpid() status, with stopsig not fitting below the exit
> code (shift 8) and core dump flag (bit 7)), but perhaps it could be
> carefully expanded by splitting the stopsig field.

Sorry, I don't understand the intricacies of this in the slightest.  In general
we try to avoid surprises in software land in RISC-V, so whenever we do
something we go look at the most popular architectures (Intel and ARM) and try
to ensure we don't paint ourselves into any corners that they didn't.

> Looks harmless here I suppose so I defer to others. If it is the
> preferred approach does it make sense to make it the "default" for new
> architectures at some point?

Again, this isn't really my thing, but we chose this because we thought it was
the sane way to do it.  Unless we're doing something silly, I don't see why it
wouldn't be a reasonable default.  This is predicated on having expandable
architectural state, otherwise putting sigmask at the end seems sane.
