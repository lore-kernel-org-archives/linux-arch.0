Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:49738 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762974AbXFFS2O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jun 2007 14:28:14 -0400
Date: Wed, 6 Jun 2007 20:29:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070606182914.GB6303@uranus.ravnborg.org>
References: <20070606172409.6689.26641.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070606172409.6689.26641.stgit@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 06:24:53PM +0100, Catalin Marinas wrote:
> The following series of patches add support for compiling the kernel
> to the Thumb-2 ISA on an ARMv7 CPU.
> 
> Because of the issues listed below, merging the Thumb-2 support into
> the existing arch/arm files would clutter the existing code with
> macros like ARM, THUMB or W (for conditional compilation and the wide
> instruction format). The IT instruction is also not recognised by
> older toolchains and additional (assembler) macros would be needed,
> including support for the inline assembly. I therefore decided to
> create a separate arch/arm_t2 directory that shares a lot of code with
> the existing arch/arm.

Hi Catalin.
Can you please share with us the strong arguments why another (third)
arm architecture are needed?

Browsing through your patches there seems to be a common pattern:
1) Adding a bit more info to many assembler function
2) Small modifications to assembler function
3) Almost replaced assembler functions
4) Simpler Kconfig and Makefile


1) Could be solved in trivial ways using a few macros.
   One example:
   .type   printhex8, %function

Add a common macro like this:

#define FUNCTION(name)   .type name, %function
Introducing this simple macro in the generic ARM codebase would
bring down the diff significantly


2) For some parts it looked like:
   "We can do this different so lets do it different"
   I am rather ARM assembler ignorant so that may not hold true.
   But if it is true then look into what is really needed to change
   and if nothing else factor these out in files for the different
   situations and select the right one in the Makefile.

3) Factor these out in separate files.


4) Short term win. The maintenance will be much simpler avoiding
the cleanup.

As you are introducing a new architecture I have added linux-arch
to list of receivers - maybe someone there has more to say.

	Sam

[Rest of mail kept so linux-arch readers can see it]

Pointers to the mails with patches:
http://marc.info/?l=linux-arm-kernel&m=118115330624752&w=2
http://marc.info/?l=linux-arm-kernel&m=118115324023036&w=2
http://marc.info/?l=linux-arm-kernel&m=118115281427358&w=2
[PATCH 4/9] was not available at marc.info yet
[PATCH 5/9] was not available at marc.info yet
http://marc.info/?l=linux-arm-kernel&m=118115384801763&w=2
http://marc.info/?l=linux-arm-kernel&m=118115310810711&w=2
http://marc.info/?l=linux-arm-kernel&m=118115399504496&w=2
http://marc.info/?l=linux-arm-kernel&m=118115421005454&w=2

See full list at: http://marc.info/?l=linux-arm-kernel&r=1&b=200706&w=2


> 
> I avoided posting the first big patch in the series as it only
> contains the code duplicated from arch/arm into arch/arm_t2. Most of
> the .h files only contain an #include clause to the corresponding
> asm-arm version. Subsequent patches would show the differences with
> the original arch/arm code, making the review a lot easier.
> 
> The patches are also available on my GIT tree -
> http://www.linux-arm.org/git?p=linux-2.6.git;a=shortlog;h=2.6.21-thumb.
> They are currently based on 2.6.21 with some additional patches for
> the ARMv7 support (most of them being already merged by Russell in
> 2.6.22-rc1).
> 
> Thumb-2 ISA consists of either 16 or 32 bit instructions and are
> aligned to a two-byte boundary. ARM defined the unified assembler
> language that provides a canonical form for all the ARM and Thumb-2
> instructions. This is currently supported by the CodeSourcery's
> toolchains.
> 
> Even with the unified syntax, there are some differences between the
> instructions supported in ARM or Thumb modes (though the Thumb-2 code
> could be compiled into ARM code but with some performance penalties).
> 
> 
> Some of the main points regarding the Thumb-2 ISA:
> 
> - conditional execution is achieved using the IT (if-then) instruction
>   which can specify the execution of up to four subsequent
>   instructions (when compiling to ARM mode, this instruction is
>   ignored)
> 
> - post-indexing ldr/str with a register (ldr r0, [r1], r2) is not
>   supported in Thumb-2
> 
> - pre-indexing ldr/str with a shifted register only "lsl" is allowed
>   (ldr r0, [r1, r2, lsl #2])
> 
> - ldrt/strt do not support post-indexing
> 
> - ldm/stm cannot have "sp" in the register list (the latest ARM ARM
>   also states that ARM instructions that include "sp" in the list are
>   deprecated)
> 
> - ldm cannot have both "pc" and "lr" in the list (the latest ARM ARM
>   also states that these ARM instructions are deprecated)
> 
> - ldm/stm <registers-without-pc>^ are not available (kernel access to
>   the banked "sp" and "lr" is done by switching to the System mode)
> 
> - ldm <registers-with-pc>^ is not available (return from exception is
>   done with the "rfe" instruction)
> 
> - ldmda/stmib are not available
> 
> 
> Some other issues with Thumb-2 or the unified assembler syntax:
> 
> - the condition flags should always be placed at the end of the
>   instruction, i.e. "ldmiane" rather than "ldmneia". The new form is
>   not compilable by older assemblers (though the new assembler could
>   be modified to not warn about the old syntax)
> 
> - because Thumb-2 instructions are 16 bit aligned, instructions
>   loading data from the literal pool may trigger an alignment
>   fault. The assembler doesn't automatically align ".word" or ".long"
>   declarations to 32 bit. This has to be explicitly set via ".align"
> 
> - Thumb-2 32 bit instructions can be generated by appending ".w" to
>   the instruction, i.e. "mov.w pc, lr"
> 
> 
> Comments and suggestions are welcomed.
> 
> Regards.
> 
> -- 
> Catalin
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
