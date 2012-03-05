From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] device.h: audit and cleanup users in main include dir
Date: Mon, 5 Mar 2012 11:06:36 +0100
Message-ID: <CACRpkdYpj4mvNfsA9bSEPLrehJ-0ydiyREuX+W2fyq0vnV1wtQ@mail.gmail.com>
References: <1330907657-2156-1-git-send-email-paul.gortmaker@windriver.com>
	<1330907657-2156-3-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49595 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab2CEKGh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Mar 2012 05:06:37 -0500
Received: by iagz16 with SMTP id z16so5325008iag.19
        for <linux-arch@vger.kernel.org>; Mon, 05 Mar 2012 02:06:36 -0800 (PST)
In-Reply-To: <1330907657-2156-3-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 5, 2012 at 1:34 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The <linux/device.h> header includes a lot of stuff, and
> it in turn gets a lot of use just for the basic "struct device"
> which appears so often.
(...)
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Why not...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

(For pl022, ab5x00)

Thanks,
Linus Walleij
