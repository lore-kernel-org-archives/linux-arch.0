Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:57612 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbXKOSNX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 13:13:23 -0500
Date: Thu, 15 Nov 2007 19:14:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
Message-ID: <20071115181451.GA23914@uranus.ravnborg.org>
References: <20071115090215.GA20612@uranus.ravnborg.org> <20071115122151.GA10359@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071115122151.GA10359@Krystal>
Sender: linux-arch-owner@vger.kernel.org
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 15, 2007 at 07:21:51AM -0500, Mathieu Desnoyers wrote:
> 
> FWIW, I've used "NEED_*" in my LTTng patchset to specify when an
> architecture needs support from an architecture independent module. (it
> could be an alternative to USE_*).

The situations we need to cover are:

1) An architecture uses or support a generic implementation
   Examples: KPROBES, GENERIC_TIME

2) An architecture uses a specific functionality
   Examples: MMU

3) Architecture provide a specific functionality
   Examples: ARCH_HAS_ILOG2_U32, ARCH_HAS_ILOG2_U64

4) A driver is supported by a subset of the architectures
   Example: config EDAC
                   depends on X86 || PPC


I'm very tempted to go with the suggestion of Russell and
say that the naming is the very generic:
HAVE_<config-symbol>

We know it from the auto-tools (albeit that could be a reason to avoid it)
And we can hardly put wrong interpretations in the HAVE_ thing.

	Sam
