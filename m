Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42317 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932591AbcJSOiY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Oct 2016 10:38:24 -0400
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
References: <20161017100130.GA16013@angband.pl> <871szfb1x1.fsf@gmail.com>
 <20161018001626.GA5976@angband.pl>
 <20161018123418.6121175b@roar.ozlabs.ibm.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <70c4e6bf-1667-326b-8a4d-b0960b55a5e7@suse.com>
Date: Wed, 19 Oct 2016 16:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20161018123418.6121175b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>
Cc: Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161019143814.lYNmYTV0pGmzSkBwyCBq6ZJRvFvA5LbUqE26U8NAV94@z>

Dne 18.10.2016 v 03:34 Nicholas Piggin napsal(a):
> We should probably just bring all these arch patches through the
> kbuild tree.
> 
> I'm sorry for the breakage: I didn't realize it broke the build with
> some configs, otherwise I would have given Michal a heads up before
> his pull request, and worked to get this stuff in first.

It breaks with some binutils versions only (and only with
CONFIG_MODVERSIONS=y, of course).

Michal

