From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Fri, 2 Nov 2012 09:40:40 +0000
Message-ID: <50939518.5030302@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com> <20121031193503.GA4640@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11391 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852Ab2KBJkn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 2 Nov 2012 05:40:43 -0400
In-Reply-To: <20121031193503.GA4640@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org

Hi,

On 31/10/12 19:35, Sam Ravnborg wrote:
> 3) there seems to be confusion if the shorthand is meta or metag.
>    Please fix it up so metag is used everywhere.

The processor cores are called Meta, which should probably be used in
kconfig labels and some text. We then use metag as the "shorthand" name
of the architecture in code, which also makes it a bit less ambiguous. I
tend to rationalise it as being derived from Metagence.

I'll try and make sure the usage of these terms is consistent.

Thanks
James
