From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/6] rtc: parisc: provide rtc_class_ops directly
Date: Wed, 27 Apr 2016 12:10:28 +0200
Message-ID: <4761768.yGo2yiDr2v@wuerfel>
References: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
Sender: linux-m68k-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, a.zummo@towertech.it, dalias@libc.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, kbuild-all@01.org, rtc-linux@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday 27 April 2016 08:22:24 kbuild test robot wrote:
> 
>    256  
>    257          memset(tm, 0, sizeof(*tm));
>    258          if (pdc_tod_read(&tod_data) < 0)
>    259                  return -EOPNOTSUPP;
>    260  
>    261          /* we treat tod_sec as unsigned, so this can work until year 2106 */
>  > 262          rtc_time64_to_tm(tod_data.tod_sec, &tm);
>    263          return rtc_valid_tm(tm);
>    264  }
> 

Fixed, thanks!

	Arnd
