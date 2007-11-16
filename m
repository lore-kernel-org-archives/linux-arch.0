Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47125 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157AbXKPCHn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 21:07:43 -0500
Date: Thu, 15 Nov 2007 18:07:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + create-arch-kconfig.patch added to -mm tree
Message-Id: <20071115180722.8ae4b285.akpm@linux-foundation.org>
In-Reply-To: <20071116015730.GA16953@Krystal>
References: <200711152227.lAFMR5Ck019098@imap1.linux-foundation.org>
	<20071116015730.GA16953@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-arch@vger.kernel.org, sam@ravnborg.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 15 Nov 2007 20:57:30 -0500 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> I have an updated patchset for these 4 instrumentation menu patches,
> following Sam Ravnborg's comments (using ARCH_HAS_* instead of
> ARCH_SUPPORTS_*). I was planning to send them with my next patch round.
> 
> create-arch-kconfig.patch
> add-arch_supports_oprofile.patch
> add-arch_supports_kprobes.patch
> move-kconfiginstrumentation-to-arch-kconfig-and-init-kconfig.patch

So I've fixed all the rejects, fixed it all up for the arch/x86/Kconfig
churn, merged another patchset which depends on this one and now I'm told
that they need to be updated?

Sigh.  Normally I know not to look at a Mathieu patch until it hits version 37,
but I wanted to merge
kprobes-indicate-kretprobe-support-in-arch-arch-kconfig.patch and
kprobes-build-kretprobe-samples-only-if-arch-supports-kretprobes.patch
which depend on these patches.

It seems that they will now break.  afacit I'll need to do
s/CONFIG_ARCH_SUPPORTS_KRETPROBES/CONFIG_ARCH_HAD_KRETPROBES/ on those
patches.

Please send updated versions of these four asap?
