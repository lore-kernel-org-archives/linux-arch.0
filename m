Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65209 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933718Ab2JDVUy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Oct 2012 17:20:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Disintegrate UAPI for asm-generic
Date: Thu, 4 Oct 2012 21:20:48 +0000
References: <17336.1349380256@warthog.procyon.org.uk>
In-Reply-To: <17336.1349380256@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201210042120.48955.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Message-ID: <20121004212048.hm9MLtgritav-uTl0_5dKvEsVWCg29B-NcFxbNz-cR0@z>

On Thursday 04 October 2012, David Howells wrote:
> Can you merge the following branch into the asm-generic tree please.
> 
> This is to complete part of the UAPI disintegration for which the preparatory
> patches were pulled recently.
> 
> Note that there are some fixup patches which are at the base of the branch
> aimed at you, plus all arches get the asm-generic branch merged in too.
> 
> The following changes since commit 612a9aab56a93533e76e3ad91642db7033e03b69:
> 
>   Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2012-10-03 23:29:23 -0700)
> 
> are available in the git repository at:

Ok, I've pulled it into the asm-generic branch and added it to the arm-soc
for-next branch, because that is convenient for me to get it into linux-next.

Olof, I'll send this to Linus in a couple of days, separate from the other arm-soc
stuff that I assume you are handling. I could also send everything in one go
if you prefer.

	Arnd
