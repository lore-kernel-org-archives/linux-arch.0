From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 21 Feb 2009 19:11:01 +0900
Message-ID: <20090221191101.62945118.h.mitake@gmail.com>
References: <20081129192610.716a2d57.h.mitake@gmail.com>
	<20081129222449.e341f028.h.mitake@gmail.com>
	<20081129180144.GA15533@uranus.ravnborg.org>
	<20081130171604.dc3c8715.h.mitake@gmail.com>
	<20081130083700.GA31644@elte.hu>
	<20081130092407.GA10802@elte.hu>
	<20081201002056.d9f9204c.h.mitake@gmail.com>
	<20081130161504.GA25627@elte.hu>
	<a6b9f31a0812010551h28c0841fxa2a26af4645df64@mail.gmail.com>
	<20081201135922.GA30068@elte.hu>
	<a6b9f31a0812011558o373edbd3r9690efe539d43ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:23245 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZBUKLK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2009 05:11:10 -0500
In-Reply-To: <a6b9f31a0812011558o373edbd3r9690efe539d43ca0@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hitoshi Mitake <h.mitake@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2 Dec 2008 08:58:19 +0900
"Hitoshi Mitake" <h.mitake@gmail.com> wrote:

> On Mon, Dec 1, 2008 at 22:59, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Hitoshi Mitake <h.mitake@gmail.com> wrote:
> >
> >> On Mon, Dec 1, 2008 at 01:15, Ingo Molnar <mingo@elte.hu> wrote:
> >> >
> >> > * Hitoshi Mitake <h.mitake@gmail.com> wrote:
> >> >
> >> >> On Sun, 30 Nov 2008 10:24:07 +0100
> >> >> Ingo Molnar <mingo@elte.hu> wrote:
> >> >>
> >> >> >
> >> >> > the 32-bit build broke promptly - readq/writeq is a family of APIs that
> >> >> > has to be either fully provided or not provided at all. The fix is below.
> >> >>
> >> >> Thanks for your fix and adding!
> >> >> When will this patch be added to mainline?
> >> >> I want to rewrite x38_edac.c to adapt new APIs.
> >> >
> >> > v2.6.29 at the earliest - if there are no regressions. A number of
> >> > drivers use these APIs and usage is a bit messy - so bugs could be
> >> > triggered, etc.
> >> >
> >> Thanks. What is URL of your repository?
> >> I want to look your tree and test it.
> >
> > you can pick up tip/master via:
> >
> >  http://people.redhat.com/mingo/tip.git/README
> >
> 
> Thanks!


Hi,

Very sorry for long distance between my previous post and this...

I wrote a patch to add HAVE_READQ and HAVE_WRITEQ to each architecture's Kconfig file
which have readq() and writeq().

But there is problem.
I wrote helps for HAVE_READQ and HAVE_WRITEQ in Kconfig file
accodring to the advice by Russell King ( http://marc.info/?l=linux-kernel&m=122701161824218&w=2 ),
but these helps are invisible when I doing menuconfig.
(when type '/' and search readq string, HAVE_READQ found, but
help string is not printed...)

Do you have some nice technique that make these helps visible easily?
I paste a patch for x86 as sample. If I could find a good way,
I'll rewrite patches and send them to maintainers of each architectures.


Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>

---
 arch/x86/Kconfig |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9c39095..d22f9a6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -19,8 +19,6 @@ config X86_64
 config X86
 	def_bool y
 	select HAVE_AOUT if X86_32
-	select HAVE_READQ
-	select HAVE_WRITEQ
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
 	select HAVE_OPROFILE
@@ -1980,6 +1978,25 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
+config HAVE_READQ
+	def_bool y
+	help
+	  This is a sign to represent that this architecture provides
+	  readq() function. readq() is a function to read 8 bytes from
+	  I/O space. Each drivers use readq() must depend on this symbol.
+	  Because lots of little private readq() implementations
+	  all over the tree is sucks.
+
+config HAVE_WRITEQ
+	def_bool y
+	help
+	  This is a sign to represent that this architecture provides
+	  writeq() function. writeq() is a function to read 8 bytes from
+	  I/O space. Each drivers use writeq() must depend on this symbol.
+	  Because lots of little private writeq() implementations
+	  all over the tree is sucks.
+
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.6.1.2
