Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57713 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbYEFQVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 12:21:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 45/56] microblaze_v2: headers simple files - empty or redirect to asm-generic
Date: Tue, 6 May 2008 18:21:13 +0200
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <20080507004702.d516a727.sfr@canb.auug.org.au> <482077FE.7080201@seznam.cz>
In-Reply-To: <482077FE.7080201@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200805061821.14391.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca
Message-ID: <20080506162113.fIbEtKx_PxzGnAdg3UFqOxP2xIYXMa68z-A9sGZ9SsE@z>

On Tuesday 06 May 2008, Michal Simek wrote:
> 
> > Absolutely, but is it really necessary to have 14-16 lines of comment
> > (including a copyright notice) for a file whose single real line is just
> > to include another file?  i.e. reduce all these to 1 line files.
> 
> Can I do it? I think every file need license.

If you want a good answer on that, ask your lawyer. In general, every file
comes with a 'license' (GPLv2) and 'copyright' (you or the person you copied
from) even if you don't put either statement in the file. Files smaller than
some 10 lines are usually not considered to be covered by copyright, even
if you have the statement in there.

Most files nowadays are written by large corporations that have strict rules
about what you must put in there to protect their intellectual property.

It's certainly safe to leave out the file names from the comments, they don't
add any value at all.
Similarly, you should easily be able to leave out the license statement,
unless you are under a contract that forces you to leave them present.
Most people here will be happier if you remove the license statements.

The most tricky one part is the copyright statement ("Copyright 2012
Big Corporation of America"), which you strictly speaking should never
remove from a file unless you have permission from the copyright holder.
Many of your files in your patch set are obviously copies of existing
kernel files, with the original copyright notice replaced with "Atmark
Techno, inc.". You can draw your own conclusions from that ;-)

Obviously, I am not a lawyer, so don't consider this as legal advice.

I really hope this doesn't turn into a flamewar, as discussions on
intellectual property sometimes do.

	Arnd <><
