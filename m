From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH 1/6] generic sys_old_select
Date: Tue, 2 Feb 2010 16:55:36 +0800
Message-ID: <a8e1da1002020055ua39ceceqeac9559961e256f5@mail.gmail.com>
References: <20100201185506.GA11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:54185 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0BBIzi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 03:55:38 -0500
In-Reply-To: <20100201185506.GA11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Hi,

On 02/01/2010 10:55 AM, Christoph Hellwig wrote:
[snip]
> +asmlinkage long sys_old_select(struct sel_arg_struct __user * arg);

A trival style problem: "foo * bar"

--
Regards
dave
