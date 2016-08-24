From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
Date: Wed, 24 Aug 2016 11:13:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1608241112470.17623@knanqh.ubzr>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com> <1686648.CKXrTpUETq@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36585 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbcHXPO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 11:14:26 -0400
Received: by mail-qk0-f181.google.com with SMTP id l2so17797714qkf.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2016 08:13:43 -0700 (PDT)
In-Reply-To: <1686648.CKXrTpUETq@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Wed, 24 Aug 2016, Arnd Bergmann wrote:

> On Wednesday, August 24, 2016 10:29:18 PM CEST Nicholas Piggin wrote:
> > Hi Michal,
> > 
> > I ended up deciding to do a v3, because I had several changes
> > accumulated, as described in patches.
> > 
> > I've also left off the powerpc arch patches -- they can be found
> > in previous posts, for reference.
> > 
> > I've again tested ARM and it seems to be building okay and without
> > performance regression with my configurations. I think it's going
> > to be a matter of some toolchain options for them to go through.
> > arm64, x86, powerpc, and arm for me all built fine with thin archives
> > and --gc-sections enabled, so I can't see there being a fundamental
> > issue that can't be solved. Worst case, the incremental link option
> > can remain for a time.
> > 
> 
> I clearly want to use this on ARM, and I am still investigating
> the performance regression that I see on my build box, but that
> is no reason to delay your patches.
> 
> Everything looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Ditto here.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
