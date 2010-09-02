From: Andreas Schwab <schwab@redhat.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu contributions
Date: Thu, 02 Sep 2010 16:15:26 +0200
Message-ID: <m3d3swnse9.fsf@hase.home>
References: <19747.1283422807@redhat.com>
	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
	<20100902135438.GA23729@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328Ab0IBOPf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 10:15:35 -0400
In-Reply-To: <20100902135438.GA23729@merkur.ravnborg.org> (Sam Ravnborg's
	message of "Thu, 2 Sep 2010 15:54:38 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Thu, Sep 02, 2010 at 11:21:58AM +0100, David Howells wrote:
>> Use CONFIG_MMU not __uClinux__ to select m68knommu contributions as nothing in
>> the arch defines __uClinux__ for the build.
>> 
>> This patch was achieved by running the following three commands:
>> 
>> perl -pi -e 's/ifdef __uClinux__/ifndef CONFIG_MMU/' `find arch/m68k -name "*.[ch]"`
>> perl -pi -e 's/ifndef __uClinux__/ifdef CONFIG_MMU/' `find arch/m68k -name "*.[ch]"`
>> perl -pi -e 's!endif /[*] __uClinux__ [*]/!endif /* CONFIG_MMU */!' `find arch/m68k -name "*.[ch]"
>
> Have you verified that this does not leak out
> to the userspace headers?
> We cannot use the CONFIG_ symbol to distingush between
> the two variants in userspace.

asm/param.h and asm/sigcontext.h are user-space headers, so this is not
ok.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
