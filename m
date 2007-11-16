Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tomts36.bellnexxia.net ([209.226.175.93]:61556 "EHLO
	tomts36-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755982AbXKPCOM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 21:14:12 -0500
Received: from toip5.srvr.bell.ca ([209.226.175.88])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20071116021410.CZYS7990.tomts36-srv.bellnexxia.net@toip5.srvr.bell.ca>
          for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2007 21:14:10 -0500
Date: Thu, 15 Nov 2007 21:14:09 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: + create-arch-kconfig.patch added to -mm tree
Message-ID: <20071116021409.GB16953@Krystal>
References: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org> <20071116015730.GA16953@Krystal> <20071115180722.8ae4b285.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20071115180722.8ae4b285.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, sam@ravnborg.org
List-ID: <linux-arch.vger.kernel.org>

* Andrew Morton (akpm@linux-foundation.org) wrote:
> On Thu, 15 Nov 2007 20:57:30 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > I have an updated patchset for these 4 instrumentation menu patches,
> > following Sam Ravnborg's comments (using ARCH_HAS_* instead of
> > ARCH_SUPPORTS_*). I was planning to send them with my next patch round.
> > 
> > create-arch-kconfig.patch
> > add-arch_supports_oprofile.patch
> > add-arch_supports_kprobes.patch
> > move-kconfiginstrumentation-to-arch-kconfig-and-init-kconfig.patch
> 
> So I've fixed all the rejects, fixed it all up for the arch/x86/Kconfig
> churn, merged another patchset which depends on this one and now I'm told
> that they need to be updated?
> 
> Sigh.  Normally I know not to look at a Mathieu patch until it hits version 37,
> but I wanted to merge
> kprobes-indicate-kretprobe-support-in-arch-arch-kconfig.patch and
> kprobes-build-kretprobe-samples-only-if-arch-supports-kretprobes.patch
> which depend on these patches.
> 
> It seems that they will now break.  afacit I'll need to do
> s/CONFIG_ARCH_SUPPORTS_KRETPROBES/CONFIG_ARCH_HAD_KRETPROBES/ on those
> patches.
> 
> Please send updated versions of these four asap?


Just been sent.

I sent you an email telling to hold patch integration yesterday:

Subject: Wait for next round of post before merge to -mm

I thought it was clear, but apparently it wasn't, sorry about that.

And the change involves using a select now instead of a simple depend.

Mathieu


-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
