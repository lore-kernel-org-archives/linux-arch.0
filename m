Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49405 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXJ1S1d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Oct 2007 14:27:33 -0400
Message-ID: <4724D48B.6000207@zytor.com>
Date: Sun, 28 Oct 2007 11:27:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: struct user . u_ar0
References: <4723DDDD.8050900@zytor.com> <8bd0f97a0710280104k4784c7afo11b9d803e963ed13@mail.gmail.com>
In-Reply-To: <8bd0f97a0710280104k4784c7afo11b9d803e963ed13@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Mike Frysinger wrote:
> 
> Blackfin doesnt support a.out, so it may be easier to just change it
> to "reserved2" (assuming this structure is part of our ABI), or delete
> it (assuming the structure is internal to the kernel only).
> -mike

Blackfin explicitly sets in in arch/blackfin/kernel/process.c, so you 
might want to consider what it is used for.  As far as a.out is 
concerned, it appears to be part of the core dump format.

	-hpa

