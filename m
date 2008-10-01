From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: RFC: remove ibcs2/PER_SVR4?
Date: Wed, 1 Oct 2008 17:08:27 +0100
Message-ID: <20081001160827.GA13102@linux-mips.org>
References: <1222850741.32562.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:34707
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750760AbYJAQKh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Oct 2008 12:10:37 -0400
Content-Disposition: inline
In-Reply-To: <1222850741.32562.4.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org

On Wed, Oct 01, 2008 at 10:45:41AM +0200, Martin Schwidefsky wrote:

> Greetings,
> I stumbled across SET_PERSONALITY and the ibcs2/PER_SVR4 personality once
> more. I never really understood why it is there and with the current code
> it is in fact completely unused. The minimal patch I will do is the one
> below, it just removes ibcs2/PER_SVR4 for s390. I think the same could be
> done for all architectures and the SET_PERSONALITY macro could drop the
> ibcs2 argument. Before I go ahead and do a patch across all architectures:
> does anybody out there still needs ibcs2/PER_SVR4?

Doesn't look like it; all invocations of SET_PERSONALITY are passing 0 for
the ibcs2 argument.  So I think the 2nd argument should go entirely.  MIPS
segment against linux-next is below.  As you may notice it's actually a
bug fix, there was a missing else statement that didn't bite bite anybody
thanks to the unusedness :-)

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index f69f7ac..3d15e02 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -249,8 +249,6 @@ extern struct mips_abi mips_abi_n32;
 
 #define SET_PERSONALITY(ex, ibcs2)					\
 do {									\
-	if (ibcs2)							\
-		set_personality(PER_SVR4);				\
 	set_personality(PER_LINUX);					\
 									\
 	current->thread.abi = &mips_abi;				\
@@ -306,9 +304,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	if (ibcs2)							\
-		set_personality(PER_SVR4);				\
-	else if (current->personality != PER_LINUX32)			\
+	if (current->personality != PER_LINUX32)			\
 		set_personality(PER_LINUX);				\
 } while (0)
 
