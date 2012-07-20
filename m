From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use
	asm-generic/module.h [ver #2]
Date: Fri, 20 Jul 2012 10:13:00 +0200
Message-ID: <20120720081300.GA22395@merkur.ravnborg.org>
References: <20105.1342623053@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:18536 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2GTINC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jul 2012 04:13:02 -0400
Content-Disposition: inline
In-Reply-To: <20105.1342623053@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

Hi David.

Looks good - nice cleanup.
I did a quick build-test on sparc32 - ok.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
