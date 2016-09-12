Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbcILU3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 16:29:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Build failures in -next: sys_pkey_mprotect etc. undefined
Date: Mon, 12 Sep 2016 22:28:56 +0200
Message-ID: <3540553.8BkpiafJJ2@wuerfel>
In-Reply-To: <57D70B6D.6010208@linux.intel.com>
References: <9d74497b-1522-b350-42fa-49df2df48c4a@roeck-us.net> <57D70B6D.6010208@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, "open list:ABI/API" <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160912202856.KnviCfS9PFJRPpcRPINZKi0I_CipeGR_W7OLY3ZXs4U@z>

On Monday, September 12, 2016 1:09:17 PM CEST Dave Hansen wrote:
> 
> So, I've done what Arnd suggested, but I don't have a working
> cross-compiler than can do h8300 or c6x.  Could you test the attached
> patch and see if it gets things working for you?
> 
> Also, do you have a handy place to grab a cross-compiler for h8300
> without having to build one?  The kernel.org ones don't seem to work for
> h8300.
> 

I haven't tested it, but it looks good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>

FWIW, you should be able to test this with an arm64 cross-compiler
too, many distros ship one.

	Arnd
