Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33393 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIKAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 06:00:33 -0400
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/4] m68k: Added system call table generation support
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
        <1533791723-3882-4-git-send-email-firoz.khan@linaro.org>
Date: Thu, 09 Aug 2018 09:36:56 +0200
In-Reply-To: <1533791723-3882-4-git-send-email-firoz.khan@linaro.org> (Firoz
        Khan's message of "Thu, 9 Aug 2018 10:45:22 +0530")
Message-ID: <mvmftzoq9d3.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20180809073656.Pz-pTIkKfsdKb9pwBShufF0IDT22oZPWPJHVdVXgk7U@z>

On Aug 09 2018, Firoz Khan <firoz.khan@linaro.org> wrote:

> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
> +	  $(shell [ -d '$(out)' ] || mkdir -p '$(out)')

mkdir -p is a no-op if the directory exits.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
