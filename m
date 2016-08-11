Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:53857 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbcHKMb4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 08:31:56 -0400
Date: Thu, 11 Aug 2016 22:31:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/6 v2] kbuild changes, thin archives, --gc-sections
Message-ID: <20160811223152.0c19ce63@canb.auug.org.au>
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160811123152.yydRkv-ONxv8uxCnWh15ErHqqQfZe44HXcdwjBxe3J4@z>

Hi Nicholas,

On Thu, 11 Aug 2016 20:16:14 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
>
> I would like to submit the kbuild changes in patches 1-3 for
> consideration.

I would just like to thank Nick for taking my preliminary patches and
running with them.  There was a lot more to do than I suspected :-)

> All patches should be basically noops without arch enablement,
> so I include initial powerpc enablement in patches 4-6 for
> reference, but I will submit those via powerpc maintainer if
> the kbuild changes are merged.

In this case, if patches 1-3 are merged via the kbuild tree, can I
ask that they be put in a separate non-rebaseing topic branch so
that they can also be merged into relevant architecture trees.

-- 
Cheers,
Stephen Rothwell
