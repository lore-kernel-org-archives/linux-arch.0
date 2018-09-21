Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.macqel.be ([109.135.2.61]:58094 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeIULpQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Sep 2018 07:45:16 -0400
Date: Fri, 21 Sep 2018 07:48:51 +0200
From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
Message-ID: <20180921054850.GA13343@frolo.macqel>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20180921054851.KW4DkVE6K6k7h4JhxX1W0g04j48GnfYRfpU4NLtw6cE@z>

On Thu, Sep 20, 2018 at 08:36:09PM +0530, Firoz Khan wrote:
> The system call table entries are present in syscalltable.S. One of
> the patch in this patch series will auto-generate the system call
> table entries using the system call table generation script and
> which'll replace the existig table file.
> 
> In order to come up with a common naming convention across all
> architecture, we need to change the file name to syscall_table.S.

That file was probably called that way to be able to distinguish it
from syscalltable.s and syscalltable.o in a file system with a 14
characters limit in file names (in sysV unix systems).

> This change will unify the implementation across all architecture.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/kernel/Makefile        |   2 +-
>  arch/m68k/kernel/syscall_table.S | 403 +++++++++++++++++++++++++++++++++++++++
>  arch/m68k/kernel/syscalltable.S  | 403 ---------------------------------------

You should generate your patch with the '-M' or '--find-renames' option.

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
