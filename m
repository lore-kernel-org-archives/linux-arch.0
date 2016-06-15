From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
Date: Wed, 15 Jun 2016 17:46:32 +0800
Message-ID: <201606151748.6jdOBvsB%fengguang.wu@intel.com>
References: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18535 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcFOJrr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 05:47:47 -0400
Content-Disposition: inline
In-Reply-To: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, will.deacon@arm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test ERROR on asm-generic/master]
[also build test ERROR on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pan-Xinhui/locking-qrwlock-Let-qrwlock-has-same-layout-regardless-of-the-endian/20160615-172044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic master
config: x86_64-randconfig-x014-201624 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/qrwlock.h:5:0,
                    from arch/x86/include/asm/spinlock.h:219,
                    from include/linux/spinlock.h:87,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:8:
   include/asm-generic/qrwlock.h: In function 'queued_read_can_lock':
>> include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
>> include/asm-generic/qrwlock.h:55:38: note: in expansion of macro '_QW_WMASK'
     return !(atomic_read(&lock->cnts) & _QW_WMASK);
                                         ^~~~~~~~~
   include/asm-generic/qrwlock.h:40:29: note: each undeclared identifier is reported only once for each function it appears in
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
>> include/asm-generic/qrwlock.h:55:38: note: in expansion of macro '_QW_WMASK'
     return !(atomic_read(&lock->cnts) & _QW_WMASK);
                                         ^~~~~~~~~
   In file included from arch/x86/include/asm/atomic.h:4:0,
                    from include/linux/atomic.h:4,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:8:
   include/asm-generic/qrwlock.h: In function 'queued_read_trylock':
>> include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/linux/compiler.h:169:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   include/asm-generic/qrwlock.h:77:22: note: in expansion of macro '_QW_WMASK'
     if (likely(!(cnts & _QW_WMASK))) {
                         ^~~~~~~~~
   include/asm-generic/qrwlock.h: In function 'queued_write_trylock':
   include/asm-generic/qrwlock.h:39:30: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_LOCKED (0xffU << _QW_SHIFT) /* A writer holds the lock */
                                 ^
   include/linux/compiler.h:169:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
>> include/asm-generic/qrwlock.h:100:24: note: in expansion of macro '_QW_LOCKED'
              cnts, cnts | _QW_LOCKED) == cnts);
                           ^~~~~~~~~~
   include/asm-generic/qrwlock.h: In function 'queued_read_lock':
>> include/asm-generic/qrwlock.h:40:29: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_WMASK (0xffU << _QW_SHIFT) /* Writer mask     */
                                ^
   include/linux/compiler.h:169:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   include/asm-generic/qrwlock.h:111:22: note: in expansion of macro '_QW_WMASK'
     if (likely(!(cnts & _QW_WMASK)))
                         ^~~~~~~~~
   In file included from arch/x86/include/asm/qrwlock.h:5:0,
                    from arch/x86/include/asm/spinlock.h:219,
                    from include/linux/spinlock.h:87,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:8:
   include/asm-generic/qrwlock.h: In function 'queued_write_lock':
   include/asm-generic/qrwlock.h:39:30: error: '_QW_SHIFT' undeclared (first use in this function)
    #define _QW_LOCKED (0xffU << _QW_SHIFT) /* A writer holds the lock */
                                 ^
   include/asm-generic/qrwlock.h:125:45: note: in expansion of macro '_QW_LOCKED'
     if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
                                                ^~~~~~~~~~
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/_QW_SHIFT +40 include/asm-generic/qrwlock.h

    33	#else
    34	#define	_QR_SHIFT	0		/* Reader count shift	   */
    35	#define	_QW_SHIFT	24		/* Writer mode shift	*/
    36	#endif
    37	
    38	#define	_QW_WAITING	(1U << _QW_SHIFT)	/* A writer is waiting	   */
  > 39	#define	_QW_LOCKED	(0xffU << _QW_SHIFT)	/* A writer holds the lock */
  > 40	#define	_QW_WMASK	(0xffU << _QW_SHIFT)	/* Writer mask		   */
    41	#define	_QR_BIAS	(1U << _QR_SHIFT)
    42	
    43	/*
    44	 * External function declarations
    45	 */
    46	extern void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts);
    47	extern void queued_write_lock_slowpath(struct qrwlock *lock);
    48	
    49	/**
    50	 * queued_read_can_lock- would read_trylock() succeed?
    51	 * @lock: Pointer to queue rwlock structure
    52	 */
    53	static inline int queued_read_can_lock(struct qrwlock *lock)
    54	{
  > 55		return !(atomic_read(&lock->cnts) & _QW_WMASK);
    56	}
    57	
    58	/**
    59	 * queued_write_can_lock- would write_trylock() succeed?
    60	 * @lock: Pointer to queue rwlock structure
    61	 */
    62	static inline int queued_write_can_lock(struct qrwlock *lock)
    63	{
    64		return !atomic_read(&lock->cnts);
    65	}
    66	
    67	/**
    68	 * queued_read_trylock - try to acquire read lock of a queue rwlock
    69	 * @lock : Pointer to queue rwlock structure
    70	 * Return: 1 if lock acquired, 0 if failed
    71	 */
    72	static inline int queued_read_trylock(struct qrwlock *lock)
    73	{
    74		u32 cnts;
    75	
    76		cnts = atomic_read(&lock->cnts);
    77		if (likely(!(cnts & _QW_WMASK))) {
    78			cnts = (u32)atomic_add_return_acquire(_QR_BIAS, &lock->cnts);
    79			if (likely(!(cnts & _QW_WMASK)))
    80				return 1;
    81			atomic_sub(_QR_BIAS, &lock->cnts);
    82		}
    83		return 0;
    84	}
    85	
    86	/**
    87	 * queued_write_trylock - try to acquire write lock of a queue rwlock
    88	 * @lock : Pointer to queue rwlock structure
    89	 * Return: 1 if lock acquired, 0 if failed
    90	 */
    91	static inline int queued_write_trylock(struct qrwlock *lock)
    92	{
    93		u32 cnts;
    94	
    95		cnts = atomic_read(&lock->cnts);
    96		if (unlikely(cnts))
    97			return 0;
    98	
    99		return likely(atomic_cmpxchg_acquire(&lock->cnts,
 > 100						     cnts, cnts | _QW_LOCKED) == cnts);
   101	}
   102	/**
   103	 * queued_read_lock - acquire read lock of a queue rwlock

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--DocE+STaALJfprDB
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--DocE+STaALJfprDB--
