From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v4 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Date: Sun, 19 Apr 2020 21:18:05 +0000
Message-ID: <7f02bf52254443e380c33cae7c1fd5f0@AcuMS.aculab.com>
References: <cover.1586830316.git.josh@joshtriplett.org>
 <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31722 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgDSVSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Apr 2020 17:18:10 -0400
In-Reply-To: <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Aleksa Sarai' <cyphar@cyphar.com>, Josh Triplett <josh@joshtriplett.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>

From: Aleksa Sarai
> Sent: 19 April 2020 11:44
> 
> On 2020-04-13, Josh Triplett <josh@joshtriplett.org> wrote:
> > Inspired by the X protocol's handling of XIDs, allow userspace to select
> > the file descriptor opened by openat2, so that it can use the resulting
> > file descriptor in subsequent system calls without waiting for the
> > response to openat2.
> >
> > In io_uring, this allows sequences like openat2/read/close without
> > waiting for the openat2 to complete. Multiple such sequences can
> > overlap, as long as each uses a distinct file descriptor.
> 
> I'm not sure I understand this explanation -- how can you trigger a
> syscall with an fd that hasn't yet been registered (unless you're just
> hoping the race goes in your favour)?

I suspect (there are no comments in the io_uring code to say what it does)
that the io_uring code uses a thread of the user process to sequentially
execute IO requests that the main application has added to a queue.

So it might make sense to queue up open/read/close.
But that ought to be within the io_uring code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
