From: David Howells <dhowells@redhat.com>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Wed, 30 Jul 2008 10:34:55 +0100
Message-ID: <3995.1217410495@redhat.com>
References: <200807300907.25186.arnd@arndb.de> <20080728200500.GA14284@uranus.ravnborg.org> <48900EE4.8030606@snapgear.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbYG3JfH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jul 2008 05:35:07 -0400
In-Reply-To: <200807300907.25186.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Greg Ungerer <gerg@snapgear.com>, Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> I think the more interesting aspect in m68knommu is what happens
> when asm-m68k gets moved. Does that work as well?

Can m68knommu be merged into m68k and be made contingent on CONFIG_MMU?  This
is what FRV does.

David
