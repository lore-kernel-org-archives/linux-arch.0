From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/5] kernel hacking: GCC optimization for debug
 experience (-Og)
Date: Wed, 2 May 2018 09:33:15 +0200
Message-ID: <20180502073315.sso3aaak45aeuyst@gmail.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* changbin.du@intel.com <changbin.du@intel.com> wrote:

> Comparison of system performance: a bit drop.
> 
>     w/o CONFIG_DEBUG_EXPERIENCE
>     $ time make -j4
>     real    6m43.619s
>     user    19m5.160s
>     sys     2m20.287s
> 
>     w/ CONFIG_DEBUG_EXPERIENCE
>     $ time make -j4
>     real    6m55.054s
>     user    19m11.129s
>     sys     2m36.345s

Sorry, that's not a proper kbuild performance measurement - there's no noise 
estimation at all.

Below is a description that should produce more reliable numbers.

Thanks,

	Ingo


=========================>

So here's a pretty reliable way to measure kernel build time, which tries to avoid 
the various pitfalls of caching.

First I make sure that cpufreq is set to 'performance':

  for ((cpu=0; cpu<120; cpu++)); do
    G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    [ -f $G ] && echo performance > $G
  done

[ ... because it can be *really* annoying to discover that an ostensible 
  performance regression was a cpufreq artifact ... again. ;-) ]

Then I copy a kernel tree to /tmp (ramfs) as root:

	cd /tmp
	rm -rf linux
	git clone ~/linux linux
	cd linux
	make defconfig >/dev/null
	
... and then we can build the kernel in such a loop (as root again):

  perf stat --repeat 10 --null --pre			'\
	cp -a kernel ../kernel.copy.$(date +%s);	 \
	rm -rf *;					 \
	git checkout .;					 \
	echo 1 > /proc/sys/vm/drop_caches;		 \
	find ../kernel* -type f | xargs cat >/dev/null;  \
	make -j kernel >/dev/null;			 \
	make clean >/dev/null 2>&1;			 \
	sync						'\
							 \
	make -j16 >/dev/null

( I have tested these by pasting them into a terminal. Adjust the ~/linux source 
  git tree and the '-j16' to your system. )

Notes:

 - the 'pre' script portion is not timed by 'perf stat', only the raw build times

 - we flush all caches via drop_caches and re-establish everything again, but:

 - we also introduce an intentional memory leak by slowly filling up ramfs with 
   copies of 'kernel/', thus continously changing the layout of free memory, 
   cached data such as compiler binaries and the source code hierarchy. (Note 
   that the leak is about 8MB per iteration, so it isn't massive.)

With 10 iterations this is the statistical stability I get this on a big box:

 Performance counter stats for 'make -j128 kernel' (10 runs):

      26.346436425 seconds time elapsed    (+- 0.19%)

... which, despite a high iteration count of 10, is still surprisingly noisy, 
right?

A 0.2% stddev is probably not enough to call a 0.7% regression with good 
confidence, so I had to use *30* iterations to make measurement noise to be about 
an order of magnitude lower than the effect I'm trying to measure:

 Performance counter stats for 'make -j128' (30 runs):

      26.334767571 seconds time elapsed    (+- 0.09% )

i.e. "26.334 +- 0.023" seconds is a number we can have pretty high confidence in, 
on this system.

And just to demonstrate that it's all real, I repeated the whole 30-iteration 
measurement again:

 Performance counter stats for 'make -j128' (30 runs):

      26.311166142 seconds time elapsed    (+- 0.07%)
