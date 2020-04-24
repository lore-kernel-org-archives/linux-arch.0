Return-Path: <SRS0=iE4N=6I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:32783 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXR73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 13:59:29 -0400
Date: Fri, 24 Apr 2020 19:59:23 +0200
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424175923.4f5y7xfp4w2wlm7b@wunner.de>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
 <20200424150058.xadjxaga3csh3br6@wunner.de>
 <20200424150828.GA5034@icarus>
 <20200424163410.GD185537@smile.fi.intel.com>
 <20200424163904.GA7742@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424163904.GA7742@icarus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Syed Nayyar Waris <syednwaris@gmail.com>, akpm@linux-foundation.org, arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200424175923.oOxkN4oavtv9sW3QnS5CHCDwj_7eoCAO1W952uxOmE4@z>

On Fri, Apr 24, 2020 at 12:42:00PM -0400, William Breathitt Gray wrote:
> Within this patchset the only non-8-bit users are gpio-thunderx and
> gpio-xilinix. The gpio-xilinx has configurable port widths so in some
> instances it can behave like the 8-bit users, but not always.
> 
> If you want to keep the existing for_each_set_clump8 and related
> functions, ignore [PATCH 3/6] and [PATCH 4/6]. That should allow this
> patchset to be just an introduction of the new generic functions without
> affecting the existing 8-bit users.

Yes I don't mind the changes to gpio-thunderx and gpio-xilinx at all
but please leave the 8-bit users as they are wherever possible.
Actually my concern is not just performance but the existing 8-bit
variant is simpler to understand than the generic variant,
making it easier to follow the code in the drivers.

Thanks,

Lukas
