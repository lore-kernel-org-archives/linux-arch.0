Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34576 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbcHXPbN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 11:31:13 -0400
Received: by mail-qk0-f170.google.com with SMTP id t7so18306460qkh.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2016 08:29:51 -0700 (PDT)
Date: Wed, 24 Aug 2016 11:21:33 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
In-Reply-To: <12110.1472048481@warthog.procyon.org.uk>
Message-ID: <alpine.LFD.2.20.1608241114430.17623@knanqh.ubzr>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com> <12110.1472048481@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160824152133.9_wwLt5m-1JbLiPsBh69_bo7swdxfQVBOwqfI69fE2A@z>

On Wed, 24 Aug 2016, David Howells wrote:

> Out of interest, does using LTO also fix the problem?

With those patches in place, that would be the next thing to try.
Reducing our reliance on 'ld -r' will greatly help promoting LTO for the
kernel.

Personally I'd like to have the choice between LTO and -gc-sections at 
configure time.  They both have advantages of their own.


Nicolas
