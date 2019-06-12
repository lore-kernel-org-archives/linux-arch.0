Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55843 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbfFLNjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 09:39:05 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Wed, 12 Jun 2019 13:39:00 +0000
Message-ID: <4f5f36915e484b5a9d12e840c79f54cb@AcuMS.aculab.com>
References: <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
 <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
 <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com>
 <87pnnj2ca0.fsf@xmission.com>
 <a11bb1a2a6de4cf5aa773ea79c602f1a@AcuMS.aculab.com>
 <20190612133519.GA3276@redhat.com>
In-Reply-To: <20190612133519.GA3276@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190612133900.ozXwSFt7OoXLPtn4yEEonDosTf9FLyJsyGUAu-CjpZs@z>

From: Oleg Nesterov
> Sent: 12 June 2019 14:35
> On 06/12, David Laight wrote:
> >
> > > > If I add a signal handler for SIGINT it is called when pselect()
> > > > returns regardless of the return value.
> > >
> > > That is odd.  Is this with Oleg's fix applied?
> >
> > No it is a 5.1.0-rc5 kernel with no related local patches.
> > So it is the 'historic' behaviour of pselect().
> 
> No, this is not historic behaviour,
> 
> > But not the original one! Under 2.6.22-5-31 the signal handler isn't caller
> > when pselect() returns 1.
> 
> This is historic behaviour.
> 
> And it was broken by 854a6ed56839a4 ("signal: Add restore_user_sigmask()").
> 
> And this is what we already discussed many, many times in this thread ;)

My brain hurts :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
