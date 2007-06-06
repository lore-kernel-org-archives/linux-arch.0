Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:34275 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935134AbXFFWCq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 18:02:46 -0400
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
From: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20070606182914.GB6303@uranus.ravnborg.org>
References: <20070606172409.6689.26641.stgit@localhost.localdomain>
	 <20070606182914.GB6303@uranus.ravnborg.org>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 23:02:29 +0100
Message-Id: <1181167349.27659.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-06-06 at 20:29 +0200, Sam Ravnborg wrote:
> Can you please share with us the strong arguments why another (third)
> arm architecture are needed?

Well, it's not a strong argument but Thumb-2 is a different instruction
set. Even though there is a unified assembly language which tries to
reduce/eliminate the gap between ARM and Thumb, there are still
differences and, probably the most important, older toolchains don't
support it.

> Browsing through your patches there seems to be a common pattern:
> 1) Adding a bit more info to many assembler function
> 2) Small modifications to assembler function
> 3) Almost replaced assembler functions
> 4) Simpler Kconfig and Makefile
> 
> 
> 1) Could be solved in trivial ways using a few macros.
>    One example:
>    .type   printhex8, %function

Yes, this is needed so that the linker knows that the address of
printhex8 should have bit 1 set and also generate BL instead of BLX
instructions.

Adding this to the ARM code is harmless anyway (and I think we should
probably do it anyway). As Russell said, there is a macro already for
this.

> 2) For some parts it looked like:
>    "We can do this different so lets do it different"
>    I am rather ARM assembler ignorant so that may not hold true.
                 ^^^^^^^^^^^^^^^^^^^^^^
Indeed, it doesn't hold true :-). I tried to modify as little as
possible but see the Thumb-2 limitations in my original post for why it
isn't possible to use the existing code (not all variants of ldm/stm,
ldr/str, different model for exception return etc.).

> 3) Factor these out in separate files.

For those which are completely re-written, it makes sense to move them
to separate files.

> 4) Short term win. The maintenance will be much simpler avoiding
> the cleanup.

It didn't make sense to keep all the config options for platforms that
would never run Thumb-2 code.

> As you are introducing a new architecture I have added linux-arch
> to list of receivers - maybe someone there has more to say.

I think these patches are in a too early stage at the moment to cc
linux-arch and, if we decide not to go on this route (separate arch),
only discussing on linux-arm-kernel would be enough.

-- 
Catalin

