Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33727 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbcJTDwM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 23:52:12 -0400
Date: Thu, 20 Oct 2016 14:52:04 +1100
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Message-ID: <20161020145204.77b37e6b@roar.ozlabs.ibm.com>
In-Reply-To: <70c4e6bf-1667-326b-8a4d-b0960b55a5e7@suse.com>
References: <20161017100130.GA16013@angband.pl>
        <871szfb1x1.fsf@gmail.com>
        <20161018001626.GA5976@angband.pl>
        <20161018123418.6121175b@roar.ozlabs.ibm.com>
        <70c4e6bf-1667-326b-8a4d-b0960b55a5e7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161020035204.8yebFjchCdKcMV7onioc9JMKIyjLzDMqfhWLHTDDH1I@z>

On Wed, 19 Oct 2016 16:38:14 +0200
Michal Marek <mmarek@suse.com> wrote:

> Dne 18.10.2016 v 03:34 Nicholas Piggin napsal(a):
> > We should probably just bring all these arch patches through the
> > kbuild tree.
> > 
> > I'm sorry for the breakage: I didn't realize it broke the build with
> > some configs, otherwise I would have given Michal a heads up before
> > his pull request, and worked to get this stuff in first.  
> 
> It breaks with some binutils versions only (and only with
> CONFIG_MODVERSIONS=y, of course).

Yeah this seems to be the issue, it apparently slipped past all the
automated builds. It seems like the existing CRC warnings in the tree
only trigger in rare circumstances too, so something could be a bit
fragile there.

Thanks,
Nick
