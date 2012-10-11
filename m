From: Will Deacon <will.deacon@arm.com>
Subject: Re:
Date: Thu, 11 Oct 2012 10:57:05 +0100
Message-ID: <20121011095705.GB30598@mudshark.cambridge.arm.com>
References: <22758.1349565339@warthog.procyon.org.uk>
 <CAMuHMdX2TgSbTj8yjyRKXT=RJ0E+efR7FH-vzoWL8+-SCUN29w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64321 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758250Ab2JKJ5h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Oct 2012 05:57:37 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2TgSbTj8yjyRKXT=RJ0E+efR7FH-vzoWL8+-SCUN29w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>, "torvalds@osdl.org" <torvalds@osdl.org>, "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Sun, Oct 07, 2012 at 07:36:20AM +0100, Geert Uytterhoeven wrote:
> On Sun, Oct 7, 2012 at 1:15 AM, David Howells <dhowells@redhat.com> wrote:
> >  (3) m68k turned out to have a header installation problem due to it lacking a
> >      kvm_para.h file.
> 
> Sh also.

and arm64 iirc. It should also affect arm, but we have a horrible dummy
header to get around it (just includes the asm-generic variant).

I posted a fix, but then it got derailed by the wildcarding used to generate
generic headers for kvm (which I was going some way to removing):

  https://lkml.org/lkml/2012/8/2/173

  http://marc.info/?l=linux-kernel&m=134393963216492&w=2

Will
