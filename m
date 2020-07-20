From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: io_uring vs in_compat_syscall()
Date: Mon, 20 Jul 2020 08:10:46 +0200
Message-ID: <20200720061046.GA10678@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Jens,

I just found a (so far theoretical) issue with the io_uring submission
offloading to workqueues or threads.  We have lots of places using
in_compat_syscall() to check if a syscall needs compat treatmenet.
While the biggest users is iocttl(), we also have a fair amount of
places using in_compat_task() in read and write methods, and these
will not do the wrong thing when used with io_uring under certain
conditions.  I'm not sure how to best fix this, except for making sure
in_compat_syscall() returns true one way or another for these cases.
