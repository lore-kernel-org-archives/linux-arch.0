Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730913AbfEWQVa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 12:21:30 -0400
Date: Thu, 23 May 2019 18:21:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523162104.GD23070@redhat.com>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
 <20190523115118.pmscbd6kaqy37dym@brauner.io>
 <20190523141447.34s3kc3fuwmoeq7n@brauner.io>
 <20190523142826.omb7vgygudifmveq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523142826.omb7vgygudifmveq@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, torvalds@linux-foundation.org, fweimer@redhat.com, jannh@google.com, tglx@linutronix.de, arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Message-ID: <20190523162104.Nci_fjTzdC6KZHNvBQClA9wtxtEfLLjdaK95TOoCpJU@z>

On 05/23, Christian Brauner wrote:
>
> So given that we would really need another find_next_open_fd() I think
> sticking to the simple cond_resched() version I sent before is better
> for now until we see real-world performance issues.

OK, agreed.

Oleg.
