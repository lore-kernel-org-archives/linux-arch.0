Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbbL3Tzi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 14:55:38 -0500
Date: Wed, 30 Dec 2015 21:55:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 07/34] sparc: reuse asm-generic/barrier.h
Message-ID: <20151230215303-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
 <1451473761-30019-8-git-send-email-mst@redhat.com>
 <20151230.125603.75638711551088484.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151230.125603.75638711551088484.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com, mingo@kernel.org, mpe@ellerman.id.au, andreyknvl@google.com, sparclinux@vger.kernel.org
Message-ID: <20151230195533.GzlkQHXWAlSp699ecllYfUeHSoht4wgdYtDYtyiq2-4@z>

On Wed, Dec 30, 2015 at 12:56:03PM -0500, David Miller wrote:
> 
> I find it a little bit irritating when I receive a patch directly
> addressed to me to review, but I don't see the "00/34" cover letter.
> 
> I want to see what this series is about, and what the motiviation
> for this change is.
> 
> I'm also highly frustrated, in general, with mix-and-match CC: lists
> for patch series.  Just put everyone relevant in the CC: for the
> entire series.  That way I can easily inspect other parts of the
> series to see infrastructure buildup, and examples of other
> conversions or versions of the change.
> 
> Thanks.

Hi Dave.
Sorry about that.

The problem I had in the past is that vger rejects email with
too many CC addresses.

(It also rejected email with __smp_XXX in the subject
suspecting it's spam :( )

I'll look for better solutions next time - for now, would it help if I
bounced the whole patchset to you?

-- 
MST
