From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Tue, 11 Jun 2019 14:02:41 -0500
Message-ID: <87zhmo54j2.fsf@xmission.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
	<20190529161157.GA27659@redhat.com>
	<20190604134117.GA29963@redhat.com>
	<20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
	<87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
	<87lfy96sta.fsf@xmission.com> <20190611185548.GA31214@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190611185548.GA31214@redhat.com> (Oleg Nesterov's message of
	"Tue, 11 Jun 2019 20:55:49 +0200")
Sender: owner-linux-aio@kvack.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/10, Eric W. Biederman wrote:
>>
>> Personally I don't think anyone sane would intentionally depend on this
>> and I don't think there is a sufficiently reliable way to depend on this
>> by accident that people would actually be depending on it.
>
> Agreed.
>
> As I said I like these changes and I see nothing wrong. To me they fix the
> current behaviour, or at least make it more consistent.
>
> But perhaps this should be documented in the changelog? To make it clear
> that this change was intentional.

Good point.  I had not documented it because I thought I was only
disabling an optimization.

Eric

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
