Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:25599 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389125AbfFKLPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jun 2019 07:15:01 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Date: Tue, 11 Jun 2019 11:14:57 +0000
Message-ID: <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>     <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
 <87lfy96sta.fsf@xmission.com>
 <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
In-Reply-To: <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Oleg Nesterov' <oleg@redhat.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Deepa Dinamani' <deepa.kernel@gmail.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'arnd@arndb.de'" <arnd@arndb.de>, "'dbueso@suse.de'" <dbueso@suse.de>, "'axboe@kernel.dk'" <axboe@kernel.dk>, "'dave@stgolabs.net'" <dave@stgolabs.net>, "'e@80x24.org'" <e@80x24.org>, "'jbaron@akamai.com'" <jbaron@akamai.com>, "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>, "'linux-aio@kvack.org'" <linux-aio@kvack.org>, "'omar.kilani@gmail.com'" <omar.kilani@gmail.com>, "'tglx@linutronix.de'" <tglx@linutronix.de>, 'Al Viro' <viro@ZenIV.linux.org.uk>, 'Linus Torvalds' <torvalds@linux-foundation.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>
Message-ID: <20190611111457.fF4XQJgjWbrGETc-Ti3wnmFTYif1O34LqXLgCGmU4x4@z>

From: David Laight
> Sent: 11 June 2019 10:52
...
> If I have an application that has a loop with a pselect call that
> enables SIGINT (without a handler) and, for whatever reason,
> one of the fd is always 'ready' then I'd expect a SIGINT
> (from ^C) to terminate the program.
> 
> A quick test program:
> 
> #include <sys/time.h>
> #include <sys/types.h>
> #include <unistd.h>
> 
> #include <sys/select.h>
> #include <signal.h>
> 
> int main(int argc, char **argv)
> {
>         fd_set readfds;
>         sigset_t sig_int;
>         struct timespec delay = {1, 0};
> 
>         sigfillset(&sig_int);
>         sigdelset(&sig_int, SIGINT);
> 
>         sighold(SIGINT);
> 
>         for (;;) {
>                 FD_ZERO(&readfds);
>                 FD_SET(0, &readfds);
>                 pselect(1, &readfds, NULL, NULL, &delay, &sig_int);
> 
>                 poll(0,0,1000);
>         }
> }
> 
> Run under strace to see what is happening and send SIGINT from a different terminal.
> The program sleeps for a second in each of the pselect() and poll() calls.
> Send a SIGINT and in terminates after pselect() returns ERESTARTNOHAND.
> 
> Run again, this time press enter - making fd 0 readable.
> pselect() returns 1, but the program still exits.
> (Tested on a 5.1.0-rc5 kernel.)
> 
> If a signal handler were defined it should be called instead.

If I add a signal handler for SIGINT it is called when pselect()
returns regardless of the return value.

If I setup SIGUSR1/2 the same way as SIGINT and get the SIGINT
handler to sighold() and then raise both of them, the USR1/2
handlers are both called on the next pselect() call.
(Without the extra sighold() the handlers are called when kill()
returns.)

I'd expect the epoll functions to work the same way.

sigtimedwait is different though - it returns the number of the
pending signal (and doesn't call the handler).
So if two signals are pending neither handler should be called.
The second signal would be returned on the following sigtimedwait call.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
