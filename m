From: Michal Marek <mmarek@suse.cz>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Wed, 1 Jul 2015 17:19:30 +0200
Message-ID: <20150701151930.GB6743@sepie.suse.cz>
References: <55826966.6050202@synopsys.com>
 <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
 <20150618081329.GA9434@pobox.suse.cz>
 <55828527.8050901@synopsys.com>
 <55829A0B.8070804@suse.cz>
 <55829E51.3060007@synopsys.com>
 <558AA080.7070801@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbbGAPTc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jul 2015 11:19:32 -0400
Content-Disposition: inline
In-Reply-To: <558AA080.7070801@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Wed, Jun 24, 2015 at 05:50:16PM +0530, Vineet Gupta wrote:
> On Thursday 18 June 2015 04:02 PM, Vineet Gupta wrote:
> > On Thursday 18 June 2015 03:44 PM, Michal Marek wrote:
> >> Uh, this is not what I meant. KCFLAGS is a *user* setting. It's meant to
> >> be set in the environment or command line.
> > 
> > Well I don't want to rely on external settings whatsoever to enforce this. If this
> > is not the right way, what do u suggest I do to help fix this.
> 
> 
> Can I keep this seeming abuse of KCFLAGS or do u suggest alternate approach I can
> code up !

Hi Vineet, sorry for the late reply. I had something like the below
patch in mind, simply allow arc to specify -O3 in ARCH_CFLAGS (that part
I'm leaving up to you).


From e458fdf4ae37e1adce81b58d96b1075b4f0656e6 Mon Sep 17 00:00:00 2001
From: Michal Marek <mmarek@suse.com>
Date: Wed, 1 Jul 2015 17:13:16 +0200
Subject: [PATCH] kbuild: Allow arch Makefiles to override {cpp,ld,c}flags

Since commit a1c48bb1 (Makefile: Fix unrecognized cross-compiler command
line options), the arch Makefile is included earlier by the main
Makefile, preventing the arc architecture to set its -O3 compiler
option. Since there might be more use cases for an arch Makefile to
fine-tune the options, add support for ARCH_CPPFLAGS, ARCH_AFLAGS and
ARCH_CFLAGS variables that are appended to the respective kbuild
variables. The user still has the final say via the KCPPFLAGS, KAFLAGS
and KCFLAGS variables.

Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 Documentation/kbuild/makefiles.txt | 8 ++++++++
 Makefile                           | 9 +++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 74b6c6d..d2b1c40 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -952,6 +952,14 @@ When kbuild executes, the following steps are followed (roughly):
 	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
 	mode) if this option is supported by $(AR).
 
+    ARCH_CPPFLAGS, ARCH_AFLAGS, ARCH_CFLAGS   Overrides the kbuild defaults
+
+	These variables are appended to the KBUILD_CPPFLAGS,
+	KBUILD_AFLAGS, and KBUILD_CFLAGS, respectively, after the
+	top-level Makefile has set any other flags. This provides a
+	means for an architecture to override the defaults.
+
+
 --- 6.2 Add prerequisites to archheaders:
 
 	The archheaders: rule is used to generate header files that
diff --git a/Makefile b/Makefile
index 3ba5044..aa0dfbe 100644
--- a/Makefile
+++ b/Makefile
@@ -783,10 +783,11 @@ endif
 include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 
-# Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
-KBUILD_CPPFLAGS += $(KCPPFLAGS)
-KBUILD_AFLAGS += $(KAFLAGS)
-KBUILD_CFLAGS += $(KCFLAGS)
+# Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS as the
+# last assignments
+KBUILD_CPPFLAGS += $(ARCH_CPPFLAGS) $(KCPPFLAGS)
+KBUILD_AFLAGS   += $(ARCH_AFLAGS)   $(KAFLAGS)
+KBUILD_CFLAGS   += $(ARCH_CFLAGS)   $(KCFLAGS)
 
 # Use --build-id when available.
 LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
-- 
2.1.4
