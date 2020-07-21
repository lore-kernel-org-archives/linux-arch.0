From: Christoph Hellwig <hch@lst.de>
Subject: Re: io_uring vs in_compat_syscall()
Date: Tue, 21 Jul 2020 09:07:09 +0200
Message-ID: <20200721070709.GB11432@lst.de>
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk> <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50851 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgGUHHM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 03:07:12 -0400
Content-Disposition: inline
In-Reply-To: <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org

On Mon, Jul 20, 2020 at 10:28:55AM -0700, Andy Lutomirski wrote:
> > Sure, I'd consider that implementation detail for the actual patch(es)
> > for this issue.
> 
> There’s a corner case, though: doesn’t io_uring submission frequently do the work synchronously in the context of the calling thread?

Yes.

> If so, can a thread do a 64-bit submit with 32-bit work or vice versa?

In theory you could share an fd created in a 32-bit thread to a 64-bit
thread or vice versa, but I think at that point you absolutely are in
"you get to keep the pieces" land.

> Sometimes I think that in_compat_syscall() should have a mode in which calling it warns (e.g. not actually in a syscall when doing things in io_uring).  And the relevant operations should be properly wired up to avoid global state like this.

What do you mean with "properly wired up".  Do you really want to spread
->compat_foo methods everywhere, including read and write?  I found
in_compat_syscall() a lot small and easier to maintain than all the
separate compat cruft.
