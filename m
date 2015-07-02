From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: ARC build -O3 (was Re: subtle side effect of commit a1c48bb160f836)
Date: Thu, 2 Jul 2015 10:57:26 +0530
Message-ID: <5594CBBE.2030302@synopsys.com>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com> <20150618081329.GA9434@pobox.suse.cz> <55828527.8050901@synopsys.com> <55829A0B.8070804@suse.cz> <55829E51.3060007@synopsys.com> <558AA080.7070801@synopsys.com> <20150701151930.GB6743@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:48816 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbGBF1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2015 01:27:44 -0400
In-Reply-To: <20150701151930.GB6743@sepie.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Wednesday 01 July 2015 08:49 PM, Michal Marek wrote:
> On Wed, Jun 24, 2015 at 05:50:16PM +0530, Vineet Gupta wrote:
>> On Thursday 18 June 2015 04:02 PM, Vineet Gupta wrote:
>>> On Thursday 18 June 2015 03:44 PM, Michal Marek wrote:
>>>> Uh, this is not what I meant. KCFLAGS is a *user* setting. It's meant to
>>>> be set in the environment or command line.
>>>
>>> Well I don't want to rely on external settings whatsoever to enforce this. If this
>>> is not the right way, what do u suggest I do to help fix this.
>>
>>
>> Can I keep this seeming abuse of KCFLAGS or do u suggest alternate approach I can
>> code up !
> 
> Hi Vineet, sorry for the late reply.

NP !

> I had something like the below
> patch in mind, simply allow arc to specify -O3 in ARCH_CFLAGS (that part
> I'm leaving up to you).

See below !

> From e458fdf4ae37e1adce81b58d96b1075b4f0656e6 Mon Sep 17 00:00:00 2001
> From: Michal Marek <mmarek@suse.com>
> Date: Wed, 1 Jul 2015 17:13:16 +0200
> Subject: [PATCH] kbuild: Allow arch Makefiles to override {cpp,ld,c}flags
> 
> Since commit a1c48bb1 (Makefile: Fix unrecognized cross-compiler command
> line options), the arch Makefile is included earlier by the main
> Makefile, preventing the arc architecture to set its -O3 compiler
> option. Since there might be more use cases for an arch Makefile to
> fine-tune the options, add support for ARCH_CPPFLAGS, ARCH_AFLAGS and
> ARCH_CFLAGS variables that are appended to the respective kbuild
> variables. The user still has the final say via the KCPPFLAGS, KAFLAGS
> and KCFLAGS variables.
> 
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Signed-off-by: Michal Marek <mmarek@suse.com>

Sweet, that works for me with the following patch below.

Some logistics things:
- It would be nice to keep both of these patches together - do u want to do
  that or want me to pick this one up
- For ARC this fixes a regression starting 3.16 - so I'll need a stable backport
  which but obviously requires above to go to stable. Do u have any issues with
  that. Shall we do the stable request after these hit the mainline...

------------->
From 5458aa05ca3b2c57b683a27ce8226ab5029b9686 Mon Sep 17 00:00:00 2001
From: Vineet Gupta <vgupta@synopsys.com>
Date: Thu, 18 Jun 2015 13:54:01 +0530
Subject: [PATCH] ARC: Override toplevel default -O2 with -O3

ARC kernels have historically been built with -O3, despite top level
Makefile defaulting to -O2. This was facilitated by implicitly ordering
of arch makefile include AFTER top level assigned -O2.

An upstream fix to top level a1c48bb160f ("Makefile: Fix unrecognized
cross-compiler command line options") changed the ordering, making ARC
-O3 defunt.

Fix that by NOT relying on any ordering whatsoever and use the proper
arch override facility now present in kbuild (ARCH_*FLAGS)

Suggested-by: Michal Marek <mmarek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 6107062c0111..46d87310220d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -49,7 +49,8 @@ endif

 ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
 # Generic build system uses -O2, we want -O3
-cflags-y  += -O3
+# Note: No need to add to cflags-y as that happens anyways
+ARCH_CFLAGS += -O3
 endif

 # small data is default for elf32 tool-chain. If not usable, disable it
-- 
1.9.1
