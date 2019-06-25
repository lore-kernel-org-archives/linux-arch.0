From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [RFC] remove arch/sh?
Date: Tue, 25 Jun 2019 11:02:36 +0200
Message-ID: <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
References: <20190625085616.GA32399@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625085616.GA32399@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph!

On 6/25/19 10:56 AM, Christoph Hellwig wrote:
> arch/sh seems pretty much unmaintained these days.  The last time I got
> any reply to sh patches from the list maintainers, and the last maintainer
> pull request was over a year ago, and even that has been rather sporadic.
> 
> In the meantime we've not really seen any updates for new kernel features
> and code seems to be bitrotting.

We're still using sh4 in Debian and most of the stuff works fine. There is
one patch by Michael Karcher that fixes a bug in the kprobes code that someone
should pull in as it unbreaks the kernel with kprobes enabled [1].

Yoshinori Sato is still active sporadically and has a kernel tree here
where he collects patches for -next [2].

Otherwise, the kernel works fine.

Adrian

> [1] https://marc.info/?l=linux-sh&m=156034655921917&w=2
> [2] https://osdn.net/projects/uclinux-h8/scm/git/linux/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
