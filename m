From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Tue, 28 Oct 2014 14:38:22 +0100
Message-ID: <2095416.INZmt8AD1y@wuerfel>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <1414139071-3818-30-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414139071-3818-30-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Friday 24 October 2014 16:24:31 Ley Foon Tan wrote:
> +DECLARE_EXPORT(__gcc_bcmp);
> +DECLARE_EXPORT(__divdi3);
> +DECLARE_EXPORT(__divsi3);
> +DECLARE_EXPORT(__moddi3);
> +DECLARE_EXPORT(__modsi3);
> +DECLARE_EXPORT(__udivdi3);
> +DECLARE_EXPORT(__udivmoddi4);
> +DECLARE_EXPORT(__udivsi3);
> +DECLARE_EXPORT(__umoddi3);
> +DECLARE_EXPORT(__umodsi3);
> +DECLARE_EXPORT(__muldi3);
> 

I don't remember what all of these are, but at least some of them seem
to be concerned with 64-bit division. By convention, we don't provide those
in the Linux kernel but instead require all code to use the do_div()
macro instead.

	Arnd
