From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/3] compiler.h: Allow arch-specific overrides
Date: Wed, 18 Apr 2018 03:19:47 +0800
Message-ID: <201804180342.6jrQJ6v3%fengguang.wu@intel.com>
References: <cbf1a73e1c751fc8db124f974e268bab0d9727a5.1523959603.git-series.jhogan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbf1a73e1c751fc8db124f974e268bab0d9727a5.1523959603.git-series.jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/James-Hogan/MIPS-Override-barrier_before_unreachable-to-fix-microMIPS/20180418-025742
base:    
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from ./arch/x86/include/generated/asm/compiler.h:1:0,
                    from include/linux/compiler_types.h:58,
                    from <command-line>:0:
>> include/asm-generic/compiler.h:2:2: error: #error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
    #error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
     ^~~~~
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +2 include/asm-generic/compiler.h

   > 2	#error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
     3	#endif
     4	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vHr/zdu9V8vV8ymTcYIm9va6eYFmtfH7qDXaQsC23LxRtNXHZE61fzksXqFLv09r1vguajDl
OZZ3/XB1mmN19ryc+gW5E5mRzn6Kswmk5tppa83FFH3ejm3PZkPriBH9EnZ5GIAx0JwxAFnC
5mWat4vMRIbljy44Nu6eKYDOZewKJ8JkKE/g1HbeQDV+aZ1MQQbSwvpJOZEpQ1Nx5eRCnzmb
s/LqLk3QP6eNQ4cLx3M7rr7jViPxh9aVuCmnIC1nQ/Rm66ftZvXUZoNALJeC9v8C5sjL9kNH
G/nOMCmyXK1faISlkc7e2Wi60MwkT0itFw58UrFIetJkHa5jBiYY6hUPHJnEY7IRVuu6dgoA
zst8RGtk4Acj5qqvk+OYnz5B5J1etotW3qiTZgkxd21luwX9gS3ngaCu9Yiipf6I2KGy1Zml
dFQvmPpR5HBZQxihvlwXDjQJTFG9A04srXQ+QwvZmd5fCqlpecC0aahuSkd2OcSCJgdNgm8B
bkmPXN/MLL/1/HI1uOm1OrmrDk8bc6nQnEuj4mDyXJ83ND8ScZBzej/NozvaS7C/FuCg2v+D
83LQ8YbBnDd8QHOHu5LGw22pn1F9Wyy/d9+ump/QACsQxmysWh6q6fW+Xa33303q4emtAmvf
+JDNhJU04jc2PyZwqmP641QkCUKNBSIDjpv6wDZv73AEv5uHtnB2y+8788Glbd9SfqtN1OOP
DjjS0ealBSgp/lhJlnOfae543GdZk8L8mgQna6BtpSqOdn95cXXTxsdcZCVTSel8Z4fFz+YL
TNFYWqQg5xhVJyPpeA5o62tm6dlrjZC6CIw4Xqoou7LhczhlnzuhVCWYM3FkD7tMdltl6kjZ
1LOR5p06Z5NjBQYtzgw9DJDl7r1CZyhbxn+UyAS8VYjNg+rr4eWlX2yG+2TqlJUT57o/seHe
7kwKJVMXoNphcomv7Ac/PdHjkiN8VeZ8HVMvEsxVDLs1PKMj5cwX7HOUQvXKYHpcU6rc5pQh
qHnAZ+8VNHUIZ4avC6XwQfb5pZrZIoCHsfndBGoxR/K5RUe9y6j6JhTkwosh2jq8WxiJFuuX
nhsf6t5LMBqohy/GHNNBIuB6Ojav6OiU5BcyK9mSuRQUAbRM9ow8Re+Xqlki5oPx2rpVN2Kr
7a144O/dDACut6c4xITzjPqFAtzTRu28D7v31dqkl//bezvsqx8V/APrKj6ayop6WOO2mLEx
Um9Zl7YpnZ53XswYWAN1ThiIwLsvn/hk/Oy972xmmfAt7ixjDvfW8ppJuSHEMh0zQTFs6b+M
hbuDjycVj0PEE3qe5qsgh+YdiBN2mnXUg9GwfvoBLXoQBHlYIP4cBOf47uPM9U+NVBbpzq1U
nEXKTPwbhzoHx8d3oefO+P8KuXbtBmEY+kt5LF2JIalPgkPBaR4LQ0+Hrj3t0L+vJBuwhUTG
IEHAAluS772mhWdx3hZCioQaHOK6gtxNAjKrg0nszmdxISd1wEnW4y1OxEtvaRSO6Vt9WR1G
gvOalewd8Zaiz5CijLxXRXAtJ1OTE6ePjtZDWzSvss/ARRa52rmRmJgSUTea60DSg8wPKivm
EhFw4R4C5ZjzaeOJ9UD/S5JlZR7b65HNiNFy7JEoWodXB6/PO6Np00d9vSjXcCT8o+A8p2+/
qBuZJTiRQ4+HMus+4++lBOKy6woHV4b1HzVUAp1xynLRupx/YH+it11A+1TZfgV2cyEj2J07
wjh6RS4mAGkXBEmoK+yfAIiucpMicKt1JYa4gkJlhyo42tDWtT0rH5E9B/E92grpV7eX1bTC
c1uVEEhy2yUI+G1kK1FHtjMb/VkKFJwMStk0eoT/W/ZxDCE2jlicetJbTNMX0xTzj2boAAxi
PYmoHosFzPNKg3RkLfV7ZQa9uKt1UDrpLEXuiAzFEdvVfX78fn/9/Em167G6K+ioylxa6+8w
YVQd9VGJo7zoq/VOMgEJbf33MJ0OLNY5BpBFabq7ImEhcGuuzYcdJ11Y7z2D5McKwz4KPm2F
9HO+KRtPHGU1fOtMc4eInWt6rDkaD11OlVOsewhk1JXcWUGvDAG5AxyTmdjhScgDJdZIw6k5
2VxoxbSmN8Z6Ob5gXcscKDzPr1elleGtaLYeEg3NupU72mCRiaVgkJEEJ7ujy2mKfUYmmIY0
crtZzk5vD1SZFV+dDkc7pc+EQziZcqpLl6uo4kJc2harNaiismDAYm+VVL6Uyz4SBWRaUzz8
He4vFtZlSBP4qN1BfPp/4HkvDOJXAAA=

--ZGiS0Q5IWpPtfppv--
