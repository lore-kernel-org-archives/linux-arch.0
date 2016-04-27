From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 09/16] rtc: m68k: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 01:04:23 +0200
Message-ID: <4642144.cyaFZ6JYuF@wuerfel>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de> <1461796470-1291527-10-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1461796470-1291527-10-git-send-email-arnd@arndb.de>
Sender: linux-m68k-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arch@vger.kernel.org, a.zummo@towertech.it, dalias@libc.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, rtc-linux@googlegroups.com
List-Id: linux-arch.vger.kernel.org

On Thursday 28 April 2016 00:34:23 Arnd Bergmann wrote:
>                 return -ENODEV;
>  
> -       pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +       /* or just call devm_rtc_device_register instead? */

Oops, I was planning to remove the comment here.

I probably have to do a v4 anyway, fixed it up locally now.

	Arnd
