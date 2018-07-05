From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038 changes
Date: Thu, 5 Jul 2018 15:06:48 +0800
Message-ID: <201807051322.sUohKhUO%fengguang.wu@intel.com>
References: <20180703054422.12089-4-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703054422.12089-4-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: kbuild-all@01.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Deepa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on next-20180704]
[cannot apply to linus/master v4.18-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Deepa-Dinamani/arm64-Make-basic-compat_-types-always-available/20180703-151440
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from include/linux/compat.h:10,
                    from include/linux/ethtool.h:17,
                    from include/linux/netdevice.h:41,
                    from drivers/net/mii.c:32:
>> include/linux/compat_time.h:29:2: error: unknown type name 'compat_uint_t'
     compat_uint_t modes;
     ^~~~~~~~~~~~~
>> include/linux/compat_time.h:30:2: error: unknown type name 'compat_long_t'
     compat_long_t offset;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:31:2: error: unknown type name 'compat_long_t'
     compat_long_t freq;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:32:2: error: unknown type name 'compat_long_t'
     compat_long_t maxerror;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:33:2: error: unknown type name 'compat_long_t'
     compat_long_t esterror;
     ^~~~~~~~~~~~~
>> include/linux/compat_time.h:34:2: error: unknown type name 'compat_int_t'
     compat_int_t status;
     ^~~~~~~~~~~~
   include/linux/compat_time.h:35:2: error: unknown type name 'compat_long_t'
     compat_long_t constant;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:36:2: error: unknown type name 'compat_long_t'
     compat_long_t precision;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:37:2: error: unknown type name 'compat_long_t'
     compat_long_t tolerance;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:39:2: error: unknown type name 'compat_long_t'
     compat_long_t tick;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:40:2: error: unknown type name 'compat_long_t'
     compat_long_t ppsfreq;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:41:2: error: unknown type name 'compat_long_t'
     compat_long_t jitter;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:42:2: error: unknown type name 'compat_int_t'
     compat_int_t shift;
     ^~~~~~~~~~~~
   include/linux/compat_time.h:43:2: error: unknown type name 'compat_long_t'
     compat_long_t stabil;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:44:2: error: unknown type name 'compat_long_t'
     compat_long_t jitcnt;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:45:2: error: unknown type name 'compat_long_t'
     compat_long_t calcnt;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:46:2: error: unknown type name 'compat_long_t'
     compat_long_t errcnt;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:47:2: error: unknown type name 'compat_long_t'
     compat_long_t stbcnt;
     ^~~~~~~~~~~~~
   include/linux/compat_time.h:48:2: error: unknown type name 'compat_int_t'
     compat_int_t tai;
     ^~~~~~~~~~~~
>> include/linux/compat_time.h:50:2: error: expected specifier-qualifier-list before 'compat_int_t'
     compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
     ^~~~~~~~~~~~

vim +/compat_uint_t +29 include/linux/compat_time.h

    27	
    28	struct compat_timex {
  > 29		compat_uint_t modes;
  > 30		compat_long_t offset;
  > 31		compat_long_t freq;
    32		compat_long_t maxerror;
    33		compat_long_t esterror;
  > 34		compat_int_t status;
    35		compat_long_t constant;
    36		compat_long_t precision;
    37		compat_long_t tolerance;
    38		struct compat_timeval time;
    39		compat_long_t tick;
    40		compat_long_t ppsfreq;
    41		compat_long_t jitter;
    42		compat_int_t shift;
    43		compat_long_t stabil;
    44		compat_long_t jitcnt;
    45		compat_long_t calcnt;
  > 46		compat_long_t errcnt;
    47		compat_long_t stbcnt;
    48		compat_int_t tai;
    49	
  > 50		compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
    51		compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
    52		compat_int_t:32; compat_int_t:32; compat_int_t:32;
    53	};
    54	
    55	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KX5ogY2rg/4PQqQjlhAMAQA=

--rwEMma7ioTxnRzrJ--
