Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59820 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759059AbaJ3Ldq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Oct 2014 07:33:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Thu, 30 Oct 2014 12:33:38 +0100
Message-ID: <11875981.eJaWCbGJJT@wuerfel>
In-Reply-To: <CAFiDJ59LZSwKBzVuuzfH_5772-BR74EH=d=FeBbWvEXjfpisug@mail.gmail.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <2095416.INZmt8AD1y@wuerfel> <CAFiDJ59LZSwKBzVuuzfH_5772-BR74EH=d=FeBbWvEXjfpisug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20141030113338.yix9Q6QW-YRR-8Rmmv1K5BVq1LWpntzo5NAHdM-cGyM@z>

On Thursday 30 October 2014 18:44:37 Ley Foon Tan wrote:
> >
> > I don't remember what all of these are, but at least some of them seem
> > to be concerned with 64-bit division. By convention, we don't provide those
> > in the Linux kernel but instead require all code to use the do_div()
> > macro instead.
> Do you mean kernel doesn't support 64 bit division result for a 32-bit
> architecture? Because do_div() only support 32-bit division result for
> 32-bit architecture.

Correct. If you need a full 64-bit division on a 32-bit kernel, the
assumption is that your driver has a bug.

	Arnd
