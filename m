Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27107 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbcILUe4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 16:34:56 -0400
Subject: Re: Build failures in -next: sys_pkey_mprotect etc. undefined
References: <9d74497b-1522-b350-42fa-49df2df48c4a@roeck-us.net>
 <57D70B6D.6010208@linux.intel.com> <3540553.8BkpiafJJ2@wuerfel>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57D7116E.4050708@linux.intel.com>
Date: Mon, 12 Sep 2016 13:34:54 -0700
MIME-Version: 1.0
In-Reply-To: <3540553.8BkpiafJJ2@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, "open list:ABI/API" <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160912203454.PahYrCA14CcUmZ9Q0bD3P8dhgGDXj0D1U2ohzRKEiYY@z>

On 09/12/2016 01:28 PM, Arnd Bergmann wrote:
> FWIW, you should be able to test this with an arm64 cross-compiler
> too, many distros ship one.

arm64 build fine for me with and without the patch.  There must be
something else specific to h8300 and the other broken architectures.

Is there some other part of the configuration that could be hiding the
issue in my arm64 build?
