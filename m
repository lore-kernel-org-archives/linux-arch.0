From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/4] module linker script: coalesce function and data sections
Date: Thu, 29 Jul 2010 01:25:05 +0100
Message-ID: <29025.1280363105@redhat.com>
References: <1280360876-2571-3-git-send-email-vda.linux@googlemail.com> <1280360876-2571-1-git-send-email-vda.linux@googlemail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab0G2AZj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Jul 2010 20:25:39 -0400
In-Reply-To: <1280360876-2571-3-git-send-email-vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dhowells@redhat.com, Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Matt Fleming <matt@console-pimps.org>, Arnd Bergmann <arnd@arndb.de>, Anders Kaseorg <andersk@mit.edu>, Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Denys Vlasenko <vda.linux@googlemail.com> wrote:

> +	.data   0 : AT(0) { *(.data .data.[A-Za-z0-9_$^]*) }
> +	.bss    0 : AT(0) { *(.bss .bss.[A-Za-z0-9_$^]*) }

What about .sdata and .sbss sections produced by arches that support small
data sections?

David
