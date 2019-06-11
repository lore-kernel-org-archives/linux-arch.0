From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 0/5]: Removing saved_sigmask
Date: Tue, 11 Jun 2019 20:58:58 +0200
Message-ID: <20190611185857.GB31214@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com>
Sender: stable-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, stable@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 06/07, Eric W. Biederman wrote:
>
> Eric W. Biederman (5):
>       signal: Teach sigsuspend to use set_user_sigmask
>       signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
>       signal: Always keep real_blocked in sync with blocked
>       signal: Remove saved_sigmask
>       signal: Remove the unnecessary restore_sigmask flag

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



I guess this should be routed via -mm tree? This depends on
signal-simplify-set_user_sigmask-restore_user_sigmask.patch

Oleg.
