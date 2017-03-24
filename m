From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] vmlinux.lds: add __clkevt_of_table to kernel
Date: Fri, 24 Mar 2017 09:54:13 +0100
Message-ID: <457c9f52-ee5c-a67f-1440-35e851b62e7b@linaro.org>
References: <1490192947-21465-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35342 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdCXIy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2017 04:54:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id u132so7444192wmg.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2017 01:54:25 -0700 (PDT)
In-Reply-To: <1490192947-21465-1-git-send-email-al.kochet@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Kochetkov <al.kochet@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 22/03/2017 15:29, Alexander Kochetkov wrote:
> The code introduced by commit 0c8893c9095d ("clockevents: Add a
> clkevt-of mechanism like clksrc-of") refer to __clkevt_of_table
> what doesn't exist in the vmlinux. As a result kernel build
> failed with error: "clkevt-probe.c:63: undefined reference to
> `__clkevt_of_table’"
> 
> Fixes: 0c8893c9095d ("clockevents: Add a clkevt-of mechanism like clksrc-of")
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---

Arnd,

I would like to take this patch through my tree.

Is it ok for you ?

Thanks.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
