From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: x86: platform: mrst: pr_err() need notice that
 'sdev->modalias' may not a NUL terminated string.
Date: Mon, 27 May 2013 16:16:41 +0800
Message-ID: <51A31669.7080309@asianux.com>
References: <51A1CCCE.1020103@asianux.com> <20130527070634.GA1494@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:44807 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab3E0IRc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 04:17:32 -0400
In-Reply-To: <20130527070634.GA1494@breakpoint.cc>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, zhangyanfei@cn.fujitsu.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>Thomas Gleixner <tglx@linutronix.de>

On 05/27/2013 03:06 PM, Sebastian Andrzej Siewior wrote:
> On Sun, May 26, 2013 at 04:50:22PM +0800, Chen Gang wrote:
>> > 
>> > According to the areas which use "%16.16s" within this file, the
>> > 'sdev->modalias' may not always be a NUL terminated string.
>> > 
>> > So need use "%.16s" instead of "%s" in pr_err(), or may cause issue.
> No. spi_match_id() expects a NULL terminated string and I would be suprised if
> it would be otherwise. Therefore moorsetown or this files has to learn to NULL
> terminate its strings.
> 

In spi_match_id(), it is 'spi_device', not 'spi_board_info'. ;-)

But all together, it is my fault, the original implementation has no
issue: "I treated SFI_NAME_LEN as SPI_NAME_LEN when strncpy()".

BTW: 'pentry->name' in sfi_parse_devs() may not always be a NUL
terminated string, could you give a check, too ?  ;-)


Thanks.
-- 
Chen Gang

Asianux Corporation
