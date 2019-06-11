Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfFKS4Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 14:56:16 -0400
Date: Tue, 11 Jun 2019 20:55:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Message-ID: <20190611185548.GA31214@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com>
 <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy96sta.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190611185549.uhqc4GIjk18DPlzCdUDVop094R0g1skfKzpjHpC_2AE@z>

On 06/10, Eric W. Biederman wrote:
>
> Personally I don't think anyone sane would intentionally depend on this
> and I don't think there is a sufficiently reliable way to depend on this
> by accident that people would actually be depending on it.

Agreed.

As I said I like these changes and I see nothing wrong. To me they fix the
current behaviour, or at least make it more consistent.

But perhaps this should be documented in the changelog? To make it clear
that this change was intentional.

Oleg.
