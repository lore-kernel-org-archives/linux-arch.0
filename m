From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
Date: Wed, 28 Mar 2012 22:02:41 -0700
Message-ID: <CA+55aFzjQ7qb=bPAj_gGoGLPXOGweTaqtmOBZH4mUt8E_KQwsg@mail.gmail.com>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org>
 <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au>
 <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
 <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com> <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51202 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2C2FDD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 01:03:03 -0400
In-Reply-To: <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Neuling <mikey@neuling.org>, David Howells <dhowells@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, arnd@arndb.de, hpa@zytor.com, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, Mar 28, 2012 at 9:42 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> How about this (build tested on powerpc allyesconfig):

Looks better.

Grant - what's the plan about that CONFIG_VIRQ_DEBUG thing? In theory
something like it could be useful as a generic thing, but at least
right now it is clearly powerpc-specific (not just that the config
option only exists for powerpc: it has that whole
'powerpc_debugfs_root' thing in it)?

Stephen's patch very much looks like the right thing, but if there was
some plan to actually make this generic ...

                    Linus
