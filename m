Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:32891 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfFLIj6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 04:39:58 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Wed, 12 Jun 2019 08:39:53 +0000
Message-ID: <fd2aab3d26754becbb0efe4ae65c32ac@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com> <20190611185548.GA31214@redhat.com>
In-Reply-To: <20190611185548.GA31214@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Oleg Nesterov' <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>, "dave@stgolabs.net" <dave@stgolabs.net>, "e@80x24.org" <e@80x24.org>, "jbaron@akamai.com" <jbaron@akamai.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "omar.kilani@gmail.com" <omar.kilani@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190612083953.cI322Yuj4WKPSQahicmOUtDBJsnhbytepcc1AgdT4D8@z>

From: Oleg Nesterov [mailto:oleg@redhat.com]
> Sent: 11 June 2019 19:56
> On 06/10, Eric W. Biederman wrote:
> >
> > Personally I don't think anyone sane would intentionally depend on this
> > and I don't think there is a sufficiently reliable way to depend on this
> > by accident that people would actually be depending on it.
> 
> Agreed.
> 
> As I said I like these changes and I see nothing wrong. To me they fix the
> current behaviour, or at least make it more consistent.
> 
> But perhaps this should be documented in the changelog? To make it clear
> that this change was intentional.

What happens if you run the test program I posted yesterday after the changes?

It looks like pselect() and epoll_pwait() operated completely differently.
pselect() would always calls the signal handlers.
epoll_pwait() only calls them when EINTR is returned.
So changing epoll_pwait() and pselect() to work the same way
is bound to break some applications.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
