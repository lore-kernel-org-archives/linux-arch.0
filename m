Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbcHXObk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Aug 2016 10:31:40 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Subject: Re: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12109.1472048481.1@warthog.procyon.org.uk>
Date: Wed, 24 Aug 2016 15:21:21 +0100
Message-ID: <12110.1472048481@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: dhowells@redhat.com, Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160824142121.a2kXs4AIRDng9ReEizZoMVD6c-SaLTPclXxlYZdodcw@z>

Out of interest, does using LTO also fix the problem?

David
