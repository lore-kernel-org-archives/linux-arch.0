Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52879 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab1F1KpZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2011 06:45:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Tue, 28 Jun 2011 12:45:19 +0200
References: <1308987512-6583-1-git-send-email-jonas@southpole.se> <201106271305.44746.arnd@arndb.de> <87mxh2lpey.fsf@rustcorp.com.au>
In-Reply-To: <87mxh2lpey.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201106281245.19457.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20110628104519.-aHjz_gUdwUALunK7TeHdDH4mQ2WCdyu0vmfsnIfOKA@z>

On Tuesday 28 June 2011, Rusty Russell wrote:
> To avoid more bikeshedding, smallest patch wins.  That's __weak, right?

Sounds fine to me. Jonas, can you send that patch?

	Arnd
