From: Cyril Hrubis <chrubis-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [fs] ce436509a8: ltp.openat203.fail
Date: Tue, 28 Apr 2020 17:30:22 +0200
Message-ID: <20200428153022.GC4244@yuki.lan>
References: <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200427135210.GB5770@shao2-debian> <20200427142733.GD7661@rei>
 <20200428005126.6wncibudt6ohghvc@yavin.dot.cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ltp-bounces+glt-ltp-list=m.gmane-mx.org-cunTk1MwBs91InPhgRC9rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200428005126.6wncibudt6ohghvc-DDZ4AMo6ZIKk7xURhxcYY1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request-cunTk1MwBs91InPhgRC9rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp-cunTk1MwBs91InPhgRC9rw@public.gmane.org>
List-Help: <mailto:ltp-request-cunTk1MwBs91InPhgRC9rw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request-cunTk1MwBs91InPhgRC9rw@public.gmane.org?subject=subscribe>
Errors-To: ltp-bounces+glt-ltp-list=m.gmane-mx.org-cunTk1MwBs91InPhgRC9rw@public.gmane.org
Sender: "ltp" <ltp-bounces+glt-ltp-list=m.gmane-mx.org-cunTk1MwBs91InPhgRC9rw@public.gmane.org>
To: Aleksa Sarai <cyphar-gVpy/LI/lHzQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, kernel test robot <rong.a.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Josh Triplett <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>, lkp-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ltp-cunTk1MwBs91InPhgRC9rw@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi!
> > > commit: ce436509a8e109330c56bb4d8ec87d258788f5f4 ("[PATCH v4 2/3] fs: openat2: Extend open_how to allow userspace-selected fds")
> > > url: https://github.com/0day-ci/linux/commits/Josh-Triplett/Support-userspace-selected-fds/20200414-102939
> > > base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> > 
> > This commit adds fd parameter to the how structure where LTP test was
> > previously passing garbage, which obviously causes the difference in
> > errno.
> > 
> > This could be safely ignored for now, if the patch gets merged the test
> > needs to be updated.
> 
> It wouldn't be a bad idea to switch the test to figure out the ksize of
> the struct, so that you only add bad padding after that. But then again,
> this would be a bit ugly -- having CHECK_FIELDS would make this simpler.

Any pointers how can be the size figured out without relying on the
E2BIG we are testing for? Does the kernel export it somewhere?

-- 
Cyril Hrubis
chrubis-AlSwsSmVLrQ@public.gmane.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
