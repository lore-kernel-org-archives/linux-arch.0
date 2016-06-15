From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
Date: Wed, 15 Jun 2016 17:49:39 +0800
Message-ID: <201606151719.MK20Hmoq%fengguang.wu@intel.com>
References: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12987 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbcFOJuo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 05:50:44 -0400
Content-Disposition: inline
In-Reply-To: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test WARNING on asm-generic/master]
[also build test WARNING on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pan-Xinhui/locking-qrwlock-Let-qrwlock-has-same-layout-regardless-of-the-endian/20160615-172044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic master
config: x86_64-randconfig-x016-201624 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/qrwlock.h:5:0,
                    from arch/x86/include/asm/spinlock.h:219,
                    from include/linux/spinlock.h:87,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:8:
   include/asm-generic/qrwlock.h: In function 'queued_read_can_lock':
   include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/asm-generic/qrwlock.h:55:38: note: in expansion of macro '_QW_WMASK'
     return !(atomic_read(&lock->cnts) & _QW_WMASK);
                                         ^~~~~~~~~
   include/asm-generic/qrwlock.h:40:29: note: each undeclared identifier is reported only once for each function it appears in
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/asm-generic/qrwlock.h:55:38: note: in expansion of macro '_QW_WMASK'
     return !(atomic_read(&lock->cnts) & _QW_WMASK);
                                         ^~~~~~~~~
   In file included from arch/x86/include/asm/atomic.h:4:0,
                    from include/linux/atomic.h:4,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:8:
   include/asm-generic/qrwlock.h: In function 'queued_read_trylock':
   include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> include/asm-generic/qrwlock.h:77:2: note: in expansion of macro 'if'
     if (likely(!(cnts & _QW_WMASK))) {
     ^~
>> include/asm-generic/qrwlock.h:77:6: note: in expansion of macro 'likely'
     if (likely(!(cnts & _QW_WMASK))) {
         ^~~~~~
   include/asm-generic/qrwlock.h:77:22: note: in expansion of macro '_QW_WMASK'
     if (likely(!(cnts & _QW_WMASK))) {
                         ^~~~~~~~~
   include/asm-generic/qrwlock.h: In function 'queued_write_trylock':
   include/asm-generic/qrwlock.h:39:30: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_LOCKED (0xffU << _QW_SHIFT) /* A writer holds the lock */
                                 ^
   include/linux/compiler.h:138:43: note: in definition of macro 'likely'
    #  define likely(x) (__builtin_constant_p(x) ? !!(x) : __branch_check__(x, 1))
                                              ^
   include/asm-generic/qrwlock.h:100:24: note: in expansion of macro '_QW_LOCKED'
              cnts, cnts | _QW_LOCKED) == cnts);
                           ^~~~~~~~~~
   include/asm-generic/qrwlock.h: In function 'queued_read_lock':
   include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   include/asm-generic/qrwlock.h:111:2: note: in expansion of macro 'if'
     if (likely(!(cnts & _QW_WMASK)))
     ^~
   include/asm-generic/qrwlock.h:111:6: note: in expansion of macro 'likely'
     if (likely(!(cnts & _QW_WMASK)))
         ^~~~~~
   include/asm-generic/qrwlock.h:111:22: note: in expansion of macro '_QW_WMASK'
     if (likely(!(cnts & _QW_WMASK)))
                         ^~~~~~~~~
   include/asm-generic/qrwlock.h: In function 'queued_write_lock':
   include/asm-generic/qrwlock.h:39:30: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_LOCKED (0xffU << _QW_SHIFT) /* A writer holds the lock */
                                 ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   include/asm-generic/qrwlock.h:125:2: note: in expansion of macro 'if'
     if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
     ^~
   include/asm-generic/qrwlock.h:125:45: note: in expansion of macro '_QW_LOCKED'
     if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
                                                ^~~~~~~~~~
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/if +77 include/asm-generic/qrwlock.h

c85626c3 Pan Xinhui  2016-06-15  34  #define	_QR_SHIFT	0		/* Reader count shift	   */
c85626c3 Pan Xinhui  2016-06-15  35  #define	_QW_SHIFT	24		/* Writer mode shift	*/
c85626c3 Pan Xinhui  2016-06-15  36  #endif
c85626c3 Pan Xinhui  2016-06-15  37  
c85626c3 Pan Xinhui  2016-06-15  38  #define	_QW_WAITING	(1U << _QW_SHIFT)	/* A writer is waiting	   */
c85626c3 Pan Xinhui  2016-06-15  39  #define	_QW_LOCKED	(0xffU << _QW_SHIFT)	/* A writer holds the lock */
c85626c3 Pan Xinhui  2016-06-15 @40  #define	_QW_WMASK	(0xffU << _QW_SHIFT)	/* Writer mask		   */
70af2f8a Waiman Long 2014-02-03  41  #define	_QR_BIAS	(1U << _QR_SHIFT)
70af2f8a Waiman Long 2014-02-03  42  
70af2f8a Waiman Long 2014-02-03  43  /*
70af2f8a Waiman Long 2014-02-03  44   * External function declarations
70af2f8a Waiman Long 2014-02-03  45   */
0e06e5be Waiman Long 2015-06-19  46  extern void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts);
f7d71f20 Waiman Long 2015-06-19  47  extern void queued_write_lock_slowpath(struct qrwlock *lock);
70af2f8a Waiman Long 2014-02-03  48  
70af2f8a Waiman Long 2014-02-03  49  /**
f7d71f20 Waiman Long 2015-06-19  50   * queued_read_can_lock- would read_trylock() succeed?
70af2f8a Waiman Long 2014-02-03  51   * @lock: Pointer to queue rwlock structure
70af2f8a Waiman Long 2014-02-03  52   */
f7d71f20 Waiman Long 2015-06-19  53  static inline int queued_read_can_lock(struct qrwlock *lock)
70af2f8a Waiman Long 2014-02-03  54  {
70af2f8a Waiman Long 2014-02-03  55  	return !(atomic_read(&lock->cnts) & _QW_WMASK);
70af2f8a Waiman Long 2014-02-03  56  }
70af2f8a Waiman Long 2014-02-03  57  
70af2f8a Waiman Long 2014-02-03  58  /**
f7d71f20 Waiman Long 2015-06-19  59   * queued_write_can_lock- would write_trylock() succeed?
70af2f8a Waiman Long 2014-02-03  60   * @lock: Pointer to queue rwlock structure
70af2f8a Waiman Long 2014-02-03  61   */
f7d71f20 Waiman Long 2015-06-19  62  static inline int queued_write_can_lock(struct qrwlock *lock)
70af2f8a Waiman Long 2014-02-03  63  {
70af2f8a Waiman Long 2014-02-03  64  	return !atomic_read(&lock->cnts);
70af2f8a Waiman Long 2014-02-03  65  }
70af2f8a Waiman Long 2014-02-03  66  
70af2f8a Waiman Long 2014-02-03  67  /**
f7d71f20 Waiman Long 2015-06-19  68   * queued_read_trylock - try to acquire read lock of a queue rwlock
70af2f8a Waiman Long 2014-02-03  69   * @lock : Pointer to queue rwlock structure
70af2f8a Waiman Long 2014-02-03  70   * Return: 1 if lock acquired, 0 if failed
70af2f8a Waiman Long 2014-02-03  71   */
f7d71f20 Waiman Long 2015-06-19  72  static inline int queued_read_trylock(struct qrwlock *lock)
70af2f8a Waiman Long 2014-02-03  73  {
70af2f8a Waiman Long 2014-02-03  74  	u32 cnts;
70af2f8a Waiman Long 2014-02-03  75  
70af2f8a Waiman Long 2014-02-03  76  	cnts = atomic_read(&lock->cnts);
70af2f8a Waiman Long 2014-02-03 @77  	if (likely(!(cnts & _QW_WMASK))) {
77e430e3 Will Deacon 2015-08-06  78  		cnts = (u32)atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
70af2f8a Waiman Long 2014-02-03  79  		if (likely(!(cnts & _QW_WMASK)))
70af2f8a Waiman Long 2014-02-03  80  			return 1;

:::::: The code at line 77 was first introduced by commit
:::::: 70af2f8a4f48d6cebdf92d533d3aef37853ce6de locking/rwlocks: Introduce 'qrwlocks' - fair, queued rwlocks

:::::: TO: Waiman Long <Waiman.Long@hp.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
St6hNkQH/w93l/JA5VsBAA==

--J2SCkAp4GZ/dPZZf--
