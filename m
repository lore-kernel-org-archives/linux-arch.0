Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:19898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261615AbUDCH2U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 Apr 2004 02:28:20 -0500
Date: Fri, 2 Apr 2004 23:27:19 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: si_band
Message-Id: <20040402232719.50e993a5.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0404022018430.1122@ppc970.osdl.org>
References: <20040402161321.2d4e754c.davem@redhat.com>
	<Pine.LNX.4.58.0404021759430.1122@ppc970.osdl.org>
	<Pine.LNX.4.58.0404022018430.1122@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2 Apr 2004 20:21:08 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

>  are you happy with this diff? I not only reverted the __ARCH_SI_BAND_T 
> removal, I also added a comment on why it exists in the first place, and 
> why the default changed to "long".

I'm totally fine with this.
