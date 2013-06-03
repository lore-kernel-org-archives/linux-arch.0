From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: parisc: kernel: using strlcpy() instead of strcpy()
Date: Mon, 03 Jun 2013 16:55:42 +0800
Message-ID: <51AC5A0E.4080408@asianux.com>
References: <51A6A8F3.2030200@asianux.com> <20130530153551.GN19205@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:64518 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab3FCI4b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2013 04:56:31 -0400
In-Reply-To: <20130530153551.GN19205@redacted.bos.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kmcmarti@redhat.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, udknight@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 05/30/2013 11:35 PM, Kyle McMartin wrote:
> On Thu, May 30, 2013 at 09:18:43AM +0800, Chen Gang wrote:
>> > 
>> > 'boot_args' is an input args, and 'boot_command_line' has a fix length.
>> > 
>> > So need use strlcpy() instead of strcpy() to avoid memory overflow.
>> > 
> This is basically impossible, since boot_args is fixed in size by palo,
> initialized to zero, and length checked in the bootloader. It's also
> only 256+4 bytes compared to the 1024 bytes set aside for
> boot_command_line.
> 
> That said, it's harmless to use strlcpy here, and obviously (more)
> correct. Thanks!
> 

OK, thanks.

> Acked-by: Kyle McMartin <kyle@mcmartin.ca>
> 
> 

Thank you. :-)


-- 
Chen Gang

Asianux Corporation
