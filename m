From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change
 the execution path
Date: Fri, 22 Jun 2018 15:07:40 +0900
Message-ID: <20180622150740.bd26241032c972d86e23bf73@kernel.org>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
        <152942500680.15209.12374262914863044775.stgit@devbox>
        <706832c5-dab4-f806-96d6-2cdc37203d9d@infradead.org>
        <20180620172637.35916da482442b6ab139c7dc@kernel.org>
        <20180621103546.GA9212@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621103546.GA9212@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 21 Jun 2018 12:35:46 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 19 Jun 2018 09:31:49 -0700
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > On 06/19/2018 09:16 AM, Masami Hiramatsu wrote:
> > > > Add a section that explaining how to change the execution
> > > > path with kprobes and warnings for some arch.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: linux-doc@vger.kernel.org
> > > > ---
> > > >  Documentation/kprobes.txt |   20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> > > > index 3e9e99ea751b..8a98eed1521b 100644
> > > > --- a/Documentation/kprobes.txt
> > > > +++ b/Documentation/kprobes.txt
> > > > @@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
> > > >  "post_handler," if any, that is associated with the kprobe.
> > > >  Execution then continues with the instruction following the probepoint.
> > > >  
> > > 
> > > Hi,
> > > I have a few small suggestions...
> > 
> > Hi Randy,
> > 
> > Thank you for your suggestions!
> > All of those are good to me. I'll fix it:)
> 
> Could you please send a delta patch on top of your v6 series, with Randy credited, 
> etc?

Ok, Here's the delta patch.


> 
> I've applied your series and will push it out once it passes all testing.

Thanks!


From 103fc58ece99475b855e065bd48d780697b93bbc Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 22 Jun 2018 15:05:49 +0900
Subject: [PATCH] Documentation/kprobes: Fix typo in Changing Execution Path
 section

Fix typo and clean it up according to the
comment from Randy.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kprobes.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 13d8efd..10f4499 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -83,22 +83,22 @@ Execution then continues with the instruction following the probepoint.
 Changing Execution Path
 -----------------------
 
-Since the kprobes can probe into a running kernel code, it can change
-the register set, including instruction pointer. This operation
-requires maximum attention, such as keeping the stack frame, recovering
-execution path etc. Since it is operated on running kernel and need deep
-knowladge of the archtecture and concurrent computing, you can easily
-shot your foot.
+Since kprobes can probe into a running kernel code, it can change the
+register set, including instruction pointer. This operation requires
+maximum care, such as keeping the stack frame, recovering the execution
+path etc. Since it operates on a running kernel and needs deep knowledge
+of computer architecture and concurrent computing, you can easily shoot
+your foot.
 
 If you change the instruction pointer (and set up other related
-registers) in pre_handler, you must return !0 so that the kprobes
-stops single stepping and just returns to given address.
+registers) in pre_handler, you must return !0 so that kprobes stops
+single stepping and just returns to the given address.
 This also means post_handler should not be called anymore.
 
-Note that this operation may be harder on some architectures which
-use TOC (Table of Contents) for function call, since you have to
-setup new TOC for your function in your module, and recover old
-one after back from it.
+Note that this operation may be harder on some architectures which use
+TOC (Table of Contents) for function call, since you have to setup a new
+TOC for your function in your module, and recover the old one after
+returning from it.
 
 Return Probes
 -------------
-- 
2.7.4
