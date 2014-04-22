Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:57359 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440AbaDVMig (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2014 08:38:36 -0400
Date: Tue, 22 Apr 2014 14:28:56 +0200
From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 28/28] Documentation: Add documentation for Nios2
 architecture
Message-ID: <20140422122856.GA1053@distanz.ch>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-25-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397824031-4892-25-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140422122856.-JCSFMC92ko9Wm8sc8K5mGMrLDVyk7ugnCMwIZTw82I@z>

On 2014-04-18 at 14:27:11 +0200, Ley Foon Tan <lftan@altera.com> wrote:
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  Documentation/nios2/README | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/nios2/README
> 
> diff --git a/Documentation/nios2/README b/Documentation/nios2/README
> new file mode 100644
> index 0000000..33eec4d
> --- /dev/null
> +++ b/Documentation/nios2/README
> @@ -0,0 +1,23 @@
> +Linux on the Nios II architecture
> +=================================
> +
> +This is a port of Linux to Nios II (nios2) processor.
> +
> +In order to compile for Nios II, you need a version of GCC with support for the generic
> +system call ABI. Please see this link for more information on how compiling and booting
> +software for the Nios II platform:
> +http://www.rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
> +
> +For reference, please see the following link:
> +http://www.altera.com/literature/lit-nio2.jsp
> +
> +What is Nios II?
> +================
> +Nios II is a 32-bit embedded-processor architecture designed specifically for the
> +Altera family of FPGAs. In order to support Linux system, Nios II needs to configure

Minor nit: 'In order to support Linux, Nios II needs to be configured...'

> +with MMU and hardware multiplier enabled.

> +
> +Nios II ABI
> +===========
> +Please refer to chapter "Application Binary Interface" in Nios II Processor Reference
> +Handbook.
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
