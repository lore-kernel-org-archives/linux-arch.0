From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/28] nios2: Exception handling
Date: Tue, 22 Apr 2014 14:33:17 +0200
Message-ID: <201404221433.17861.arnd@arndb.de>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <1397824031-4892-4-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:55478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbaDVMdY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 08:33:24 -0400
In-Reply-To: <1397824031-4892-4-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Friday 18 April 2014, Ley Foon Tan wrote:
> +static const struct file_operations misalign_fops = {
> +       .open           = proc_misaligned_open,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = single_release,
> +       .write          = proc_misaligned_write,
> +};
> +#endif /* CONFIG_PROC_FS */

We really shouldn't be doing new architecture specific procfs files
any more. I suggest you drop this one for now, and add back the
functionality using perf or ftrace at a later point.

	Arnd
