From: Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [fs] ce436509a8: ltp.openat203.fail
Date: Mon, 27 Apr 2020 16:27:33 +0200
Message-ID: <20200427142733.GD7661@rei>
References: <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200427135210.GB5770@shao2-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200427135210.GB5770@shao2-debian>
Sender: linux-fsdevel-owner@vger.kernel.org
To: kernel test robot <rong.a.chen@intel.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, lkp@lists.01.org, Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, ltp@lists.linux.it
List-Id: linux-arch.vger.kernel.org

Hi!
> commit: ce436509a8e109330c56bb4d8ec87d258788f5f4 ("[PATCH v4 2/3] fs: openat2: Extend open_how to allow userspace-selected fds")
> url: https://github.com/0day-ci/linux/commits/Josh-Triplett/Support-userspace-selected-fds/20200414-102939
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next

This commit adds fd parameter to the how structure where LTP test was
previously passing garbage, which obviously causes the difference in
errno.

This could be safely ignored for now, if the patch gets merged the test
needs to be updated.

-- 
chrubis@suse.cz
