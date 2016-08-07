Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33765 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcHGJ5p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 05:57:45 -0400
Date: Sun, 7 Aug 2016 19:27:39 +0930
From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160807095739.GU20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-3-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470399123-8455-3-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20160807095739.ztZRGzqvjRTjyXnJgNNVe1MLJ7yvMZc4OEx3tQlXsmM@z>

On Fri, Aug 05, 2016 at 10:12:00PM +1000, Nicholas Piggin wrote:
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
> -		*(.text.hot .text .text.fixup .text.unlikely)		\
> +		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
>  		*(.ref.text)						\
>  	MEM_KEEP(init.text)						\
>  	MEM_KEEP(exit.text)						\

At the risk of being told you (kernel people) have already considerd
this I thought I should mention that the above isn't ideal.  (Nor is
gcc's choice of .text.hot for hot sections, which clashes with
--function-sections for a function called "hot" but that's another
story.)

You'd really like all the hot sections and cold sections to be
together, for better cache locality.  So the line ought to have been
	*(.text.hot) *(.text) *(.text.fixup) *(.text.unlikely)

That would put all .text.hot sections together.  Similarly for
.text.unlikely.  The trap of course is that this only works if
.text.fixup from one object file can be placed relatively far away
from .text in the same object file.

If it can, then Nicholas' patch should be:

	*(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)

If you can't put .text.fixup too far away then you may as well just use

	*(.text .text.*)

-- 
Alan Modra
Australia Development Lab, IBM
