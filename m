From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Fri, 2 Nov 2012 18:01:27 +0100
Message-ID: <20121102170127.GA6577@merkur.ravnborg.org>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com> <20121031193503.GA4640@merkur.ravnborg.org> <50939518.5030302@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:44994 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255Ab2KBRBb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2012 13:01:31 -0400
Content-Disposition: inline
In-Reply-To: <50939518.5030302@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Fri, Nov 02, 2012 at 09:40:40AM +0000, James Hogan wrote:
> Hi,
> 
> On 31/10/12 19:35, Sam Ravnborg wrote:
> > 3) there seems to be confusion if the shorthand is meta or metag.
> >    Please fix it up so metag is used everywhere.
> 
> The processor cores are called Meta, which should probably be used in
> kconfig labels and some text. We then use metag as the "shorthand" name
> of the architecture in code, which also makes it a bit less ambiguous. I
> tend to rationalise it as being derived from Metagence.

Thanks for looking into this!

In general people will recognize it if you use the same shorthand as
the arch dir. So if you decide for arch/metag then for example
all Kconfig symbols should use the METAG_ prefix.
Also if theyare dealing with the core.

This will confuse the naive reader less.

	Sam
