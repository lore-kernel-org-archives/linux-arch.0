Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKGAkc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 19:40:32 -0500
Date: Tue, 6 Nov 2018 18:14:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106151444.GA11221@avx2>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105233301.KlgdF%akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: willy@infradead.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
Message-ID: <20181106151444.2sJrIPCMmEgE7HvcjFeupnM4L3tFJGvzxw6d4nYcwiM@z>

On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:

> -static inline int fls(int x)
> +static inline int fls(unsigned int x)
>  {
> -	return fls64((unsigned int) x);
> +	return fls64(x);
>  }

Should it return "unsigned"? Logically it should.
I remember doing this and there was some code size increase :-(
