Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34207 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfBRQoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 11:44:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so10365526qkc.1
        for <linux-arch@vger.kernel.org>; Mon, 18 Feb 2019 08:44:38 -0800 (PST)
Date: Mon, 18 Feb 2019 11:44:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [asm-generic:master 2/6] arch/x86//mm/mpx.c:57:26: error:
 'MAP_PRIVATE' undeclared; did you mean 'DQF_PRIVATE'?
Message-ID: <20190218114242-mutt-send-email-mst@kernel.org>
References: <201902190052.bZjV0Dgp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902190052.bZjV0Dgp%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Feb 19, 2019 at 12:28:55AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> head:   3c4fcc2648569c3fe573849f9254c8c3499ec648
> commit: 9ac483109d19095e22414e46d38a6817520883b9 [2/6] arch: move common mmap flags to linux/mman.h
> config: x86_64-kexec (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 9ac483109d19095e22414e46d38a6817520883b9
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86//mm/mpx.c: In function 'mpx_mmap':
> >> arch/x86//mm/mpx.c:57:26: error: 'MAP_PRIVATE' undeclared (first use in this function); did you mean 'DQF_PRIVATE'?
>              MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate, NULL);
>                              ^~~~~~~~~~~
>                              DQF_PRIVATE
>    arch/x86//mm/mpx.c:57:26: note: each undeclared identifier is reported only once for each function it appears in

Arnd I think you are missing:
    x86/mpx: tweak header name

The whole file is going away eventually:
https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com

but to avoid breaking bisect I think it's needed.


> vim +57 arch/x86//mm/mpx.c
> 
> 613fcb7d3 Dave Hansen   2015-06-07  41  
> 57319d80e Qiaowei Ren   2014-11-14  42  /*
> 57319d80e Qiaowei Ren   2014-11-14  43   * This is really a simplified "vm_mmap". it only handles MPX
> 57319d80e Qiaowei Ren   2014-11-14  44   * bounds tables (the bounds directory is user-allocated).
> 57319d80e Qiaowei Ren   2014-11-14  45   */
> 57319d80e Qiaowei Ren   2014-11-14  46  static unsigned long mpx_mmap(unsigned long len)
> 57319d80e Qiaowei Ren   2014-11-14  47  {
> 57319d80e Qiaowei Ren   2014-11-14  48  	struct mm_struct *mm = current->mm;
> 1fcfd8db7 Oleg Nesterov 2015-09-09  49  	unsigned long addr, populate;
> 57319d80e Qiaowei Ren   2014-11-14  50  
> eb099e5bc Dave Hansen   2015-06-07  51  	/* Only bounds table can be allocated here */
> 613fcb7d3 Dave Hansen   2015-06-07  52  	if (len != mpx_bt_size_bytes(mm))
> 57319d80e Qiaowei Ren   2014-11-14  53  		return -EINVAL;
> 57319d80e Qiaowei Ren   2014-11-14  54  
> 57319d80e Qiaowei Ren   2014-11-14  55  	down_write(&mm->mmap_sem);
> 1fcfd8db7 Oleg Nesterov 2015-09-09  56  	addr = do_mmap(NULL, 0, len, PROT_READ | PROT_WRITE,
> 897ab3e0c Mike Rapoport 2017-02-24 @57  		       MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate, NULL);
> 57319d80e Qiaowei Ren   2014-11-14  58  	up_write(&mm->mmap_sem);
> 1fcfd8db7 Oleg Nesterov 2015-09-09  59  	if (populate)
> 1fcfd8db7 Oleg Nesterov 2015-09-09  60  		mm_populate(addr, populate);
> 57319d80e Qiaowei Ren   2014-11-14  61  
> 1fcfd8db7 Oleg Nesterov 2015-09-09  62  	return addr;
> 57319d80e Qiaowei Ren   2014-11-14  63  }
> fcc7ffd67 Dave Hansen   2014-11-14  64  
> 
> :::::: The code at line 57 was first introduced by commit
> :::::: 897ab3e0c49e24b62e2d54d165c7afec6bbca65b userfaultfd: non-cooperative: add event for memory unmaps
> 
> :::::: TO: Mike Rapoport <rppt@linux.vnet.ibm.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
